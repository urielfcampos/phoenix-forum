defmodule PhoenixForum.Forum.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :author, :string
    field :body, :string
    field :title, :string
    has_many :replies, PhoenixForum.Forum.Reply
    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:title, :author, :body])
    |> validate_required([:title, :author, :body])
    |> validate_length(:title, min: 2, max: 255)
    |> validate_length(:author, min: 2, max: 255)
  end
end
