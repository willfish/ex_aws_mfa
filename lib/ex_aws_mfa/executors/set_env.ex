defmodule ExAwsMfa.Executors.SetEnv do
  def execute(credentials, _) do
    ExAwsMfa.Env.set(credentials)
  end
end
