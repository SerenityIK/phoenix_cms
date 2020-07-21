defmodule PhoenixCmsWeb.Admin.HomeController do
  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Content


  def index(conn, _params) do
    posts = Content.list_posts()
    context = %{
      total_posts: length(posts),
      published_posts: Enum.count(posts, & &1.published),
      draft_posts: Enum.count(posts, & not &1.published)
    }
    render(conn, "index.html", context: context)
  end

end
