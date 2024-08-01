defmodule ContactFormWeb.PageLiveTest do
  @moduledoc false
  use ContactFormWeb.ConnCase

  import Phoenix.LiveViewTest

  describe("Contact Form ") do
    test "form renders correctly", %{conn: conn} do
      {:ok, live_view, html} = live(conn, Routes.page_index_path(conn, :index))

      assert html =~ "First Name"
      assert html =~ "Last Name"

      assert html =~ "Email Address"

      assert html =~ "Query Type"

      assert html =~ "Message"
      assert html =~ "I consent to being contacted by the team"
      assert html =~ "Submit"
    end

    test "validates inputs", %{conn: conn} do
      {:ok, live_view, _html} = live(conn, Routes.page_index_path(conn, :index))

      live_view
      |> form("#contact-request-form",
        client: %{
          first_name: "John",
          last_name: "Doe",
          email: "invalid",
          query_type: "General inquiry",
          message: "this is a message",
          contact_consent: false
        }
      )
      |> render_change()

      refute render(live_view) =~ "can't be blank"
      assert render(live_view) =~ "please enter a valid email address"
    end

    test "cannot submit form with invalid inputs", %{conn: conn} do
      {:ok, live_view, _html} = live(conn, Routes.page_index_path(conn, :index))

      live_view
      |> form("#contact-request-form",
        client: %{
          first_name: "",
          last_name: "",
          email: "example@gmail.com",
          query_type: "General inquiry",
          message: "this is a message",
          contact_consent: false
        }
      )
      |> render_submit()

      assert render(live_view) =~ "can&#39;t be blank"
    end

    test "submits with valid inputs", %{conn: conn} do
      {:ok, live_view, _html} = live(conn, Routes.page_index_path(conn, :index))

      live_view
      |> form("#contact-request-form",
        client: %{
          first_name: "John",
          last_name: "Doe",
          email: "example@gmail.com",
          query_type: "General inquiry",
          message: "this is a message",
          contact_consent: false
        }
      )
      |> render_submit()

      assert render(live_view) =~ "Request  created successfully"
    end
  end
end
