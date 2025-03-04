defmodule BlogDemoSvelteWeb.CommentsLive.Index do
  @moduledoc false
  use BlogDemoSvelteWeb, :live_view
  use LiveSvelte.Components

  require Logger

  @impl true
  def mount(%{"post_id" => post_id}, _session, socket) do
    Phoenix.PubSub.subscribe(BlogDemoSvelte.PubSub, "post:#{post_id}")

    {:ok, socket |> assign(:post, BlogDemoSvelte.get_post!(post_id))}
  end

  @impl true
  def handle_info({:new_comment, _comment}, socket) do
    {:noreply, socket |> assign(:post, BlogDemoSvelte.get_post!(socket.assigns.post.id))}
  end
end
