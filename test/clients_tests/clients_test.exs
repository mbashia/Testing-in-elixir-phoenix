defmodule ContactFormWeb.ClientsTest do
  use ContactFormWeb.ConnCase
  use ExUnit.Case, async: true

  alias ContactForm.ClientsRequests.Client
  alias ContactForm.ClientsRequests.Clients

  @valid_attrs %{
    first_name: "John",
    last_name: "Doe",
    email: "johndoe@gmail.com",
    query_type: "General inquiry",
    message: "this is a message",
    contact_consent: true
  }

  @invalid_attrs %{
    first_name: "John",
    last_name: "Doe",
    email: "invalidemail",
    query_type: "General inquiry",
    message: "this is a message",
    contact_consent: true
  }

  test "create_contact_request_record/1 with valid data" do
    assert {:ok, record} = Clients.create_contact_request_record(@valid_attrs)
    assert record.first_name == "John"
    assert record.last_name == "Doe"
    assert record.email == "johndoe@gmail.com"
    assert record.query_type == "General inquiry"
    assert record.message == "this is a message"
    assert record.contact_consent == true
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

  test "invalid changeset with misssing firstname" do
    invalid_attrs = Map.delete(@valid_attrs, :first_name)
    changeset = Client.changeset(%Client{}, invalid_attrs)
    refute changeset.valid?
    [first_name: {error_message, _}] = changeset.errors
    assert error_message == "This field is required"
  end

  test "invalid changeset with misssing lastname" do
    invalid_attrs = Map.delete(@valid_attrs, :last_name)
    changeset = Client.changeset(%Client{}, invalid_attrs)
    refute changeset.valid?
    [last_name: {error_message, _}] = changeset.errors
    assert error_message == "This field is required"
  end

  test "invalid changeset with wrong email format" do
    changeset = Client.changeset(%Client{}, @invalid_attrs)
    refute changeset.valid?
    [email: {error_message, _}] = changeset.errors
    assert error_message == "please enter a valid email address"
  end

  test "invalid changeste with message longer than 250 characters" do
    invalid_attrs = Map.put(@valid_attrs, :message, String.duplicate("a", 251))
    changeset = Client.changeset(%Client{}, invalid_attrs)
    refute changeset.valid?
    [message: {error_message, _}] = changeset.errors
    assert error_message == "Message must be less than 250 characters"
  end

  test "invalid changeset with missing query type" do
    invalid_attrs = Map.delete(@valid_attrs, :query_type)
    changeset = Client.changeset(%Client{}, invalid_attrs)
    refute changeset.valid?
    [query_type: {error_message, _}] = changeset.errors
    assert error_message == "Please select a query type"
  end

  test "invalid changeset when contact consent is false" do
    invalid_attrs = Map.put(@valid_attrs, :contact_consent, false)
    changeset = Client.changeset(%Client{}, invalid_attrs)
    refute changeset.valid?
    [contact_consent: {error_message, _}] = changeset.errors
    assert error_message == "To submit this form, please consent to being contacted"
  end
end
