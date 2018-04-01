defmodule ExAwsMfaClient do
  @hypervisor_file "/sys/hypervisor/uuid"

  def execute(true, execution_output \\ :set_env, profile \\ nil) do
    # AwsMfa.execute(execution_output, profile)
  end

  def execute(false, _, _), do: nil

  def ec2? do
    hypervisor_file?() && ec2_instance?()
  end

  defp ec2_instance? do
    {:ok, result} = File.read(@hypervisor_file)

    String.slice(result, 0..2) == "ec2"
  end

  defp hypervisor_file? do
    File.exists?(@hypervisor_file)
  end
end
