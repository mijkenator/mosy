mix archive.install phx_new.ez
mix phx.new --no-brunch --no-html mosy

We are all set! Go into your application by running:

    $ cd mosy

Then configure your database in config/dev.exs and run:

    $ mix ecto.create
mix deps.get

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server
