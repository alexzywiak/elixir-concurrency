defmodule MultipleProcesses do
  import :timer, only: [sleep: 1]
  def reply(sender) do
    send sender, "ballz"
    # exit(:blammo)
    raise "blammo"
  end

  def run do
    spawn_monitor(MultipleProcesses, :reply, [self])
    sleep 1000
    reset
  end
end

MultipleProcesses.run