defmodule PhoenixCmsWeb.BlogController do
  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Content.Blog
  alias PhoenixCms.Content.Post


  def index(conn, _) do
    posts = Blog.get_published_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => slug}) do
    with %Post{} = post <- Blog.get(slug, true) do
      reneder(conn, "show.html", post: post)
    end
  end
end
