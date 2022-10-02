defmodule AglogRobotWeb.GeneratorController do
  use AglogRobotWeb, :controller

  def show(conn, %{"name" => name}) do
    text(conn, AglogRobot.Generator.generate_logs(name))
  end
end
