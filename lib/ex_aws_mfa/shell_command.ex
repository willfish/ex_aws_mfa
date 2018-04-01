defmodule ExAwsMfa.ShellCommand do
  defstruct [:result, :status, :success, :binary, :args]

  def execute(binary, args) do
    {result, status} = System.cmd(binary, args)

    %ExAwsMfa.ShellCommand{
      result: result,
      status: status,
      success: success?(status),
      binary: binary,
      args: args
    }
  end

  def success?(status) do
    status == 0
  end
end
