defmodule VORACITY do

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

  def append_random_to(value, a, n) when n <= 1 do
    a ++ [random(value)]
  end

  def append_random_to(value, a, n) do
    a = a ++ [random(value)]
    append_random_to(value, a, n - 1)
  end

  def start() do
     IO.puts "Game started..."
     numbers = append_random_to(8, [], 10)
     IO.puts numbers
  end

end
  
IO.puts VORACITY.start()
