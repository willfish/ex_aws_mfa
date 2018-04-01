defmodule ExAwsMfa.Env do
  def set(credentials) do
    System.put_env("AWS_SECRET_ACCESS_KEY", credentials["SecretAccessKey"])
    System.put_env("AWS_ACCESS_KEY_ID", credentials["AccessKeyId"])
    System.put_env("AWS_SESSION_TOKEN", credentials["SessionToken"])
    System.put_env("AWS_SECURITY_TOKEN", credentials["SessionToken"])
  end

  def unset do
    System.delete_env("AWS_SECRET_ACCESS_KEY")
    System.delete_env("AWS_ACCESS_KEY_ID")
    System.delete_env("AWS_SESSION_TOKEN")
    System.delete_env("AWS_SECURITY_TOKEN")
  end
end
