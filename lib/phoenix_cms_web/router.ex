defmodule PhoenixCmsWeb.Router do
  use PhoenixCmsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
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
    resources("/post", Admin.Postcontroller) do
      get "/publish", Admin.Postcontroller, :publish, as: :publish
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixCmsWeb do
  #   pipe_through :api
  # end
end
