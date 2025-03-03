defmodule BlogDemoSvelteWeb.PostsLive.Index do
  @moduledoc false
  use BlogDemoSvelteWeb, :live_view
  use LiveSvelte.Components

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:posts, BlogDemoSvelte.list_posts())}
  end
end
