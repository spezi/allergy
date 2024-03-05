defmodule AllergyApp.Repo do
  use Ecto.Repo,
    otp_app: :allergy_app,
    adapter: Ecto.Adapters.Postgres
end
