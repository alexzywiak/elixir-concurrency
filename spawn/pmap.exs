defmodule ParallelMap do
  import :timer, only: [sleep: 1]
  def pmap(collection, func) do
    me = self
    collection
    |> Enum.map(fn(elem) -> 
      spawn_link fn ->
        sleep 1000 - elem * 100
        send me, {self, func.(elem)}
      end
    end)
    |> Enum.map(fn(pid) -> 
      receive do {^pid, result} -> result end
    end)
  end
end