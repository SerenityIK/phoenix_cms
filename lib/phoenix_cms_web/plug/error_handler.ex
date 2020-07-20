defmodule PhoenixCms.GuardianErrorHandler do
  use PhoenixCmsWeb, :controller

  def auth_error(conn, _, _opts) do
    conn
    |> put_flash(:error, "Sign in to continue")
    |> redirect(to: Routes.siession_path(conn, :new))
  end
end
