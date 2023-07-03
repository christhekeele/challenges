ExUnit.start()

defmodule TestHelpers do
  def simulation_result(input) do
    input
    |> ToyRobot.parse
    |> ToyRobot.simulate
    |> to_string
  end
end
