defmodule BlogDemoReactWeb.PostController do
  use BlogDemoReactWeb, :controller

  alias BlogDemoReact

  def index(conn, _params) do
    posts = BlogDemoReact.list_posts()

    conn
    |> assign_prop(:posts, posts)
    |> render_inertia("ListPosts")
  end
end
