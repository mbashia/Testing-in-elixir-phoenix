defmodule ContactFormWeb.PageControllerTest do
  use ContactFormWeb.ConnCase

  test "GET /phoenix", %{conn: conn} do
    conn = get(conn, "/phoenix")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
