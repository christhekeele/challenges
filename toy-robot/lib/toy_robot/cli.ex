defmodule ToyRobot.CLI do
  @moduledoc """
  The CLI app for our simulation.
  """

  use Bakeware.Script

  @impl Bakeware.Script

  def main(["run" | []]) do
    :stdio
    |> IO.read(:eof)
    |> run && 0
  end

  def main(["run", file | []]) do
    file
    |> File.read!()
    |> run && 0
  end

  def main(["start" | []]) do
    ToyRobot.TUI.start() && 0
  end

  def main(["help" | _rest]) do
    help() && 0
  end

  def main(args) do
    IO.puts("ERROR: invalid command: `toy_robot #{Enum.join(args, " ")}`")
    help() && 1
  end

  defp help do
    IO.puts("""
      Usage: `toy_robot SUBCOMMAND [?option]`
      `toy_robot run`: reads from stdin
      `toy_robot run <file>`: reads from file
      `toy_robot start`: starts interactive app
    """)
  end

  def run(:eof) do
    "" |> parse_commands |> simulate_commands |> display_result
  end

  def run(input) do
    input |> parse_commands |> simulate_commands |> display_result
  end

  defp parse_commands(input) do
    ToyRobot.parse(input)
  end

  defp simulate_commands(commands) do
    ToyRobot.simulate(commands)
  end

  defp display_result(simulation) do
    IO.puts("Result: #{simulation}")
  end
end
