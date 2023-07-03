defmodule ToyRobot.Simulation do
  @moduledoc """
  The core logic for our simulation.
  """

  defstruct []
  @type t :: %__MODULE__{}

  defimpl String.Chars do
    @doc """
    Returns a string representation of a simulation state.
    """
    @spec to_string(ToyRobot.Simulation.t()) :: String.t
    def to_string(_simulation = %ToyRobot.Simulation{}) do
      ""
    end
  end

  def run(commands) do
    for command <- commands, reduce: new() do
      simulation -> process(simulation, command)
    end
  end

  def new() do
    %__MODULE__{}
  end

  def process(simulation = %__MODULE__{}, command) do
    IO.puts("Processing command: `#{command}`")
    simulation
  end
end
