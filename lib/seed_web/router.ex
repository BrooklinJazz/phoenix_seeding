defmodule SeedWeb.Router do
  use SeedWeb, :router

  import SeedWeb.AuthorAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_author
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SeedWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SeedWeb do
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
      live_dashboard "/dashboard", metrics: SeedWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", SeedWeb do
    pipe_through [:browser, :redirect_if_author_is_authenticated]

    get "/authors/register", AuthorRegistrationController, :new
    post "/authors/register", AuthorRegistrationController, :create
    get "/authors/log_in", AuthorSessionController, :new
    post "/authors/log_in", AuthorSessionController, :create
    get "/authors/reset_password", AuthorResetPasswordController, :new
    post "/authors/reset_password", AuthorResetPasswordController, :create
    get "/authors/reset_password/:token", AuthorResetPasswordController, :edit
    put "/authors/reset_password/:token", AuthorResetPasswordController, :update
  end

  scope "/", SeedWeb do
    pipe_through [:browser, :require_authenticated_author]

    get "/authors/settings", AuthorSettingsController, :edit
    put "/authors/settings", AuthorSettingsController, :update
    get "/authors/settings/confirm_email/:token", AuthorSettingsController, :confirm_email
  end

  scope "/posts", SeedWeb do
    pipe_through [:browser]

    resources "/", PostController
  end

  scope "/", SeedWeb do
    pipe_through [:browser]

    delete "/authors/log_out", AuthorSessionController, :delete
    get "/authors/confirm", AuthorConfirmationController, :new
    post "/authors/confirm", AuthorConfirmationController, :create
    get "/authors/confirm/:token", AuthorConfirmationController, :confirm
  end
end
