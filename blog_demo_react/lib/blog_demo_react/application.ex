defmodule BlogDemoReact.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BlogDemoReactWeb.Telemetry,
      BlogDemoReact.Repo,
      {DNSCluster, query: Application.get_env(:blog_demo_react, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BlogDemoReact.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BlogDemoReact.Finch},
      # Start a worker by calling: BlogDemoReact.Worker.start_link(arg)
      # {BlogDemoReact.Worker, arg},
      # Start to serve requests, typically the last entry
      BlogDemoReactWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BlogDemoReact.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BlogDemoReactWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
