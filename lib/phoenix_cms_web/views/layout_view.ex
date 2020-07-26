defmodule PhoenixCmsWeb.LayoutView do
  use PhoenixCmsWeb, :view

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end
end
