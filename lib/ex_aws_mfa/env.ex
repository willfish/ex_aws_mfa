defmodule ExAwsMfa.Env do
  def set(%Credentials{} = credentials) do
  end

  def unset(%Credentials{} = credentials) do
    System.delete_env("AWS_SECRET_ACCESS_KEY")
    System.delete_env("'AWS_ACCESS_KEY_ID")
    System.delete_env("AWS_SESSION_TOKEN")
    System.delete_env("AWS_SECURITY_TOKEN")
  end
end
