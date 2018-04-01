defmodule ExAwsMfa.CredentialsLoader do
  import ExAwsMfa.CredentialsPath
  import ExAwsMfa.CredentialsHandler

  def load(cache_directory, config) do
    credentials_path = credentials_path(cache_directory, config)
    handle(credentials_path)
  end
end
