defmodule ExAwsMfa.Executors.PrintEnv do
  def execute(credentials, _) do
    IO.puts(ExAwsMfa.Credentials.present(credentials))
  end
end
