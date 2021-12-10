defmodule SaintSantaWeb.Router do
  use SaintSantaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :fetch_flash
    plug :put_root_layout, {SaintSantaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SaintSantaWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SaintSantaWeb do
    pipe_through :browser

    live "/", PageLive, :index

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :create, :new]
    resources "/sessions", SessionController, only: [:create, :new, :delete]
  end

  scope "/manage", SaintSantaWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/videos", VideoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SaintSantaWeb do
  #   pipe_through :api
  # end
  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: SaintSantaWeb.Telemetry
    end
  end
end
