defmodule Speech2text.Repo do
  use Ecto.Repo,
    otp_app: :speech2text,
    adapter: Ecto.Adapters.Postgres
end
