defmodule ContactForm.ClientsRequests.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients_requests" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :query_type, :string
    field :message, :string
    field :contact_consent, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :query_type,
      :message,
      :contact_consent
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :query_type,
      :message,
      :contact_consent
    ])
  end
end
