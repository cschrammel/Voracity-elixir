defmodule VoracityTest do
  use ExUnit.Case

  test "random" do
    assert Voracity.random(2) > 0
    assert Voracity.random(2) < 3
  end

  test "generate grid of random numbers" do
    grid = Voracity.init_board()

    assert length(grid) == 100
  end

  test "can't move left" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9}]
    position = 5

    can_move = Voracity.can_move_left?(board, position)

    assert can_move == false
  end

  test "can move left" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9}]
    position = 4

    can_move = Voracity.can_move_left?(board, position)

    assert can_move == true
  end

end
