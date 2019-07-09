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
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:user_id, :module, :function, :pid]

#config :libcluster,
#  topologies: [
#    example: [
#      # The selected clustering strategy. Required.
#      strategy: Cluster.Strategy.Epmd,
#      # Configuration for the provided strategy. Optional.
#      config: [hosts: [:"srv0@server1", :"srv0@phoenix"]],
#      # The function to use for connecting nodes. The node
#      # name will be appended to the argument list. Optional
#      connect: {:net_kernel, :connect_node, []},
#      # The function to use for disconnecting nodes. The node
#      # name will be appended to the argument list. Optional
#      disconnect: {:erlang, :disconnect_node, []},
#      # The function to use for listing nodes.
#      # This function must return a list of node names. Optional
#      list_nodes: {:erlang, :nodes, [:connected]},
#    ]
#  ]

config :mosy, Mosy.Scheduler,
    jobs: [
        {"*/1 * * * *", {Mosy.Monitoring, :get_mon_data, []}}
    ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
