defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} -> 
        send sender, {:ok, "Hello #{msg}!"}
        # Uses tail call optimization so that shit doesn't explode
        # Rescursive call MUST be the last part of the function
        greet
    end
  end
end

pid = spawn(Spawn1, :greet, [])
send pid, {self, "World!"}

receive do
  {:ok, msg} -> IO.puts msg
end

send pid, {self, "Again!"}

receive do
  {:ok, msg} -> IO.puts msg
  after 500 -> IO.puts "Is there anybody out there?"
end