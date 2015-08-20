defmodule Voracity do

  def random(n) do
    :random.uniform(n)
  end

  def init_board() do
    :random.seed(:os.timestamp())
    Stream.map(1..grid_width * grid_width, fn x -> random(8) end)  
      |> Enum.with_index
  end

  def main(args) do
    position = random(grid_width * grid_width)
    game_loop("", init_board(), position, [])
  end

  def game_loop(input, board, position, taken) when input == "q" do
    IO.puts "Have a nice day!"
  end

  def game_loop(input, board, position, taken) do
    IO.puts "#{IO.ANSI.clear}"
    IO.puts board 
      |> Enum.map &to_view(&1, position, taken)

    IO.puts "Score = " <> to_string(Enum.count(taken))
    input = IO.getn("Enter direction (q to quit):", 1)
    game_loop(input, board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "d" do
    if can_move_right?(board, position) do
      right = elem(Enum.at(board, position + 1), 0)
      new_position = position + right
      path = Enum.map(0..right - 1, fn x -> position + x end)
      if !is_blocked(path, taken) do
        position = new_position
        taken = taken ++ path
      end
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "a" do
    if can_move_left?(board, position) do
      left = elem(Enum.at(board, position - 1), 0)
      new_position = position - left
      path = Enum.map(0..left - 1, fn x -> position - x end)
      if !is_blocked(path, taken) do
        position = new_position
        taken = taken ++ path
      end
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "w" do
    if can_move_up?(board, position) do
      above = elem(Enum.at(board, position - grid_width), 0)
      new_position = position - (above * grid_width)
      path = Enum.map(0..above - 1, fn x -> position - (x * grid_width) end)
      if !is_blocked(path, taken) do
        position = new_position
        taken = taken ++ path
      end
    end
    game_loop("", board, position, taken)
  end

  def game_loop(input, board, position, taken) when input == "s" do
    if can_move_down?(board, position) do
      below = elem(Enum.at(board, position + grid_width), 0)
      new_position = position + (below * grid_width)
      path = Enum.map(0..below - 1, fn x -> position + (x * grid_width) end)
      if !is_blocked(path, taken) do
        position = new_position
        taken = taken ++ path
      end
    end
    game_loop("", board, position, taken)
  end

  def is_blocked(path, taken) do
      s1 = HashSet.new
      s2 = HashSet.new
      !Set.disjoint?(Enum.into(path, s1), Enum.into(taken, s2))
  end

  def to_view(t, position, taken) do
    value = to_string(elem(t, 0))
    index = elem(t, 1)
    if Enum.find_index(taken, fn x -> x == index end) != nil do
      value = "_"
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

  def can_move_right?(board, position) do
    rem(position, grid_width) + elem(Enum.at(board, position + 1), 0) < grid_width
  end

  def can_move_left?(board, position) do
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
