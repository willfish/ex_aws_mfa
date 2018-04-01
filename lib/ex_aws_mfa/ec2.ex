defmodule ExAwsMfa.Ec2 do
  @hypervisor_file "/sys/hypervisor/uuid"

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
