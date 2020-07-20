defmodule PhoenixForum.Forum do
  @moduledoc """
  The Forum context.
  """

  import Ecto.Query, warn: false

  alias PhoenixForum.Repo
  alias PhoenixForum.Forum.Thread
  alias PhoenixForum.Forum.Reply

  @doc """
  Returns the list of threads.

  ## Examples

      iex> list_threads()
      [%Thread{}, ...]

  """
  def get_thread_with_replies(id) do
    Repo.get!(Thread, id)
    |>Repo.preload(:replies)
  end

  def list_all_threads() do

    query = from t in Thread,
            order_by: [desc: t.inserted_at]

    Repo.all(query)
    |> Repo.preload(:replies)
    |> count_replies()
  end

  def count_replies(threads) do
     Enum.map(threads, fn t -> Map.put(t, :replies_count, Enum.count(t.replies)) end)
  end

  @doc """
  Gets a single thread.

  Raises `Ecto.NoResultsError` if the Thread does not exist.

  ## Examples

      iex> get_thread!(123)
      %Thread{}

      iex> get_thread!(456)
      ** (Ecto.NoResultsError)

  """
  def get_thread!(id), do: Repo.get!(Thread, id)

  @doc """
  Creates a thread.

  ## Examples

      iex> create_thread(%{field: value})
      {:ok, %Thread{}}

      iex> create_thread(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_thread(attrs \\ %{}) do
    %Thread{}
    |> Thread.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking thread changes.

  ## Examples

      iex> change_thread(thread)
      %Ecto.Changeset{data: %Thread{}}

  """
  def change_thread(%Thread{} = thread, attrs \\ %{}) do
    Thread.changeset(thread, attrs)
  end


  def change_reply(%Reply{} = reply, attrs \\ %{})do
    Reply.changeset(reply, attrs)
  end

  def create_reply(thread_id ,attrs \\ %{}) do
    thread = get_thread!(thread_id)
    %Reply{}
    |>Reply.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:thread, thread)
    |> Repo.insert()

  end


end
