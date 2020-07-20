defmodule PhoenixForum.Repo.Migrations.CreateReplies do
  use Ecto.Migration

  def change do
    create table(:replies) do
      add :author, :string
      add :body, :text
      add :thread_id, references(:threads, on_delete: :nothing)

      timestamps()
    end

    create index(:replies, [:thread_id])
  end
end
