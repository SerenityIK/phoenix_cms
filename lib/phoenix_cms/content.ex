defmodule PhoenixCms.Content do

  import Ecto.Query, warn: false

  alias PhoenixCms.Repo
  alias PhoenixCms.Content.Post


  def list_posts(id) do
    Repo.all(from p in Post, where: p.user_id == ^id, preload: :user)
  end

  def get_published_posts() do
    Repo.all(from p in Post, where: p.published == true, preload: :user)
  end

  def get_post!(id) do
    Post
    |> Repo.get!(id)
    |> Repo.preload([:user])
  end

  def get_post!(slug, true) do
    Repo.get_by(Post, slug: slug)
    |> Repo.preload([:user])
  end

  def create_post(user, post) do
    post = post
    |> Map.put("user_id", user.id)
    changeset = Post.create_changeset(%Post{}, post)
    case changeset.valid? do
      true -> Repo.insert(changeset)
      false -> {:error, changeset}
    end
  end

  def edit_post(%Post{} = post, params \\ %{}) do
    Post.create_changeset(post, params)
  end

  def update_post(post, params) do
    changeset = Post.common_changeset(post, params)
    case changeset.valid? do
      true -> Repo.update(changeset)
      false -> {:error, changeset}
    end
  end

  def publish_post(post) do
    Post.common_changeset(post, %{published: not post.published})
    |> Repo.update()
  end

  def delete_post(post) do
    Repo.delete(post)
  end

end
