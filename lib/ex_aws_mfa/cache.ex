defmodule ExAwsMfa.Cache do
  @cache_directory Path.join(System.get_env("HOME"), ".aws/cli/cache")
  @expiration_period 3600

  def load(config) do
    path = cache_path(config)
    case File.read(path) do
      {:ok, content} -> content
      {:error, exception} -> raise "Failed to read cache. #{exception}"
    end
  end

  def flush(credentials, config) do
    path = cache_path(config)

    case File.write(path, credentials) do
      :ok -> credentials
      {:error, exception} -> raise "Failed to cache #{path}. #{exception}"
    end
  end

  def update?(config) do
    # IO.puts file?(config)
    if file?(config) do
      if token_expired?(config) do
        true
      else
        false
      end
    else
      true
    end
  end

  defp file?(config) do
    File.exists?(cache_path(config))
  end

  defp token_expired?(config) do
    {:ok, %{mtime: mtime}} = File.stat(cache_path(config))

    expires_at = Timex.shift(Timex.now(), seconds: @expiration_period)
    Timex.before?(expires_at, mtime)
  end

  defp cache_path(config) do
    file = "#{config.aws_profile}_#{config.role_arn}_mfa_credentials"
    |> String.replace("/", "")

    Path.join(@cache_directory, file)
  end
end
