defmodule PhoenixCmsWeb.CommentController do
  use PhoenixCmsWeb, :controller

  import Ecto

  alias PhoenixCms.Content.Comment
  alias PhoenixCmsWeb.PostView
  alias PhoenixCms.Content
  alias PhoenixCms.Repo

  plug :scrub_params, "comment" when action in [:create, :update]

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post = Content.get_post!(post_id) |> Repo.preload([:user, :comments])
    changeset = post
    |> build_assoc(:comments)
    |> Comment.changeset(comment_params)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created succesfully")
        |> redirect(to: Routes.blog_path(conn, :show, post.user_id, post))
      {:error, changeset} ->
        render(conn, PostView, "show.html", post: post, user: post.user_id, comment_changeset: changeset)
    end
  end

end
