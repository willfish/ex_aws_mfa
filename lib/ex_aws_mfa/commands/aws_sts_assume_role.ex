defmodule ExAwsMfa.Commands.AwsStsAssumeRole do
  @binary "aws"
  @format "json"
  @mfa_regex ~r/^\d{6}$/
  @region "eu-west-1"
  @session_name "aws-mfa-session"

  alias ExAwsMfa.ShellCommand

  def run({binary, args}) do
    ShellCommand.execute(binary, args)
  end

  def build(token_code, profile_config) do
    args = [
      "--profile",
      profile_config.source_profile,
      "--region",
      @region,
      "--output",
      @format,
      "sts assume-role",
      "--role-arn",
      profile_config.role_arn,
      "--role-session-name",
      @session_name,
      "--serial-number",
      profile_config.serial_number,
      "--token-code",
      prompt_for_code
    ]

    {@binary, args}
  end

  defp prompt_for_code do
    IO.puts("Enter the 6-digit code from your MFA device:")
    code = IO.gets() |> String.chomp()

    handle_code(code)
  end

  defp handle_code(code) do
    if Regex.match?(@mfa_regex, code) do
      code
    else
      raise "Invalid MFA Code: #{code}"
    end
  end
end
