defmodule Voracity do

  def random(n) do
    :random.uniform(n)
  end

  def init_board() do
    :random.seed(:os.timestamp())
    Stream.map(1..100, fn x -> random(8) end)  
      |> Enum.with_index
  end

  def main(args) do
    IO.puts "#{IO.ANSI.green}Game started...#{IO.ANSI.reset}\n"
    position = random(100)
    game_loop("", Voracity.init_board(), position)
  end

  def game_loop(input, board, position) when input == "q" do
    IO.puts "Have a nice day!"
  end

  def game_loop(input, board, position) do
    IO.puts "#{IO.ANSI.clear}"
    grid = board 
      |> Enum.map &to_grid(elem(&1, 1), elem(&1, 0), position)
    IO.puts grid
    input = IO.getn("Enter direction (q to quit):", 1)
    position = position + 1
    game_loop(input, board, position)
  end

  def to_grid(n, x, position) when rem(n + 1, 10) == 0, do: grid_entry(n, x, position) <> "\n\n"
  def to_grid(n, x, position), do: grid_entry(n, x, position)

  def grid_entry(n, x, position) do
    entry = ""
    if n == position do 
      entry = entry <> "#{IO.ANSI.yellow}"
    end
    entry = entry <> to_string(x) 
    if n == position do 
      entry = entry <> "#{IO.ANSI.reset}"
    end
    entry <> "   "
  end  

end
