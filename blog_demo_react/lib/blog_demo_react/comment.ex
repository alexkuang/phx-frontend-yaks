defmodule BlogDemoReact.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogDemoReact.Post

  @derive {Jason.Encoder, only: [:id, :post_id, :author, :body, :inserted_at]}
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
