defmodule ExAwsMfa.Runner do
  def run(execution_type, argv) do
    if dependencies_met?() do
      ExAwsMfa.Config.load()
      |> ExAwsMfa.CredentialsHandler.handle()
      |> execute(execution_type, argv)
    else
      raise "Missing aws binary. Have you ran: pip install aws?"
    end
  end

  defp execute(credentials, :cache_only, argv) do
    ExAwsMfa.Executors.CacheOnly.execute(credentials, argv)
  end

  defp execute(credentials, :print_env, argv) do
    ExAwsMfa.Executors.PrintEnv.execute(credentials, argv)
  end

  defp execute(credentials, :set_env, argv) do
    ExAwsMfa.Executors.SetEnv.execute(credentials, argv)
  end

  defp execute(credentials, :set_env_and_exec, argv) do
    ExAwsMfa.Executors.SetEnvAndExec.execute(credentials, argv)
  end

  defp dependencies_met? do
    ExAwsMfa.Commands.WhichAws.run().success
  end
end
