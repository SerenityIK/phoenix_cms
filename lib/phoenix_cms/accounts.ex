defmodule PhoenixCms.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  import Plug.Conn

  alias PhoenixCms.Repo
  alias PhoenixCms.Accounts.Guardian
  alias PhoenixCms.Accounts.User


  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def is_current_user_admin?(conn) do
    user = Guardian.Plug.current_resource(conn)
    case user do
      nil -> false
      user -> user.is_admin
    end
  end

  def authenticate_user(email, given_password) do
    query = Ecto.Query.from(u in User, where: u.email == ^email)
    Repo.one(query)
    |> check_password(given_password)
  end

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
    # |> assign(:current_user, user.id)
  end

  def logout(conn) do
    conn
    |> Guardian.Plug.sign_out()
  end

  # Private functions

  defp check_password(nil, _), do: {:error, "Wrong email or password"}

  defp check_password(user, given_password) do
    case Argon2.verify_pass(given_password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, "Wrong email or password"}
    end
  end

end
