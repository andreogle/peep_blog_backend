defmodule PeepBlogBackend.User do
  use PeepBlogBackend.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password,             :string
    field :hashed_confirmation_token,   :string
    field :confirmed_at,                Ecto.DateTime
    field :hashed_password_reset_token, :string
    field :unconfirmed_email,           :string
    field :authentication_tokens,       {:array, :string}, default: []

    timestamps
  end

  @required_fields ~w(name email hashed_password)
  @optional_fields ~w()

  def phoenix_token_auth_validator(changeset = %{params: %{"password" => password}}) when password != nil and password != "" do
    if String.length(password) < 6 do
      changeset = Ecto.Changeset.add_error(changeset, :password, :too_short)
    end
    changeset
  end
  def phoenix_token_auth_validator(changeset), do: changeset

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
