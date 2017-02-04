defmodule Chat.RegistrationController do
  use Chat.Web, :controller
  alias Chat.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case User.create(changeset, Chat.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "ようこそ" <> changeset.params["email"])
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "アカウントを作成できませんでした")
        |> render("new.html", changeset: changeset)
    end
  end
end
