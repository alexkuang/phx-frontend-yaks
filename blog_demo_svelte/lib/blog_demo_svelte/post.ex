defmodule BlogDemoSvelte.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :author, :body]}
  schema "posts" do
    field :title, :string
    field :author, :string
    field :body, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :author, :body])
    |> validate_required([:title, :author, :body])
  end
end
