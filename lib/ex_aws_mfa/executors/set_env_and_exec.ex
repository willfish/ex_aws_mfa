defmodule ExAwsMfa.Executors.SetEnvAndExec do
  def execute(credentials, argv) do
    ExAwsMfa.Env.set(credentials)
    argv
    |> Enum.join(" ") 
    |> String.to_charlist()
    |> :os.cmd()
    |> List.to_string()
    |> IO.puts
  end
end
