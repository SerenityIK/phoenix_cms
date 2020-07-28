defmodule PhoenixCmsWeb.Router do
  use PhoenixCmsWeb, :router

  alias PhoenixCmsWeb.Plug


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
    plug Plug.AssignUser
  end

  pipeline :is_privileged? do
    plug Plug.IsPrivileged
  end

  # pipeline :api do
    # plug :accepts, ["json"]
  # end

  scope "/", PhoenixCmsWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources("/user", UserController, except: [:index])
    resources("/session", SessionController, only: [:create, :new, :delete])
    resources("/blog", BlogController, only: [:index, :show])
  end

  scope "/cms", PhoenixCmsWeb, as: :cms do
    pipe_through([:browser, :authenticated, :is_privileged?])

    get "/", Cms.HomeController, :index
    get "user", UserController, :index
    resources("/post", Cms.PostController) do
      get "/publish", Cms.PostController, :publish, as: :publish
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixCmsWeb do
  #   pipe_through :api
  # end
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
    pipe_through([:browser, :authenticated])
    live_dashboard("/dashboard", metrics: ProjectPhoenixWeb.Telemetry)
    end
  end
end
