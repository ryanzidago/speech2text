defmodule Speech2text.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Speech2textWeb.Telemetry,
      Speech2text.Repo,
      {DNSCluster, query: Application.get_env(:speech2text, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Speech2text.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Speech2text.Finch},
      # Start a worker by calling: Speech2text.Worker.start_link(arg)
      # {Speech2text.Worker, arg},
      # Start to serve requests, typically the last entry
      Speech2textWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Speech2text.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Speech2textWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
