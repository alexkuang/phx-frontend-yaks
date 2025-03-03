defmodule BlogDemoSvelte.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add(:author, :string, null: false)
      add(:body, :text, null: false)
      add(:post_id, references(:posts, on_delete: :nothing), null: false)

      timestamps(type: :utc_datetime)
    end

    create(index(:comments, [:post_id]))
  end
end
