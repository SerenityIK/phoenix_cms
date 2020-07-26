defmodule PhoenixCmsWeb.Cms.PostController do

  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Content
  alias PhoenixCms.Content.Post
  alias PhoenixCms.Accounts

  plug :authorize_user when action in [:edit, :update, :delete]


  def index(conn, _) do
    posts = Content.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _) do
    changeset = Post.create_changeset(%Post{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => params}) do
    user = Accounts.get_current_user(conn)
    with {:ok, _post} <- Content.create_post(params, user) do
      redirect(conn, to: Routes.cms_post_path(conn, :index))
    else
      {:error, changeset} ->
        render(conn, "new.html", changeset: %{changeset | action: :new})
    end
  end

  def show(conn, %{"id" => slug}) do
    with %Post{} = post <- Content.get_post!(slug) do
      render(conn, "show.html", post: post)
    end
  end

  def edit(conn, %{"id" => id} = params) do
    with %Post{} = post <- Content.get_post!(id) do
      changeset = Post.create_changeset(post, params)
      render(conn, "edit.html", changeset: changeset, id: id)
    end
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

  def publish(conn, %{"post_id" => id}) do
    with %Post{} = post <- Content.get_post!(id),
         {:ok, _post} <- Content.publish_post(post) do
            redirect(conn, to: Routes.cms_post_path(conn, :index))
    end
  end

  def delete(conn, _) do
    {:ok, _post} = Content.delete_post(conn.assigns.post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.cms_post_path(conn, :index))
  end

  defp authorize_user(conn, _) do
    post = Content.get_post!(conn.params["id"])

    if conn.assigns.current_user.id == post.user_id do
      assign(conn, :post, post)
    else
      conn
      |> put_flash(:error, "You cant modify that")
      |> redirect(to: Routes.cms_post_path(conn, :index))
      |> halt()
    end
  end

end
