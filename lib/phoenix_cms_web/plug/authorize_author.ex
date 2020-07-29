defmodule PhoenixCmsWeb.Plug.AuthorizeAuthor do

  use PhoenixCmsWeb, :controller

  import Plug.Conn

  alias PhoenixCms.Content


  def init(default), do: default

  def call(conn, _) do
    post = Content.get_post!(conn.params["id"])
    user = conn.assigns.current_user.id

    if user.id == post.user_id && user.role_id == 3 || user.role_id == 1 do
      assign(conn, :post, post)
    else
      conn
      |> put_flash(:error, "You can't modify that")
      |> redirect(to: Routes.cms_post_path(conn, :index))
      |> halt()
    end
  end

end
