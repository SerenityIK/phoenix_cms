defmodule PhoenixCms.Plug.EnsureAuth do

  use Guardian.Plug.Pipeline,
    otp_app: :phoenix_cms,
    module: PhoenixCms.Accounts.Guardian

  plug Guardian.Plug.EnsureAuthenticated

end
