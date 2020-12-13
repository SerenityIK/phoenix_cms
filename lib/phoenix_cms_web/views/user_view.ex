defmodule PhoenixCmsWeb.UserView do
  use PhoenixCmsWeb, :view


  def check_role(conn) do
    case conn.assigns.current_user.role_id do
      1 -> true
      2 -> true
      _ -> false
    end
  end

  def roles_for_select(roles) do
    roles
    |> Enum.map(&["#{&1.role}": &1.id])
    |> List.flatten()
  end
end
