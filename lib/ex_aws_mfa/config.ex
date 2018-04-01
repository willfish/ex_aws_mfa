defmodule ExAwsMfa.Config do
  @moduledoc """
  ExAwsMfa.Config provides an interface to AWS configuration
  stored in an INI file in the current users home directory.
  """

  @doc """
  mfa_serial: The arn for the mfa device
  aws_profile: The profile read from the environment whose config blob we're using
  role_arn: The arn for the role we're going to assume
  source_profile: The profile we're going to be using to source credentials from
  """
  defstruct [:mfa_serial, :aws_profile, :role_arn, :source_profile]

  @config_path Path.join(System.get_env("HOME"), ".aws/config")
  @aws_profile_env_key "AWS_PROFILE"

  @doc """
  Load the configuration file into memory as a Config struct
  %ExAwsMfa.Config{
    aws_profile: "<aws_profile>",
    mfa_serial: "<mfa_serial>",
    role_arn: "<role_arn>",
    source_profile: "<source_profile>"
  }
  """
  def load do
    if aws_profile?() do
      parse() |> handle() |> build()
    else
      raise "Please set AWS_PROFILE in your environment"
    end
  end

  defp build(config) do
    %ExAwsMfa.Config{
      aws_profile: aws_profile(),
      role_arn: config["role_arn"],
      mfa_serial: config["mfa_serial"],
      source_profile: config["source_profile"]
    }
  end

  defp parse do
    if File.exists?(@config_path) do
      ConfigParser.parse_file(@config_path)
    else
      raise "Could not find an aws config file at: #{@config_path}"
    end
  end

  defp handle({:ok, config}) do
    config["profile #{aws_profile()}"]
  end

  defp handle({:error, message}) do
    raise "Failed to parse aws config file: #{@config_path}, reason: #{message}"
  end

  defp aws_profile? do
    profile = aws_profile()

    profile && String.length(profile) > 0
  end

  defp aws_profile do
    System.get_env(@aws_profile_env_key)
  end
end
