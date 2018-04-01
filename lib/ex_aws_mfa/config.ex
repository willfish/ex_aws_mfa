defmodule ExAwsMfa.Config do
  defstruct [:serial_number, :profile, :role_arn, :source_profile]

  @config_path Path.join(System.get_env("HOME"), ".aws/config")
  @aws_profile_env_key "AWS_PROFILE"

  def load when exists? do
    {:ok, content} = ConfigParser.parse_file(@config_path)

    # content |>
  end

  def load do
    raise "Could not find an aws config file at: #{@config_path}"
  end

  def build({serial_number, role_arn, source_profile}, profile) do
    %ExAwsMfa.Config{
      serial_number: serial_number,
      profile: profile,
      role_arn: role_arn,
      source_profile: source_profile
    }
  end

  defp exists?, do: File.exists?(@config_path)

  defp aws_profile? do
    profile = aws_profile

    profile && String.length(profile) > 0
  end

  defp aws_profile do
    System.get_env(@aws_profile_env_key)
  end
end
