defmodule BlogDemoSvelte.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogDemoSvelte.Post

  @derive {Jason.Encoder, only: [:id, :author, :body]}
  schema "comments" do
    field :author, :string
    field :body, :string

    belongs_to :post, Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:author, :body])
    |> validate_required([:author, :body])
  end
end
