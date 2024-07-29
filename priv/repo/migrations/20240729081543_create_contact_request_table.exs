defmodule ContactForm.Repo.Migrations.CreateContactRequestTable do
  use Ecto.Migration

  def change do
    create table(:clients_requests) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :query_type, :string
      add :message, :string
      add :contact_consent, :boolean, default: false

      timestamps()
    end

    create unique_index(:clients_requests, [:email])
  end
end
