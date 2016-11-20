defmodule DoubleProcess do
  import :timer, only: [sleep: 1]
  def make_noise do
    receive do
      {sender, msg, wait} -> 
        sleep wait
        send sender, msg
    end
  end
end

pid1 = spawn(DoubleProcess, :make_noise, [])
pid2 = spawn(DoubleProcess, :make_noise, [])

send pid1, {self, "batteries, cocaine, and mushroom pizza", 500}
send pid2, {self, "fried cheeze", 0}

receive do
  msg when msg == "batteries, cocaine, and mushroom pizza" ->
    IO.puts msg
    receive do
      msg ->
        IO.puts msg
    end
end