defmodule PhoenixCmsWeb.Plug.AuthorizeUser do

  def init(default), do: default

  def call(conn, _) do
    user = conn.assigns.current_user

    conn 
  end
end
