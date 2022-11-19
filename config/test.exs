import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :surveylive_online, SurveyliveOnline.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "surveylive_online_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :surveylive_online, SurveyliveOnlineWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "iQ6uI98NllhUtz4jDUPpTQy2rQ+vgF2xJpLeRa9pvauXAeFdiiFibokKQR/SofOC",
  server: false

# In test we don't send emails.
config :surveylive_online, SurveyliveOnline.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :surveylive_online, SurveyliveOnline.Admins.Guardian,
  issuer: "surveylive_online",
  secret_key: "1RCGH+jnTgJNVrkKQMrebh6AOkYRLrpThEPM37fEIYHXtJCEvwAjdQwbRLv8GPWJ"

config :surveylive_online, SurveyliveOnline.Accounts.Guardian,
  issuer: "surveylive_online",
  secret_key: "hS5jzOOsnvcmGvhz6B1B+FfbtfKY2wvTxYSLC6CcC8WY2pNLsx59nEPwWOnwIAHL"

config :surveylive_online, Oban, queues: false, plugins: false
