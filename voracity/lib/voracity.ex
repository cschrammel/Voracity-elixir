defmodule Voracity do

  def grid_width do
    15
  end

  def taken_character do
    "_"
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
    starting_position = :random.uniform(grid_length)
    game_loop("", init_board(), starting_position, [starting_position])
  end

  def game_loop(input, board, position, taken) when input == "q" do
    IO.puts "Game over.  Have a nice day!"
  end

  def game_loop(input, board, position, taken) when input == "d" do
    if can_move_right?(board, position, taken, grid_width) do
      path = path_right(board, position)
      position = position + right_value(board, position)
      taken = taken ++ path
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "a" do
    if can_move_left?(board, position, taken, grid_width) do
      path = path_left(board, position)
      position = position - left_value(board, position)
      taken = taken ++ path
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "w" do
    if can_move_up?(board, position, taken, grid_width) do
      path = path_up(board, position, grid_width)
      position = position - (up_value(board, position, grid_width) * grid_width)
      taken = taken ++ path
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "s" do
    if can_move_down?(board, position, taken, grid_width) do
      path = path_down(board, position, grid_width)
      position = position + (down_value(board, position, grid_width) * grid_width)
      taken = taken ++ path
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) do
    IO.puts "#{IO.ANSI.clear}"
    IO.puts board |> Enum.map &to_view(&1, position, taken)
    IO.puts "Score = " <> to_string(Enum.count(taken))
    if (any_moves_left?(board, position, taken)) do
      input = IO.getn("Enter direction (a=left, d=right, w=up, s=down, q to quit): ", 1)
      game_loop(input, board, position, taken)
    else
      game_loop("q", board, position, taken)
    end
  end

  def any_moves_left?(board, position, taken) do
    can_move_down?(board, position, taken, grid_width)
      or can_move_up?(board, position, taken, grid_width)
      or can_move_left?(board, position, taken, grid_width)
      or can_move_right?(board, position, taken, grid_width)
  end

  def to_view(t, position, taken) do
    value = to_string(elem(t, 0))
    index = elem(t, 1)
    if already_taken?(index, taken) do
      value = taken_character
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

  def path_left(board, position) do
    Enum.map(1..left_value(board, position), 
      fn x -> position - x end)
  end

  def path_right(board, position) do
    Enum.map(1..right_value(board, position), 
      fn x -> position + x end)
  end

  def path_down(board, position, width) do
    Enum.map(1..down_value(board, position, width), 
      fn x -> position + (x * width) end)
  end

  def path_up(board, position, width) do
    Enum.map(1..up_value(board, position, width), 
      fn x -> position - (x * width) end)
  end

  def can_move_right?(board, position, taken, width) do
    right_value(board, position) > 0
      and rem(position, width) < width - 1
      and rem(position, width) + right_value(board, position) < width
      and !is_blocked?(path_right(board, position), taken)
  end

  def can_move_left?(board, position, taken, width) do
    left_value(board, position) > 0
      and rem(position, width) - left_value(board, position) >= 0
      and !is_blocked?(path_left(board, position), taken)
  end
 
  def can_move_up?(board, position, taken, width) do
    up_value(board, position, width) > 0
      and position - (up_value(board, position, width) * width) >= 0
      and !is_blocked?(path_up(board, position, width), taken)
  end

  def can_move_down?(board, position, taken, width) do
    position + width < width * width
      and position + (down_value(board, position, width) * width) < Enum.count(board)
      and !is_blocked?(path_down(board, position, width), taken)
  end

  def left_value(board, position) do
    elem(Enum.at(board, position - 1), 0)
  end

  def right_value(board, position) do
    elem(Enum.at(board, position + 1), 0)
  end

  def up_value(board, position, width) do
    if position - width < 0 do
      0
    else 
      elem(Enum.at(board, position - width), 0)
    end
  end

  def down_value(board, position, width) do
    elem(Enum.at(board, position + width), 0)
  end

  def already_taken?(index, taken) do
    Enum.find_index(taken, fn x -> x == index end) != nil
  end

  def is_blocked?(path, taken) do
    !Set.disjoint?(Enum.into(path, HashSet.new), Enum.into(taken, HashSet.new))
  end

end
