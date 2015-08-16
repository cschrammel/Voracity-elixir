defmodule Voracity do

  def random(n) when is_integer(n) and n > 0 do
    :random.seed(:os.timestamp())
    :random.uniform(n)
    #Enum.to_list(1..n) |> Enum.shuffle |> List.first
  end

  def start() do
    IO.puts "#{IO.ANSI.clear}"
    IO.puts "#{IO.ANSI.green}Game started...#{IO.ANSI.reset}\n"
    current = random(100)
    Stream.map(1..100, fn x -> random(8) end)  
      |> Enum.shuffle
      |> Stream.with_index
      |> Enum.map &to_grid(elem(&1, 1), elem(&1, 0), current)
  end

  def main(args) do
    game_loop("")
  end

  def game_loop(input) when input == "exit" do
    IO.puts "Have a nice day!"
  end

  def game_loop(input) do
    IO.puts Voracity.start()
    input = IO.getn("Enter something:", 4)
    game_loop(input)
  end

  def to_grid(n, x, current) when rem(n + 1, 10) == 0, do: to_string(x) <> "\n\n"
  def to_grid(n, x, current) when n == current, do: "#{IO.ANSI.red}" <> to_string(x) <> "#{IO.ANSI.reset}   "
  def to_grid(n, x, current), do: to_string(x) <> "   "  

end
