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
    position = random(100)
    game_loop("", init_board(), position)
  end

  def game_loop(input, board, position) when input == "q" do
    IO.puts "Have a nice day!"
  end

  def game_loop(input, board, position) when input == "d" do
    position = position + elem(Enum.at(board, position + 1), 0)
    game_loop("", board, position)
  end

  def game_loop(input, board, position) when input == "a" do
    position = position - elem(Enum.at(board, position - 1), 0)
    game_loop("", board, position)
  end

  def game_loop(input, board, position) when input == "w" do
    above = elem(Enum.at(board, position - 10), 0)
    position = position - (above * 10)
    game_loop("", board, position)
  end

  def game_loop(input, board, position) when input == "s" do
    below = elem(Enum.at(board, position + 10), 0)
    position = position + (below * 10)
    game_loop("", board, position)
  end

  def game_loop(input, board, position) do
    IO.puts "#{IO.ANSI.clear}"
    IO.puts board |> Enum.map &to_view(&1, position)
    input = IO.getn("Enter direction (q to quit):", 1)
    game_loop(input, board, position)
  end

  def to_view(t, position) do
    value = to_string(elem(t, 0))
    index = elem(t, 1)
    if index == position do 
      entry = "#{IO.ANSI.yellow}#{value}#{IO.ANSI.reset}"
    else
      entry = value
    end
    if rem(index + 1, 10) == 0 do
      "#{entry}\n\n"
    else
      "#{entry}   "  
    end
  end

end
