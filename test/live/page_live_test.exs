defmodule ContactFormWeb.PageLiveTest do
  @moduledoc false
  use ContactFormWeb.ConnCase

  import Phoenix.LiveViewTest

  describe("Contact Form ") do
    test "form renders correctly", %{conn: conn} do
      # Opens a LiveView session and fetches the HTML of the rendered form

      {:ok, _live_view, html} = live(conn, Routes.page_index_path(conn, :index))
      # Checks that the HTML contains the expected text for form fields and buttons

      assert html =~ "First Name"
      assert html =~ "Last Name"

      assert html =~ "Email Address"

      assert html =~ "Query Type"

      assert html =~ "Message"
      assert html =~ "I consent to being contacted by the team"
      assert html =~ "Submit"
    end

    test "cannot submit form with invalid inputs", %{conn: conn} do
      {:ok, live_view, _html} = live(conn, Routes.page_index_path(conn, :index))
      # Simulate filling out the form with invalid data

      live_view
      |> form("#contact-request-form",
        client: %{
          first_name: "",
          last_name: "",
          email: "examplegmail.com",
          query_type: "General inquiry",
          message: "this is a message",
          contact_consent: false
        }
      )
      # Submit the form with invalid data
      |> render_submit()

      # Check that the form displays appropriate error messages

      assert render(live_view) =~ "This field is required"
      assert render(live_view) =~ "To submit this form, please consent to being contacted"
      assert render(live_view) =~ "please enter a valid email address"
    end

    test "submits with valid inputs", %{conn: conn} do
      {:ok, live_view, _html} = live(conn, Routes.page_index_path(conn, :index))
      # Simulate filling out the form with valid data

      live_view
      |> form("#contact-request-form",
        client: %{
          first_name: "John",
          last_name: "Doe",
          email: "example@gmail.com",
          query_type: "General inquiry",
          message: "this is a message",
          contact_consent: true
        }
      )
      # Submit the form with valid data
      |> render_submit()

      # Check that the form displays a success message

      assert render(live_view) =~ "Thanks for completing the form,we&#39;ll be in touch soon!"
    end
  end
end
