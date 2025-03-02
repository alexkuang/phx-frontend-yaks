defmodule BlogDemoReact.Repo do
  use Ecto.Repo,
    otp_app: :blog_demo_react,
    adapter: Ecto.Adapters.Postgres
end
