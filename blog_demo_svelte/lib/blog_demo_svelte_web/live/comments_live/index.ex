defmodule BlogDemoSvelteWeb.CommentsLive.Index do
  @moduledoc false
  use BlogDemoSvelteWeb, :live_view
  use LiveSvelte.Components

  require Logger

  @impl true
  def mount(%{"post_id" => post_id}, _session, socket) do
    {:ok, socket |> assign(:post, BlogDemoSvelte.get_post!(post_id))}
  end
end
