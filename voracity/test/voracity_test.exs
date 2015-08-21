defmodule VoracityTest do
  use ExUnit.Case

  test "generate grid of random numbers" do
    grid = Voracity.init_board()

    assert length(grid) == 100
  end

  test "can't move right because on edge" do
    board = [1,2]
    position = 1
    taken = []

    assert Voracity.can_move_right?(board, position, taken) == false
  end

end
