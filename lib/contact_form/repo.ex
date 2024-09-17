defmodule ContactForm.Repo do
  use Ecto.Repo,
    otp_app: :contact_form,
    adapter: Ecto.Adapters.Postgres
end
