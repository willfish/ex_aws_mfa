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

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:configparser_ex, "~> 3.0.0"},
      {:optimus, "~> 0.1.0"},
      {:poison, "~> 3.1"},
      {:timex, "~> 3.1"},
      {:tzdata, "== 0.1.8", override: true}
    ]
  end
end
