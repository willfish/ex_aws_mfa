defmodule SetEnvTest do
  use ExUnit.Case
  @subject ExAwsMfa.Executors.SetEnv

  describe "execute/2" do
    @credentials struct(ExAwsMfa.Credentials, %{
      AccessKeyId: "foo",
      SecretAccessKey: "foo",
      SessionToken: "foo",
      Expiration: "bar"
    })
    @argv ["echo", "foo"]

    test "sets the env correctly" do
      @subject.execute(@credentials, @argv)
      assert System.get_env("AWS_SECRET_ACCESS_KEY") == "foo"
      assert System.get_env("AWS_ACCESS_KEY_ID") == "foo"
      assert System.get_env("AWS_SESSION_TOKEN") == "foo"
    end
  end
end
