
defmodule Voracity do
  def print_multiple_times(n) when n <= 1 do
    IO.write random(8)
  end

  def print_multiple_times(n) do
    IO.write random(8)
    print_multiple_times(n - 1)
  end

  def random(n) when is_integer(n) and n > 0 do
    :random.seed(:os.timestamp())
    :random.uniform(n)
  end

  def start() do
     IO.puts "Game started..."
     IO.puts print_multiple_times(100)
  end

end
  
IO.puts Voracity.start()
