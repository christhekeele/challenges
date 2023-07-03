defmodule ToyRobotTest do
  use ExUnit.Case
  doctest ToyRobot

  import TestHelpers

  test "Example A" do
    assert simulation_result("""
             PLACE 0,0,NORTH
             MOVE
             REPORT
           """) == "0,1,NORTH"
  end

  test "Example B" do
    assert simulation_result("""
             PLACE 0,0,NORTH
             LEFT
             REPORT
           """) == "0,0,WEST"
  end

  test "Example C" do
    assert simulation_result("""
             PLACE 1,2,EAST
             MOVE
             MOVE
             LEFT
             MOVE
             REPORT
           """) == "3,3,NORTH"
  end

  test "walking to the edge of the playing field without going over" do
    assert simulation_result("""
           PLACE 3,3,EAST
           MOVE
           MOVE
           RIGHT
           MOVE
           REPORT
           """) == "4,2,SOUTH"
  end

  test "cannot make invalid placement" do
    assert_raise FunctionClauseError, fn ->
      simulation_result("""
      PLACE 3,6,EAST
      REPORT
      """) == "4,2,SOUTH"
    end
  end
end
