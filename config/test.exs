import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :contact_form, ContactForm.Repo,
  username: "postgres",
  password: "Khohisan@7",
  database: "contact_form_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :contact_form, ContactFormWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5xLnNRBWVJNaSJGVrL4bBXTfvdr9yQCWuuxHFqwumOjPdiWXtHrnyiYZqYeiWsJ4",
  server: false

# In test we don't send emails.
config :contact_form, ContactForm.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
