# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :surveylive_online, :env, Mix.env()

config :surveylive_online,
  ecto_repos: [SurveyliveOnline.Repo],
  generators: [binary_id: true]

config :surveylive_online, SurveyliveOnline.Repo,
  migration_primary_key: [name: :id, type: :binary_id]

config :surveylive_online,
  require_user_confirmation: true,
  app_name: "SurveyliveOnline",
  page_url: "surveylive_online.com",
  company_name: "SurveyliveOnline Inc",
  company_address: "26955 Fritsch Bridge",
  company_zip: "54933-7180",
  company_city: "San Fransisco",
  company_state: "California",
  company_country: "United States",
  contact_name: "John Doe",
  contact_phone: "+1 (335) 555-2036",
  contact_email: "john.doe@surveylive_online.com",
  from_email: "john.doe@surveylive_online.com"

# Configures the endpoint
config :surveylive_online, SurveyliveOnlineWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: SurveyliveOnlineWeb.ErrorHTML, json: SurveyliveOnlineWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SurveyliveOnline.PubSub,
  live_view: [signing_salt: "ZuMRds/l"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :surveylive_online, SurveyliveOnline.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.2.0",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :surveylive_online, SurveyliveOnline.Users.Guardian,
  issuer: "surveylive_online",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY_ADMINS") || "g3WglfJgCMF3bentyxjgUyLrrPIXY0xLD4nD9cY/m/HmZK8PpTTCVRQCHPlILJ9T"

config :surveylive_online, SurveyliveOnline.Admins.Guardian,
  issuer: "surveylive_online",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY_ADMINS") || "2viVf+1B32Ej1rl+2LnpPsGBZke6OpZE2qA3+yP7h3l/EwthD9c8wev0egGILoYS"

config :surveylive_online, Oban,
  repo: SurveyliveOnline.Repo,
  queues: [default: 10, mailers: 20, high: 50, low: 5],
  plugins: [
    {Oban.Plugins.Pruner, max_age: (3600 * 24)},
    {Oban.Plugins.Cron,
      crontab: [
       # {"0 2 * * *", SurveyliveOnline.Workers.DailyDigestWorker},
       # {"@reboot", SurveyliveOnline.Workers.StripeSyncWorker}
     ]}
  ]

config :saas_kit,
  admin: true,
  api_key: System.get_env("SAAS_KIT_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
