defmodule PhoenixCmsWeb.Plug.IsPrivileged do

  use PhoenixCmsWeb, :controller


  def init(default), do: default

  def call(conn, _) do
    role_id = conn.assigns.current_user.role_id

    if role_id <= 3 do
      conn
    else
      conn
      |> put_flash(:error, "You're not authorized for this action")
      |> redirect(to: Routes.blog_path(conn, :index))
      |> halt()
    end
  end

end
