defmodule BlogDemoSvelteWeb.CommentsLive.Form do
  @moduledoc false
  use BlogDemoSvelteWeb, :live_view
  use LiveSvelte.Components

  alias BlogDemoSvelte
  alias BlogDemoSvelte.Comment

  require Logger

  @impl true
  def mount(%{"post_id" => post_id}, _session, socket) do
    changeset = Comment.changeset(%Comment{}, %{})
    {:ok, socket |> assign(post: BlogDemoSvelte.get_post!(post_id), form: to_form(changeset))}
  end

  @impl true
  def handle_event("create_comment", %{"comment" => params}, socket) do
    params = Map.put(params, "author", Ecto.UUID.generate())
    post_id = socket.assigns.post.id

    case BlogDemoSvelte.create_comment(post_id, params) do
      {:ok, _comment} ->
        {:noreply,
         socket
         |> push_navigate(to: ~p"/posts/#{post_id}/comments")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(:form, to_form(changeset))}
    end
  end

  @impl true
  def handle_event("validate", params, socket) do
    changeset = Comment.changeset(%Comment{}, params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end
end
