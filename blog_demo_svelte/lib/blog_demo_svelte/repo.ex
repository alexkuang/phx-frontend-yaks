defmodule BlogDemoSvelte.Repo do
  use Ecto.Repo,
    otp_app: :blog_demo_svelte,
    adapter: Ecto.Adapters.Postgres
end
