defmodule ContactForm.ClientsRequests.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients_requests" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :query_type, :string
    field :message, :string
    field :contact_consent, :boolean

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
    |> validate_first_name_last_name_and_message()
    |> validate_query_type()
    |> validate_consent_field(attrs)
    |> validate_email()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "please enter a valid email address")
    |> validate_length(:email, max: 160)
  end

  defp validate_first_name_last_name_and_message(changeset) do
    changeset
    |> validate_required([:first_name, :last_name, :message], message: "This field is required")
  end

  defp validate_query_type(changeset) do
    changeset
    |> validate_required([:query_type], message: "Please select a query type")
  end

  defp validate_consent_field(changeset, %{"contact_consent" => "false"}) do
    add_error(changeset, :contact_consent, "To submit this form please allow to be contacted")
  end

  defp validate_consent_field(changeset, _attrs) do
    changeset
  end
end
