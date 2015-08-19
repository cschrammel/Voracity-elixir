defmodule Voracity do

  def random(n) do
    :random.uniform(n)
  end

  def init_board() do
    :random.seed(:os.timestamp())
    Stream.map(1..grid_width*grid_width, fn x -> random(8) end)  
      |> Enum.with_index
  end

  def main(args) do
    position = random(grid_width*grid_width)
    game_loop("", init_board(), position)
  end

  def game_loop(input, board, position) when input == "q" do
    IO.puts "Have a nice day!"
  end

  def game_loop(input, board, position) when input == "d" do
    if can_move_left?(board, position) do
      position = position + elem(Enum.at(board, position + 1), 0)
    end
    game_loop("", board, position)
  end

  def game_loop(input, board, position) when input == "a" do
    if can_move_right?(board, position) do
      position = position - elem(Enum.at(board, position - 1), 0)
    end
    game_loop("", board, position)
  end

  def game_loop(input, board, position) when input == "w" do
    if can_move_up?(board, position) do
      above = elem(Enum.at(board, position - grid_width), 0)
      position = position - (above * grid_width)
    end
    game_loop("", board, position)
  end

  def game_loop(input, board, position) when input == "s" do
    if can_move_down?(board, position) do
      below = elem(Enum.at(board, position + grid_width), 0)
      position = position + (below * grid_width)
    end
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
    if rem(index + 1, grid_width) == 0 do
      "#{entry}\n\n"
    else
      "#{entry}   "  
    end
  end

  def can_move_left?(board, position) do
    rem(position, grid_width) + elem(Enum.at(board, position + 1), 0) < grid_width
  end

  def can_move_right?(board, position) do
    rem(position, grid_width) - elem(Enum.at(board, position - 1), 0) >= 0
  end
 
  def can_move_up?(board, position) do
    above = elem(Enum.at(board, position - grid_width), 0)
    position - (above * grid_width) >= 0
  end

  def can_move_down?(board, position) do
    below = elem(Enum.at(board, position + grid_width), 0)
    position + (below * grid_width) < Enum.count(board)
  end

  def grid_width do
    10
  end

end
