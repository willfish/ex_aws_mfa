defmodule ExAwsMfa.Commands.AwsStsAssumeRole do
  @binary "aws"
  @format "json"
  @mfa_regex ~r/^\d{6}$/
  @prompt "Enter the 6-digit code from your MFA device:\n"
  @region "eu-west-1"
  @session_name "aws-mfa-session"

  def run({binary, args}) do
    "#{binary} #{Enum.join(args, " ")}"
    |> String.to_charlist()
    |> Application.get_env(:ex_aws_mfa, :os).cmd()
  end

  def build(config) do
    args = [
      "--profile",
      config.source_profile,
      "--region",
      @region,
      "--output",
      @format,
      "sts assume-role",
      "--role-arn",
      config.role_arn,
      "--role-session-name",
      @session_name,
      "--serial-number",
      config.mfa_serial,
      "--token-code",
      prompt_for_code()
    ]

    {@binary, args}
  end

  defp prompt_for_code do
    IO.gets(:stdio, @prompt)
    |> String.trim()
    |> handle_code()
  end

  defp handle_code(code) do
    if Regex.match?(@mfa_regex, code) do
      code
    else
      raise "Invalid MFA Code: #{code}\n"
    end
  end
end
