defmodule BlogDemoSvelteWeb.CommentsLive.Index2 do
  @moduledoc "like CommentsLive.Index but more svelte-centric approach"
  use BlogDemoSvelteWeb, :live_view
  use LiveSvelte.Components

  require Logger

  @impl true
  def mount(%{"post_id" => post_id}, _session, socket) do
    Phoenix.PubSub.subscribe(BlogDemoSvelte.PubSub, "post:#{post_id}")

    {:ok, socket |> assign(:post, BlogDemoSvelte.get_post!(post_id))}
  end

  @impl true
  def handle_info({:new_comment, comment}, socket) do
    {:noreply, socket |> push_event("new_comment", comment)}
  end
end
