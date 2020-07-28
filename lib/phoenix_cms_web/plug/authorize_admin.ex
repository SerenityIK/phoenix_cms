defmodule PhoenixCmsWeb.Plug.AuthorizeAdmin do

  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Repo


  def init(default), do: default

  def call(conn, _) do

    if conn.assigns.current_user.role_id == 1 do
      conn
    else
      conn
      |> put_flash(:error, "You're not authorized for this action")
      |> redirect(to: Routes.cms_post_path(conn, :index))
      |> halt()
    end
  end

end
