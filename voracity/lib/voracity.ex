defmodule Voracity do

  def random(n) when is_integer(n) and n > 0 do
    :random.seed(:os.timestamp())
    :random.uniform(n)
    #Enum.to_list(1..n) |> Enum.shuffle |> List.first
  end

  def start() do
    IO.puts "Game started...\n"
    f = Enum.map(1..100, fn x -> random(8) end)  
      |> Enum.shuffle
      |> Enum.with_index
      |> Enum.map &to_grid(elem(&1, 1), elem(&1, 0))
  end

  def to_grid(n, x) when rem(n + 1, 10) == 0, do: to_string(x) <> "\n\n"
  def to_grid(n, x),                      do: to_string(x) <> "   "  

end
  
IO.puts Voracity.start()
