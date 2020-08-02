defmodule PhoenixCmsWeb.BlogController do
  use PhoenixCmsWeb, :controller

  import Ecto

  alias PhoenixCms.Content
  alias PhoenixCms.Content.Comment
  alias PhoenixCms.Repo


  def index(conn, _) do
    posts = Content.get_published_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => slug}) do
    post = Content.get_post!(slug) |> Repo.preload(:comments)
    comment_changeset = post
      |> build_assoc(:comments)
      |> Comment.changeset()
    render(conn, "show.html", post: post, changeset: comment_changeset)
  end

end
