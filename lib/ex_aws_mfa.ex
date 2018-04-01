defmodule ExAwsMfa do
  @moduledoc """
  ExAwsMfa is used to cache an sts session in your environment via a cache file.
  """

  def main(argv) do
    argv
    |> execution_type
    |> ExAwsMfa.Runner.run(argv)
  end

  def execution_type(argv) do
    cond do
      cache_only?(argv) -> :cache_only
      print_env?(argv) -> :print_env
      true -> :set_env_and_exec
    end
  end

  defp cache_only?(argv) do
    cache_only = fn arg -> arg == "--cache-only" end
    Enum.any?(argv, cache_only)
  end

  defp print_env?(argv) do
    Enum.empty?(argv)
  end
end
