defmodule BlogDemoReactWeb.CommentController do
  use BlogDemoReactWeb, :controller

  alias BlogDemoReact

  def index(conn, %{"post_id" => post_id}) do
    post = BlogDemoReact.get_post!(post_id)

    conn
    |> assign_prop(:post, post)
    |> assign_prop(:comments, post.comments)
    |> render_inertia("ListComments")
  end
end
