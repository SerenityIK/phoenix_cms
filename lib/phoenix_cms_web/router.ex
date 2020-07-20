defmodule PhoenixCmsWeb.Router do
  use PhoenixCmsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plug.Auth
  end

  pipeline :authenticated do
    plug Plug.EnsureAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixCmsWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources("/blog", BlogController, only: [:index, :show])
    resources("/session", SessionController, only: [:create, :new, :delete])
  end

  scope "/admin", PhoenixCmsWeb, as: :admin do
    pipe_through :browser
    get "/", Admin.HomeController, :index
    resources("/post", Admin.PostController) do
      get "/publish", Admin.PostController, :publish, as: :publish
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixCmsWeb do
  #   pipe_through :api
  # end
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
    pipe_through(:browser)
    live_dashboard("/dashboard", metrics: ProjectPhoenixWeb.Telemetry)
    end
  end
end
