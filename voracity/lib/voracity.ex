defmodule Voracity do

  def grid_width do
    12
  end

  def grid_length do
    round :math.pow(grid_width, 2)
  end

  def init_board() do
    :random.seed(:os.timestamp())
    Stream.map(1..grid_length, fn x -> :random.uniform(8) end)  
      |> Enum.with_index
  end

  def main(args) do
    game_loop("", init_board(), :random.uniform(grid_length), [])
  end

  def game_loop(input, board, position, taken) when input == "q" do
    IO.puts "Have a nice day!"
  end

  def game_loop(input, board, position, taken) when input == "d" do
    right = right_value(board, position)
    path = Enum.map(0..right - 1, fn x -> position + x end)
    if can_move_right?(board, position, path, taken) do
      position = position + right
      taken = taken ++ path
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "a" do
    left = left_value(board, position)
    path = Enum.map(0..left - 1, fn x -> position - x end)
    if can_move_left?(board, position, path, taken) do
      position = position - left
      taken = taken ++ path
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "w" do
    above = up_value(board, position)
    path = Enum.map(0..above - 1, fn x -> position - (x * grid_width) end)
    if can_move_up?(board, position, path, taken) do
      position = position - (above * grid_width)
      taken = taken ++ path
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "s" do
    below = down_value(board, position)
    path = Enum.map(0..below - 1, fn x -> position + (x * grid_width) end)
    if can_move_down?(board, position, path, taken) do
      position = position + (below * grid_width)
      taken = taken ++ path
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) do
    IO.puts "#{IO.ANSI.clear}"
    IO.puts board |> Enum.map &to_view(&1, position, taken)
    IO.puts "Score = " <> to_string(Enum.count(taken))
    input = IO.getn("Enter direction (q to quit): ", 1)
    game_loop(input, board, position, taken)
  end

  def to_view(t, position, taken) do
    value = to_string(elem(t, 0))
    index = elem(t, 1)
    if already_taken?(index, taken) do
      value = "."
    end
    if index == position do
      entry = "#{IO.ANSI.green}#{value}#{IO.ANSI.reset}"
    else
      entry = value
    end
    if rem(index + 1, grid_width) == 0 do
      "#{entry}\n\n"
    else
      "#{entry}   "  
    end
  end

  def can_move_right?(board, position, path, taken) do
    rem(position, grid_width) + right_value(board, position) < grid_width 
      and !is_blocked?(path, taken)
  end

  def can_move_left?(board, position, path, taken) do
    rem(position, grid_width) - left_value(board, position) >= 0
      and !is_blocked?(path, taken)
  end
 
  def can_move_up?(board, position, path, taken) do
    position - (up_value(board, position) * grid_width) >= 0
      and !is_blocked?(path, taken)
  end

  def can_move_down?(board, position, path, taken) do
    position + (down_value(board,position) * grid_width) < Enum.count(board)
      and !is_blocked?(path, taken)
  end

  def left_value(board, position) do
    elem(Enum.at(board, position - 1), 0)
  end

  def right_value(board, position) do
    elem(Enum.at(board, position + 1), 0)
  end

  def up_value(board, position) do
    elem(Enum.at(board, position - grid_width), 0)
  end

  def down_value(board, position) do
    elem(Enum.at(board, position + grid_width), 0)
  end

  def already_taken?(index, taken) do
    Enum.find_index(taken, fn x -> x == index end) != nil
  end

  def is_blocked?(path, taken) do
      !Set.disjoint?(Enum.into(path, HashSet.new), Enum.into(taken, HashSet.new))
  end

end
