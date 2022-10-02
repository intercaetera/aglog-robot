defmodule AglogRobotWeb.Router do
  use AglogRobotWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AglogRobotWeb do
    pipe_through :api
    get "/:name", GeneratorController, :show
  end
end
