defmodule PhoenixCmsWeb.Cms.PostController do

  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Content
  alias PhoenixCms.Content.Post

  plug PhoenixCmsWeb.Plug.AuthorizeAuthor when action not in [:index, :new, :create]


  def index(conn, _) do
    posts = Content.list_posts(conn.assigns.current_user.id)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _) do
    changeset = Post.changeset(%Post{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => params}) do
    case Content.create_post(conn.assigns.current_user, params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully")
        |> redirect(to: Routes.cms_post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, _) do
    changeset = Content.edit_post(conn.assigns.post)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"post" => post_params}) do
    case Content.update_post(conn.assigns.post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: Routes.cms_post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def publish(conn, _) do
    Content.publish_post(conn.assigns.post)
    redirect(conn, to: Routes.cms_post_path(conn, :index))
  end

  def delete(conn, _) do
    {:ok, _post} = Content.delete_post(conn.assigns.post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.cms_post_path(conn, :index))
  end

end
