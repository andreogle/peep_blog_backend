# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :peep_blog_backend, PeepBlogBackend.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "0bj9oqZ/jSp6lWp7m6nqHguPKlsxYstX9ry6bnsnIDUCE44k7t3s2JTXgqKwAiQk",
  debug_errors: false,
  pubsub: [name: PeepBlogBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix_token_auth,
  user_model: PeepBlogBackend.User,                                                              # ecto model used for authentication
  repo: PeepBlogBackend.Repo,                                                                    # ecto repo
  crypto_provider: Comeonin.Bcrypt,                                                    # crypto provider for hashing passwords/tokens. see http://hexdocs.pm/comeonin/
  token_validity_in_minutes: 7 * 24 * 60,                                               # minutes from login until a token expires
  email_sender: "ogleandre@yahoo.com",                                                   # sender address of emails sent by the app
  emailing_module: PeepBlogBackend.EmailConstructor,                                              # module implementing the `PhoenixTokenAuth.MailingBehaviour` for generating emails
  user_model_validator: {PeepBlogBackend.Model, :user_validator}                                 # function receiving and returning the changeset for a user on registration and when updating the account. This is the place to run custom validations.

config :joken,
  json_module: PhoenixTokenAuth.PoisonHelper,
  algorithm: :HS256

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
