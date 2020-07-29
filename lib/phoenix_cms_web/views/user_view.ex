defmodule PhoenixCmsWeb.UserView do
  use PhoenixCmsWeb, :view

  def roles_for_select(roles) do
    roles
    |> Enum.map(&["#{&1.role}": &1.id])
    |> List.flatten()
  end
end
