defmodule ExAwsMfa.ShellCommand do
  defstruct [:result, :status, :success]

  def execute(binary, args) do
    {result, status} = System.cmd(binary, args)

    %ExAwsMfa.ShellCommand{
      result: result,
      status: status,
      success: success?(status)
    }
  end

  def success?(status) do
    status == 0
  end
end
