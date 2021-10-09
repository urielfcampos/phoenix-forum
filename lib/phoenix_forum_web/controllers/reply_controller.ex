defmodule PhoenixForumWeb.ReplyController do
  use PhoenixForumWeb, :controller
  alias PhoenixForum.Forum

  def create(conn, %{"reply" => reply_params, "thread_id" => thread_id}) do
    case Forum.create_reply(thread_id, reply_params) do
      {:ok, _reply} ->
        conn
        |> put_flash(:info, "Reply posted successfully")
        |> redirect(to: Routes.thread_path(conn, :show, thread_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        thread = PhoenixForum.Forum.get_thread_with_replies(thread_id)

        conn
        |> put_view(PhoenixForumWeb.ThreadView)
        |> render(:show, thread: thread, changeset: changeset)
    end
  end
end
