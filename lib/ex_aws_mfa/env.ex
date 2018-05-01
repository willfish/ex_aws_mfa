defmodule ExAwsMfa.Env do
  def set(credentials) do
    secret_access_key = Map.fetch!(credentials, :SecretAccessKey)
    access_key_id = Map.fetch!(credentials, :AccessKeyId)
    session_token = Map.fetch!(credentials, :SessionToken)

    System.put_env("AWS_SECRET_ACCESS_KEY", secret_access_key)
    System.put_env("AWS_ACCESS_KEY_ID", access_key_id)
    System.put_env("AWS_SESSION_TOKEN", session_token)
  end

  def unset do
    System.delete_env("AWS_SECRET_ACCESS_KEY")
    System.delete_env("AWS_ACCESS_KEY_ID")
    System.delete_env("AWS_SESSION_TOKEN")
  end
end
