defmodule PhoenixCmsWeb.BlogController do
  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Content.Blog
  alias PhoenixCms.Content.Post


  def index(conn, _) do
    posts = Blog.get_published_posts()
    render(conn, "index.html", posts: posts)
  end

end
