defmodule BlogDemoSvelteWeb.PostsLive.Form do
  @moduledoc false
  use BlogDemoSvelteWeb, :live_view
  use LiveSvelte.Components

  alias BlogDemoSvelte

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("create_post", params, socket) do
    params = Map.put(params, "author", Ecto.UUID.generate())

    case BlogDemoSvelte.create_post(params) do
      {:ok, _post} ->
        {:noreply,
         socket
         |> redirect(to: ~p"/posts")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(:formErrors, to_form_errors(changeset))}
    end
  end

  # any built-in way to do this in live_svelte?
  defp to_form_errors(%Ecto.Changeset{} = changeset) do
    Map.new(changeset.errors, fn {error_key, {msg, _meta}} ->
      {error_key, msg}
    end)
  end
end
