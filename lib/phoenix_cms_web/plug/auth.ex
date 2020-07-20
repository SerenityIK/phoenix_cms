defmodule PhoenixCms.Plug.Auth do

  use Guardian.Plug.Pipeline,
    otp_app: :phoenix_cms,
    error_handler: PhoenixCms.GuardianErrorHandler,
    module: PhoenixCms.Accounts.Guardian

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true

end
