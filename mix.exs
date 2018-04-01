defmodule ExAwsMfa.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_mfa,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: ExAwsMfa]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:configparser_ex, "~> 3.0.0"},
      {:optimus, "~> 0.1.0"},
      {:poison, "~> 3.1"},
      {:timex, "~> 3.1"},
      {:tzdata, "== 0.1.8", override: true}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
