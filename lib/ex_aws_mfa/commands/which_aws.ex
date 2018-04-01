defmodule ExAwsMfa.Commands.WhichAws do
  @binary "which"

  alias ExAwsMfa.ShellCommand

  def run do
    ShellCommand.execute(@binary, ["aws"])
  end
end
