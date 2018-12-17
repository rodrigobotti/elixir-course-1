defmodule GameOfStones.Application do
  use Application

  def start(_type, _args) do
    # processes to supervise
    children = [
      GameOfStones.Storage,
      GameOfStones.Server
    ]
    # suppervision strategies:
    # - one_for_one: restart failed process
    # - one_for_all: restart all the processes
    # - rest_for_one: restart failed process and the processes listed after the failed one
    opts = [ strategy: :one_for_one, name: GameOfStones.Suppervisor ]

    Supervisor.start_link(children, opts)
  end

end
