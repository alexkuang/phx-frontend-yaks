defmodule BlogDemoSvelteWeb.Router do
  use BlogDemoSvelteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BlogDemoSvelteWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlogDemoSvelteWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/posts", PostsLive.Index, :index
    live "/posts/new", PostsLive.Form, :new

    live "/posts/:post_id/comments", CommentsLive.Index, :index
    live "/posts/:post_id/comments/new", CommentsLive.Form, :new

    live "/posts/:post_id/comments2", CommentsLive.Index2, :index2
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogDemoSvelteWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:blog_demo_svelte, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BlogDemoSvelteWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
