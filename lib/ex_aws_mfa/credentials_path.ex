defmodule CredentialsPath do
  alias ExAwsMfa.Config

  def path(cache_directory, config) do
    credentials_path = credentials_path(cache_directory, config)
    handle(credentials_path)
  end

  defp credentials_path(cache_directory, config) do
    profile = source_profile(config)
    file = credentials_file(profile)

    Path.join(cache_directory, file)
  end

  defp credentials_file(%Config{source_profile: source, profile: profile}) do
    "#{source}_#{profile}_mfa_credentials"
  end

  defp source_profile(%Config{source_profile: source, profile: profile}), do: source || profile
end
