defmodule ExAwsMfa do
  alias ExAwsMfa.Commands.WhichAws

  @moduledoc """
  Documentation for ExAwsMfa.
  """

  @doc """
  """
  # def handle(execution) when dependencies_met? do
  #   parse_config
  #   |> load_credentials
  #   |> execute(execution)
  # end

  def execute(credentials, :set_and_exec) do
  end

  def execute(credentials, :quiet), do: nil

  def execute(credentials, :set_env) do
  end

  def execute(credentials, :print_env) do
  end

  defp dependencies_met? do
    WhichAws.run().success
  end
end
