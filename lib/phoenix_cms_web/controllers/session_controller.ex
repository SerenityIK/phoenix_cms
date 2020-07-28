defmodule PhoenixCmsWeb.SessionController do
  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Accounts


  def new(conn, _), do: render(conn, "new.html")

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> Accounts.login(user)
        |> put_flash(:info, "Welcome back")
        |> put_session(:current_user, %{id: user.id, name: user.name})
        |> redirect(to: Routes.cms_home_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Wrong email or password")
        |> delete_session(:current_user)
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Accounts.logout()
    # |> put_flash(:info, "See you space cowboy")
    |> delete_session(:current_user)
    |> redirect(to: Routes.blog_path(conn, :index))
  end

end
