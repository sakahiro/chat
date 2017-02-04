defmodule Chat.SessionController do
  use Chat.Web, :controller
  alias Chat.User

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case Chat.Session.login(session_params, Chat.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "ログインしました")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "メールアドレスかパスワードが間違っています")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "ログアウトしました")
    |> redirect(to: "/")
  end
end
