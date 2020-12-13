alias PhoenixCms.Repo
alias PhoenixCms.Accounts.Role
alias PhoenixCms.Accounts.User

role = %Role{}
  |> Role.changeset(%{role: "admin"})
  |> Repo.insert!()

_role_2 = %Role{}
  |> Role.changeset(%{role: "moderator"})
  |> Repo.insert!()

_role_3 = %Role{}
  |> Role.changeset(%{role: "author"})
  |> Repo.insert!()

_role_4 = %Role{}
  |> Role.changeset(%{role: "user"})
  |> Repo.insert!()

_admin = %User{}
  |> User.changeset(%{name: "admin", email: "admin@example.com", password: "admin1234", role_id: role.id})
  |> Repo.insert!()
