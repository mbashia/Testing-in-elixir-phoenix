defmodule ContactFormWeb.PageController do
  use ContactFormWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
