defmodule ToyRobot.TUI do
  @moduledoc """
  The TUI app for our simulation.
  """

  @behaviour Ratatouille.App

  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1]

  alias Ratatouille.Runtime.Command
  alias Ratatouille.Runtime.Subscription

  def start() do
    Ratatouille.run(__MODULE__,
      quit_events: [
        {:key, key(:ctrl_d)}
      ]
    )
  end

  def init(_context) do
    ToyRobot.Simulation.new()
  end

  def update(simulation, _event) do
    simulation
  end

  def render(_simulation) do
    view do
      label(content: "Toy Robot Simulator (Enter CTRL-D to exit)")
    end
  end
end
