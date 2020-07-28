defmodule PhoenixCmsWeb.Plug.AssignUser do

  import Plug.Conn


  def init(default), do: default

  def call(conn, _default) do
    assign(conn, :current_user, Guardian.Plug.current_resource(conn))
  end
end
