defmodule PhoenixCmsWeb.Plug.Auth do

  use Guardian.Plug.Pipeline,
    otp_app: :phoenix_cms,
    error_handler: PhoenixCmsWeb.AuthErrorHandler,
    module: PhoenixCms.Accounts.Guardian

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true

end
