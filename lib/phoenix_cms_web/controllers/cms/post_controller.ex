defmodule PhoenixCmsWeb.Cms.PostController do

  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Content
  alias PhoenixCms.Content.Post
  alias PhoenixCms.Accounts


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

  def edit(conn, %{"id" => id} = params) do
    with %Post{} = post <- Content.get_post!(id) do
      changeset = Post.create_changeset(post, params)
      render(conn, "edit.html", changeset: changeset, id: id)
    end
  end

  def update(conn, %{"id" => id, "post" => params}) do
    with %Post{} = post <- Content.get_post!(id),
         {:ok, _post} <- Content.update_post(post, params) do
            redirect(conn, to: Routes.cms_post_path(conn, :index))
    end
  end

  def publish(conn, %{"post_id" => id}) do
    with %Post{} = post <- Content.get_post!(id),
         {:ok, _post} <- Content.publish_post(post) do
            redirect(conn, to: Routes.cms_post_path(conn, :index))
    end
  end

end
