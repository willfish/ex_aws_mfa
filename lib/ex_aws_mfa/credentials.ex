defmodule ExAwsMfa.Credentials do
  alias ExAwsMfa.Credentials

  @derive [Poison.Encoder]

  defstruct [:AccessKeyId, :SecretAccessKey, :SessionToken, :Expiration]

  def encode!(credentials) do
    Poison.encode!(credentials)
  end

  def decode!(credentials) when is_binary(credentials) do
    Poison.decode!(credentials, as: Credentials)
  end

  def decode!(credentials) when is_list(credentials) do
    credentials =
      List.to_string(credentials)
      |> String.replace("\n", "")
      |> Poison.decode!()

    credentials = credentials["Credentials"]
    %Credentials{
      AccessKeyId: credentials["AccessKeyId"],
      SecretAccessKey: credentials["SecretAccessKey"],
      SessionToken: credentials["SessionToken"],
      Expiration: credentials["Expiration"],
    }
  end

  def present(credentials) do
    """
    export AWS_SECRET_ACCESS_KEY=#{credentials["SecretAccessKey"]}
    export AWS_ACCESS_KEY_ID=#{credentials["AccessKeyId"]}
    export AWS_SESSION_TOKEN=#{credentials["SessionToken"]}
    export AWS_SECURITY_TOKEN=#{credentials["SessionToken"]}
    """
  end

  def log(credentials) do
    IO.puts credentials
    credentials
  end
end
