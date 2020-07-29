defmodule PhoenixCmsWeb.Plug.AuthorizeUser do

  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Accounts


  def init(default), do: default

  def call(conn, _) do
    user_acc = Accounts.get_user!(conn.params["id"])
    user = Accounts.get_user!(conn.assigns.current_user.id)

    if user.id == user_acc.id || user.role_id == 1 do
      assign(conn, :user_acc, user_acc)
    else
      conn
      |> put_flash(:error, "You can't modify that")
      |> redirect(to: Routes.user_path(conn, :index))
      |> halt()
    end
  end

end
