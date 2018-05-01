defmodule PrintEnvTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  @subject ExAwsMfa.Executors.PrintEnv

  describe "execute/2" do
    test "prints to stdout" do
      credentials = struct(ExAwsMfa.Credentials, %{
        AccessKeyId: "foo",
        SecretAccessKey: "foo",
        SessionToken: "foo",
        Expiration: "bar"
      })

      actual = capture_io(fn -> @subject.execute(credentials, nil) end)
      expected = "export AWS_SECRET_ACCESS_KEY=foo\nexport AWS_ACCESS_KEY_ID=foo\nexport AWS_SESSION_TOKEN=foo\n\n"
      assert(actual == expected)
    end
  end
end
