defmodule PhoenixCmsWeb.BlogController do
  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Content
  alias PhoenixCms.Content.Post


  def index(conn, _) do
    posts = Content.get_published_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => slug}) do
    with %Post{} = post <- Content.get_post!(slug, true) do
      render(conn, "show.html", post: post)
    end
  end
end
