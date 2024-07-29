defmodule ContactForm.ClientsRequests.Clients do
  import Ecto.Query, warn: false
  alias ContactForm.Repo

  alias ContactForm.ClientsRequests.Client

  def change_contact_form(%Client{} = client, attrs \\ %{}) do
    Client.changeset(client, attrs)
  end

  def create_contact_request_record(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end
end
