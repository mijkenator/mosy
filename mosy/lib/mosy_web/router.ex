defmodule MosyWeb.Router do
  use MosyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MosyWeb do
    pipe_through :api
    get  "/latest",  MonitoringController, :latest
    post "/oslevel",  MonitoringController, :oslevel
    post "/proclevel",  MonitoringController, :proclevel
  end
end
