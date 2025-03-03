defmodule BlogDemoReact.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogDemoReact.Comment

  @derive {Jason.Encoder, only: [:id, :title, :author, :body]}
  schema "posts" do
    field :title, :string
    field :author, :string
    field :body, :string

    has_many :comments, Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :author, :body])
    |> validate_required([:title, :author, :body])
  end
end
