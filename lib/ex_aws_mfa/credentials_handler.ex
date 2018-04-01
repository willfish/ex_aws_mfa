defmodule ExAwsMfa.CredentialsHandler do
  alias ExAwsMfa.Commands.FetchCredentials
  alias ExAwsMfa.Credentials

  @expiration_period 3600

  defmacro is_token_expired(credentials_path) do
    quote do
    end
  end

  def handle(credentials_path, config),
    do: credentials(credentials_path, config) |> Credentials.decode!()

  defp credentials(credentials_path, config) do
    if token_expired?(credentials_path) do
      FetchCredentials.build(config)
      |> FetchCredentials.run()
    else
      {:ok, content} = File.read(credentials_file)

      content
    end
  end

  def token_expired?(credentials_path) do
    {:ok, %{mtime: mtime}} = File.stat(credentials_path)

    Timex.before?(mtime, Timex.shift(Timex.now(), seconds: @expiration_period))
  end
end
