# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :saint_santa,
  ecto_repos: [SaintSanta.Repo]

# Configures the endpoint
config :saint_santa, SaintSantaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2u5n35o2hG37B1YVp8XmF2iXQvdj8e7aTToV8UEdp+IewDcs9Gdho8Gz7DJIw3nZ",
  render_errors: [view: SaintSantaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SaintSanta.PubSub,
  live_view: [signing_salt: "AhgQasSD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
