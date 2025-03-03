defmodule BlogDemoReact do
  @moduledoc """
  BlogDemoReact keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias BlogDemoReact.Post
  alias BlogDemoReact.Repo

  def list_posts() do
    Repo.all(Post)
  end

  def create_post(attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end
end
