defmodule BlogDemoReactWeb.CommentController do
  use BlogDemoReactWeb, :controller

  alias BlogDemoReact

  def new(conn, %{"post_id" => post_id}) do
    conn
    |> assign_prop(:post_id, post_id)
    |> render_inertia("NewComment")
  end

  def create(conn, %{"post_id" => post_id} = params) do
    post = BlogDemoReact.get_post!(post_id)
    params = Map.put(params, "author", Ecto.UUID.generate())

    case BlogDemoReact.create_comment(post.id, params) do
      {:ok, _comment} ->
        conn
        |> redirect(to: ~p"/posts/#{post_id}/comments")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/posts/#{post_id}/comments/new")
    end
  end

  def index(conn, %{"post_id" => post_id}) do
    post = BlogDemoReact.get_post!(post_id)

    conn
    |> assign_prop(:post, post)
    |> assign_prop(:comments, post.comments)
    |> render_inertia("ListComments")
  end
end
