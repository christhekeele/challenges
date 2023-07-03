# Toy Robot Simulator

<!-- MODULEDOC SNIPPET -->

> **_Parse a series of commands to drive a toy robot around!_**

Challenge sourced [here](https://codereview.stackexchange.com/questions/236006/toy-robot-simulator) via [this forum post](https://elixirforum.com/t/need-help-elixirizing-my-toy-robot-solution/56788).

## Synopsis

The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
There are no other obstructions on the table surface.
The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.
Create an application that can read in commands of the following form:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- `PLACE` will put the toy robot on the table in position `X,Y` and facing `NORTH`, `SOUTH`, `EAST` or `WEST`.
- The origin (0,0) can be considered to be the `SOUTH` `WEST` most corner.
- The first valid command to the robot is a `PLACE` command, after that, any sequence of commands may be issued, in any order, including another `PLACE` command. The application should discard all commands in the sequence until a valid `PLACE` command has been executed.
- `MOVE` will move the toy robot one unit forward in the direction it is currently facing.
- `LEFT` and `RIGHT` will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- `REPORT` will announce the `X,Y` and `F` of the robot.

A robot that is not on the table can choose the ignore the `MOVE`, `LEFT`, `RIGHT` and `REPORT` commands.

### Constraints

The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.
It is not required to provide any graphical output showing the movement of the toy robot.

<!-- MODULEDOC SNIPPET -->

### Example Input and Output

Below are example input/outputs from the original problem. They have been encoded into the challenge seed's suite.

<details>
<summary>Click to expand examples!</summary>

#### Example A

```
PLACE 0,0,NORTH
MOVE
REPORT
```

Expected output:

```
0,1,NORTH
```

#### Example B

```
PLACE 0,0,NORTH
LEFT
REPORT
```

Expected output:

```
0,0,WEST
```

#### Example C

```
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
```

Expected output:

```
3,3,NORTH
```

</details>

### Additional Challenges

- Support configurable board sizes
- Implement a graphical interface to drive the robot real-time

## Code

This project is [an Elixir](https://elixir-lang.org/) [Bakeware CLI](https://github.com/bake-bake-bake/bakeware) application with a [Ratatouille TUI](https://github.com/ndreynolds/ratatouille).

### Development

#### Setup

Prepare the project by running:

```sh
mix deps.get
```

#### Test

Execute the test suite via:

```sh
mix test
```

#### Run

During development, you can quickly iterate on the CLI by running:

```sh
mix cli ...args
```

For example,

```sh
mix cli help
```

> **_NOTE_**: Currently, the `mix cli` development helper does not support reading from stdin, running the TUI, or handle <kbd>CTRL</kbd>-<kbd>C</kbd>/<kbd>CTRL</kbd>-<kbd>D</kbd> the same as a full build. To test this functionality, make a full build of the CLI with `mix build`.

#### Build

To build an executable release of the CLI, run:

```sh
mix build
```

For an optimized build, set `MIX_ENV=prod`:

```sh
env MIX_ENV=prod mix build
```

### Project Structure

This project is structured like so:

```
toy-robot
├── README.md  # <-- YOU ARE HERE
├── mix.exs    # Elixir project manifest
│
├── lib                    # APPLICATION CODE
│   ├── toy_robot.ex       # The application's namespace:      `ToyRobot`
│   └── toy_robot
│       ├── simulation.ex  # The core code for our simulation: `ToyRobot.Simulation`
│       ├── cli.ex         # The code for our Bakeware CLI:    `ToyRobot.CLI`
│       └── tui.ex         # The code for our Ratatouille TUI: `ToyRobot.TUI`
│
└── test                         # TEST SUITE CODE
    ├── test_helper.exs          # Shared test helpers
    ├── toy_robot_test.exs       # Tests for: `ToyRobot`
    └── toy_robot
        ├── simulation_test.exs  # Tests for: `ToyRobot.Simulation`
        ├── cli_test.exs         # Tests for  `ToyRobot.CLI`
        └── tui_test.exs         # Tests for: `ToyRobot.TUI`
```

Solve the problem by completing the `ToyRobot.Simulation` module! Run the test suite to validate your solution via: `mix test`.

The `ToyRobot.CLI` is already set up to run your `ToyRobot.Simulation` code with the command: `toy_robot run [?file]`.

Should you try to implement a graphical TUI with Ratatouille, the starter code in `ToyRobot.TUI` can be booted with the command: `toy_robot start`!
