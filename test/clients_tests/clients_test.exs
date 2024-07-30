defmodule ContactFormWeb.ClientsTest do
  use ContactFormWeb.ConnCase
  #   use ExUnit.Case, async: true

  alias ContactForm.ClientsRequests.Client
  alias ContactForm.ClientsRequests.Clients

  test "create_contact_request_record/1" do
    attrs = %{
      first_name: "John",
      last_name: "Doe",
      email: "johndoe@gmail.com",
      query_type: "General inquiry",
      message: "this is a message",
      contact_consent: false
    }

    assert {:ok, record} = Clients.create_contact_request_record(attrs)
    assert record.first_name == "John"
    assert record.last_name == "Doe"
    assert record.email == "johndoe@gmail.com"
    assert record.query_type == "General inquiry"
    assert record.message == "this is a message"
    assert record.contact_consent == false
  end

  test "change_contact_form/2" do
    client = %Client{}
    attrs = %{first_name: "John", last_name: "Doe", email: "john@example.com"}

    assert changeset = Clients.change_contact_form(client, attrs)
    assert changeset.valid? == false
  end
end
