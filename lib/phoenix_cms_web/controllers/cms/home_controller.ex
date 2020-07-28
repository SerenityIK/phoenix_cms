defmodule PhoenixCmsWeb.Cms.HomeController do

  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Content


  def index(conn, _params) do
    user = conn.assigns.current_user

    if user.role_id == 1 do
      posts = Content.list_posts()
      conn
      |> context(posts)
    else
      posts = Content.list_posts(user.id)
      conn
      |> context(posts)
    end
  end

  def context(conn, posts) do
    context = %{
      total_posts: length(posts),
      published_posts: Enum.count(posts, & &1.published),
      draft_posts: Enum.count(posts, & not &1.published)
    }
    render(conn, "index.html", context: context)
  end
end
