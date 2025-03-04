defmodule BlogDemoSvelte do
  @moduledoc """
  BlogDemoSvelte keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias BlogDemoSvelte.Comment
  alias BlogDemoSvelte.Post
  alias BlogDemoSvelte.Repo

  import Ecto.Query, warn: false

  def list_posts() do
    Post
    |> preload(:comments)
    |> Repo.all()
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

  def create_comment(post_id, attrs) do
    %Comment{post_id: post_id}
    |> Comment.changeset(attrs)
    |> Repo.insert()
    |> tap(fn
      {:ok, comment} ->
        Phoenix.PubSub.broadcast(
          BlogDemoSvelte.PubSub,
          "post:#{post_id}",
          {:new_comment, comment}
        )

      {:error, _} ->
        nil
    end)
  end
end
