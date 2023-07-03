defmodule ToyRobot.MixProject do
  use Mix.Project

  @otp_app :toy_robot

  def project,
    do: [
      app: @otp_app,
      version: "0.1.0",
      elixir: "~> 1.14",
      deps: deps(),
      releases: releases(),
      aliases: aliases()
    ]

  def application,
    do: [
      extra_applications: [:logger],
      mod: {ToyRobot.CLI, []}
    ]

  defp deps,
    do: [
      {:ratatouille, ">= 0.0.1"},
      {:bakeware, github: "bake-bake-bake/bakeware", runtime: false}
    ]

  def releases,
    do: [
      toy_robot: [
        overwrite: true,
        cookie: "#{@otp_app}_cookie",
        quiet: true,
        steps: [:assemble, &Bakeware.assemble/1],
        bakeware: bakeware(Mix.env()),
        strip_beams: Mix.env() == :prod
      ]
    ]

  defp bakeware(:prod), do: [compression_level: 19]
  defp bakeware(_), do: [compression_level: 1]

  defp aliases,
    do: [
      build: "release",
      clean: &clean/1,
      cli: ["build", &cli/1],
      release: ["clean", "release"],
      test: "test --no-start"
    ]

  defp clean(_) do
    System.shell("rm -fr _build")
  end

  defp cli(args) do
    executable = "./_build/#{Mix.env()}/rel/bakeware/#{@otp_app}"

    # stdin = case IO.read(:stdio, :eof) do
    #   :eof -> nil
    #   data when is_binary(data) -> data
    # end |> tap(&IO.inspect(&1, label: :STDIN))

    # port = Port.open({:spawn_executable, executable}, [:binary, args: args])

    # if stdin do
    #   if String.ends_with?(stdin, "\n") do
    #     Port.command(port, stdin)
    #   else
    #     Port.command(port, stdin <> "\n")
    #   end
    # end

    # receive do
    #   {^port, response} ->
    #     IO.puts(response)
    # end

    command = "#{executable} #{Enum.join(args, " ")}"

    IO.puts("Invoking CLI via command:")
    IO.puts(command)
    IO.puts(nil)

    {_io_stream, exit_code} = System.shell(command, into: IO.stream())

    if exit_code != 0 do
      raise "`#{@otp_app}` cli returned non-zero exit status"
    end
  end
end
