alias PhoenixCms.Repo
alias PhoenixCms.Role
alias PhoenixCms.Accounts.User

role = %Role{}
  |> Role.changeset(%{role: "admin", is_admin: true})
  |> Repo.insert!()
admin = %User{}
  |> User.changeset(%{name: "admin", email: "admin@example.com", password: "admin1234", role_id: role.id})
  |> Repo.insert!()
