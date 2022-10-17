defmodule AglogRobotWeb.WebController do
  use AglogRobotWeb, :controller

  def index(conn, _params) do
    conn |> send_resp(200, render_elm_app())
  end

  defp render_elm_app() do
    Application.app_dir(:aglog_robot, "priv/static/web/index.html")
    |> File.read!()
  end
end
