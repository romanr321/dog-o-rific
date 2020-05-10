defmodule Dor.Repo do
  use Ecto.Repo,
    otp_app: :dor,
    adapter: Ecto.Adapters.Postgres
end
