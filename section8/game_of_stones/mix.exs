defmodule GameOfStones.MixProject do
  use Mix.Project

  def project do
    [
      app: :game_of_stones,
      version: "0.1.0",
      elixir: "~> 1.7",
      escript: [ # running mix escript.build will create the executable
        main_module: GameOfStones.Client
      ],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # env: [key: value] instead of using the config
      extra_applications: [:logger],
      mod: { GameOfStones.Application, [] }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:colors, "~> 1.1"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false} # run `mix docs` to generate documentation in the doc folder
    ]
  end
end
