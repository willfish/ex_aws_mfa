defmodule SetEnvAndExecTest do
  use ExUnit.Case
  @subject ExAwsMfa.Executors.SetEnvAndExec
  import ExUnit.CaptureIO

  describe "execute/2" do
    @credentials struct(ExAwsMfa.Credentials, %{
      AccessKeyId: "foo",
      SecretAccessKey: "foo",
      SessionToken: "foo",
      Expiration: "bar"
    })
    @argv ["echo", "foo"]

    test "sets the env and executes the shell command" do
      assert(capture_io(fn ->
        @subject.execute(@credentials, @argv)
      end) == "foo\n\n")
      assert System.get_env("AWS_SECRET_ACCESS_KEY") == "foo"
      assert System.get_env("AWS_ACCESS_KEY_ID") == "foo"
      assert System.get_env("AWS_SESSION_TOKEN") == "foo"
    end
  end
end
