# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mosy,
  ecto_repos: [Mosy.Repo]

# Configures the endpoint
config :mosy, MosyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qqIX47Ka8Lm2dHZSzUB4y+xdrnN4cNEg5FBBrGdJjQh1Vgja2vCM7ZEUYJ1GHUdC",
  render_errors: [view: MosyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Mosy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
