defmodule SaintSanta.Repo do
  use Ecto.Repo,
    otp_app: :saint_santa,
    adapter: Ecto.Adapters.Postgres
end
