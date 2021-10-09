defmodule PhoenixForum.Forum.Reply do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "replies" do
    field :author, :string
    field :body, :string
    belongs_to :thread, PhoenixForum.Forum.Thread

    timestamps()
  end

  @doc false
  def changeset(reply, attrs) do
    reply
    |> cast(attrs, [:author, :body])
    |> validate_required([:author, :body])
    |> validate_length(:author, min: 2, max: 255)
  end
end
