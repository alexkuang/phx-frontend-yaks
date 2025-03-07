defmodule BlogDemoSvelte.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add(:title, :string, null: false)
      add(:author, :string, null: false)
      add(:body, :text, null: false)

      timestamps(type: :utc_datetime)
    end
  end
end
