defmodule SaintSantaWeb.SessionController do
  alias SaintSanta.Accounts
  use SaintSantaWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => pass}}) do
    case Accounts.autenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        conn
        |> SaintSantaWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:info, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> SaintSantaWeb.Auth.logout()
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
