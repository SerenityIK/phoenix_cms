defmodule PhoenixCmsWeb.Plug.AuthErrorHandler do
  use PhoenixCmsWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, _, _opts) do
    conn
    |> put_flash(:error, "Sign in to continue")
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
