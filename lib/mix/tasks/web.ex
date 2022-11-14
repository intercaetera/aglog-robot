defmodule Mix.Tasks.Web do
  use Mix.Task
  require Logger

  @public_path "./priv/static/web"

  def run(_) do
    Logger.info "Installing NPM packages"
    System.cmd("npm", ["install"], cd: "./frontend")

    Logger.info "Compiling Elm frontend"
    System.cmd("npm", ["run", "build"], cd: "./frontend")

    Logger.info("Clearing #{@public_path}")
    System.cmd("rm", ["-rf", @public_path])

    Logger.info("Copying compiled app to #{@public_path}")
    System.cmd("mkdir", ["-p", @public_path])
    System.cmd("cp", ["-R", "./frontend/dist", @public_path])

    Logger.info("Frontend is ready")
  end
end
