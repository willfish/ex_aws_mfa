defmodule ExAwsMfa.Credentials do
  alias ExAwsMfa.Credentials
  alias ExAwsMfa.ProfileConfig

  @derive [Poison.Encoder]

  defstruct [:AccessKeyId, :SecretAccessKey, :SessionToken, :Expiration]

  def encode!(credentials) do
    Poison.encode!(credentials)
  end

  def decode!(credentials) when is_binary(credentials) do
    Poison.decode!(credentials, as: %Credentials{})
  end

  def env_mapping do
    %{
      "AccessKeyId" => "AWS_ACCESS_KEY_ID",
      "SecretAccessKey" => "AWS_SECRET_ACCESS_KEY",
      "SessionToken" => "AWS_SESSION_TOKEN",
      "SessionToken" => "AWS_SECURITY_TOKEN"
    }
  end
end
