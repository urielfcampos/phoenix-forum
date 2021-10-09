defmodule PhoenixForumWeb.ThreadController do
  use PhoenixForumWeb, :controller

  alias PhoenixForum.Forum
  alias PhoenixForum.Forum.Thread
  alias PhoenixForum.Forum.Reply

  def index(conn, _params) do
    threads = Forum.list_all_threads()
    render(conn, "index.html", threads: threads)
  end

  def new(conn, _params) do
    changeset = Forum.change_thread(%Thread{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"thread" => thread_params}) do
    case Forum.create_thread(thread_params) do
      {:ok, thread} ->
        conn
        |> put_flash(:info, "Thread created successfully.")
        |> redirect(to: Routes.thread_path(conn, :show, thread))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    thread = Forum.get_thread_with_replies(id)
    changeset = Forum.change_reply(%Reply{})
    render(conn, "show.html", thread: thread, changeset: changeset)
  end
end
