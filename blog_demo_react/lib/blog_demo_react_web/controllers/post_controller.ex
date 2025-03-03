defmodule BlogDemoReactWeb.PostController do
  use BlogDemoReactWeb, :controller

  alias BlogDemoReact

  def new(conn, _params) do
    conn
    |> render_inertia("NewPost")
  end

  def create(conn, params) do
    params = Map.put(params, "author", Ecto.UUID.generate())

    case BlogDemoReact.create_post(params) do
      {:ok, _post} ->
        conn
        |> redirect(to: ~p"/posts")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/posts/new")
    end
  end

  def index(conn, _params) do
    posts = BlogDemoReact.list_posts()

    conn
    |> assign_prop(:posts, posts)
    |> render_inertia("ListPosts")
  end
end
