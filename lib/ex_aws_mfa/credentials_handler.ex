defmodule ExAwsMfa.CredentialsHandler do
  alias ExAwsMfa.Cache
  alias ExAwsMfa.Commands.AwsStsAssumeRole

  def handle(config) do
    if Cache.update?(config) do
      fetch(config)
    else
      load(config)
    end
    |> ExAwsMfa.Credentials.decode!()
  end

  defp fetch(config) do
    AwsStsAssumeRole.build(config)
    |> AwsStsAssumeRole.run()
    |> ExAwsMfa.Credentials.decode!()
    |> ExAwsMfa.Credentials.encode!()
    |> Cache.flush(config)
  end

  defp load(config) do
    Cache.load(config)
  end
end
