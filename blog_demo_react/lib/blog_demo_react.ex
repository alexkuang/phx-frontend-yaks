defmodule BlogDemoReact do
  @moduledoc """
  BlogDemoReact keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias BlogDemoReact.Post
  alias BlogDemoReact.Repo

  import Ecto.Query, warn: false

  def list_posts() do
    Repo.all(Post)
  end

  def create_post(attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def get_post!(id) do
    Post
    |> preload(:comments)
    |> Repo.get!(id)
  end

  def get_post(id) do
    Post
    |> preload(:comments)
    |> Repo.get(id)
  end
end
