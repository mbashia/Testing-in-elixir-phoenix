defmodule ContactFormWeb.ClientsTest do
  use ContactFormWeb.ConnCase
  #   use ExUnit.Case, async: true

  alias ContactForm.ClientsRequests.Client
  alias ContactForm.ClientsRequests.Clients

  @valid_attrs %{
    first_name: "John",
    last_name: "Doe",
    email: "johndoe@gmail.com",
    query_type: "General inquiry",
    message: "this is a message",
    contact_consent: false
  }

  @invalid_attrs %{
    first_name: "John",
    last_name: "Doe",
    email: "invalidemail",
    query_type: "",
    message: "this is a message",
    contact_consent: false
  }

  test "create_contact_request_record/1 with valid data" do
    assert {:ok, record} = Clients.create_contact_request_record(@valid_attrs)
    assert record.first_name == "John"
    assert record.last_name == "Doe"
    assert record.email == "johndoe@gmail.com"
    assert record.query_type == "General inquiry"
    assert record.message == "this is a message"
    assert record.contact_consent == false
  end

  test "create_contact_request_record/1 with invalid data returns invalid changeset" do
    assert {:error, %Ecto.Changeset{}} = Clients.create_contact_request_record(@invalid_attrs)
  end

  test "change_contact_form/2 returns contact request changeset" do
    client = %Client{}

    assert %Ecto.Changeset{} = Clients.change_contact_form(client, @valid_attrs)
  end

  test "change_contact_form/2 returns valid changeset with valid data " do
    client = %Client{}

    assert changeset = Clients.change_contact_form(client, @valid_attrs)
    assert changeset.valid? == true
  end

  test "change_contact_form/2 returns returns a false changeset with invalid data" do
    client = %Client{}

    assert changeset = Clients.change_contact_form(client, @invalid_attrs)
    assert changeset.valid? == false
  end


  
end
