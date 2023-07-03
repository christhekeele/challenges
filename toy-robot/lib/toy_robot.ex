defmodule ToyRobot do
  @readme "README.md"
  @external_resource @readme
  @moduledoc @readme
             |> File.read!()
             |> String.split("<!-- MODULEDOC SNIPPET -->")
             |> Enum.fetch!(1)

  @doc """
  Runs a `#{__MODULE__}` simulation with the provided list of commands.
  """
  @spec simulate(list(String.t())) :: ToyRobot.Simulation.t()
  def simulate(commands) do
    ToyRobot.Simulation.run(commands)
  end

  @doc """
  Parses a multi-line string into a list of commands.
  """
  @spec parse(String.t()) :: list(String.t())
  def parse(string) do
    string
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
  end
end
