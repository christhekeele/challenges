defmodule ToyRobot.Simulation do
  @moduledoc """
  The core logic for our simulation.
  """

  @default_size 5

  @cmd_PLACE "PLACE"
  @cmd_MOVE "MOVE"
  @cmd_LEFT "LEFT"
  @cmd_RIGHT "RIGHT"
  @cmd_REPORT "REPORT"

  @dir_NORTH "NORTH"
  @dir_SOUTH "SOUTH"
  @dir_EAST "EAST"
  @dir_WEST "WEST"
  @directions [@dir_NORTH, @dir_SOUTH, @dir_EAST, @dir_WEST]

  defstruct [:x, :y, :facing, size: @default_size]

  @type t :: %__MODULE__{
          x: pos_integer(),
          y: pos_integer(),
          facing: String.t(),
          size: non_neg_integer()
        }

  defimpl String.Chars do
    @doc """
    Returns a string representation of a simulation state.
    """
    @spec to_string(ToyRobot.Simulation.t()) :: String.t()
    def to_string(%ToyRobot.Simulation{x: x, y: y, facing: facing}) do
      Enum.join([x, y, facing], ",")
    end
  end

  def run(commands) do
    for command <- commands, reduce: new() do
      simulation -> process(simulation, command)
    end
  end

  def new(opts \\ []) do
    size = Keyword.get(opts, :size, @default_size)
    %__MODULE__{size: size}
  end

  def process(simulation = %__MODULE__{}, command) do
    do_process(simulation, command)
  end

  defp do_process(simulation, @cmd_PLACE <> " " <> xyf) do
    [x, y, facing | []] = String.split(xyf, ",")
    {{x, ""}, {y, ""}} = {Integer.parse(x), Integer.parse(y)}
    place(simulation, {x, y, facing})
  end

  defp do_process(simulation, @cmd_MOVE), do: move(simulation)
  defp do_process(simulation, @cmd_LEFT), do: left(simulation)
  defp do_process(simulation, @cmd_RIGHT), do: right(simulation)
  defp do_process(simulation, @cmd_REPORT), do: tap(simulation, &IO.puts/1)

  defp left(simulation = %{facing: @dir_NORTH}), do: %{simulation | facing: @dir_WEST}
  defp left(simulation = %{facing: @dir_EAST}), do: %{simulation | facing: @dir_NORTH}
  defp left(simulation = %{facing: @dir_SOUTH}), do: %{simulation | facing: @dir_EAST}
  defp left(simulation = %{facing: @dir_WEST}), do: %{simulation | facing: @dir_SOUTH}

  defp right(simulation = %{facing: @dir_NORTH}), do: %{simulation | facing: @dir_EAST}
  defp right(simulation = %{facing: @dir_EAST}), do: %{simulation | facing: @dir_SOUTH}
  defp right(simulation = %{facing: @dir_SOUTH}), do: %{simulation | facing: @dir_WEST}
  defp right(simulation = %{facing: @dir_WEST}), do: %{simulation | facing: @dir_NORTH}

  defp place(simulation = %{size: size}, {x, y, facing})
       when x >= 0 and x < size and y >= 0 and y < size and facing in @directions do
    %{simulation | x: x, y: y, facing: facing}
  end

  # Do not advance off-grid
  defp move(simulation = %{facing: @dir_NORTH, size: size, y: y}) when y == size - 1,
    do: simulation

  defp move(simulation = %{facing: @dir_EAST, size: size, x: x}) when x == size - 1,
    do: simulation

  defp move(simulation = %{facing: @dir_SOUTH, y: 0}), do: simulation
  defp move(simulation = %{facing: @dir_WEST, x: 0}), do: simulation

  # Otherwise, move ahead 1
  defp move(simulation = %{facing: @dir_NORTH, y: y}), do: %{simulation | y: y + 1}
  defp move(simulation = %{facing: @dir_EAST, x: x}), do: %{simulation | x: x + 1}
  defp move(simulation = %{facing: @dir_SOUTH, y: y}), do: %{simulation | y: y - 1}
  defp move(simulation = %{facing: @dir_WEST, x: x}), do: %{simulation | x: x - 1}
end
