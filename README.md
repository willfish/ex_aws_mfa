# ExAwsMfa

Do you generate temporary credentials using AWS STS?

This mix project enables you to conveniently wrap all your shell commands
inside of a call to `ExAwsMfa` without the need to hard code environment
variables with copy and paste or worry about expiring sessions.

This is a port of the original AWS MFA gem found [here](https://github.com/lonelyplanet/aws-mfa/). The original repository is for a stand-alone shell script to prepare the environment to interact with AWS SDK tools. `ExAwsMfa` is both a stand-alone shell script and can also be inserted into an Elixir application to prepare the environment for a single instance. It retrieves temporary credentials for assuming an AWS role, by first obtaining an MFA token from the user.

It uses [AWS STS](http://docs.aws.amazon.com/cli/latest/reference/sts/index.html) to get temporary credentials. This is necessary if you have [MFA](https://aws.amazon.com/iam/details/mfa/) enabled on your account.

In the main modes, the variables `ExAwsMfa` sets are:

* AWS_SECRET_ACCESS_KEY
* AWS_ACCESS_KEY_ID
* AWS_SESSION_TOKEN
* AWS_SECURITY_TOKEN

The mix project can assume different roles specified by AWS_PROFILE.

`ExAwsMfa` has four modes:

1. Cache only (add `--cache-only` to the invocation)
2. Cache and print (pass no arguments)
2. Cache and assign the credentials in the environment
4. Cache, set the credentials in the environment and execute a command passed in
by the shell

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_aws_mfa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_aws_mfa, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_aws_mfa](https://hexdocs.pm/ex_aws_mfa).
