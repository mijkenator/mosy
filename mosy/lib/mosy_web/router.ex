defmodule MosyWeb.Router do
  use MosyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MosyWeb do
    pipe_through :api
  end
end
