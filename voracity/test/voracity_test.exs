defmodule VoracityTest do
  use ExUnit.Case

  test "generate grid of random numbers" do
    grid = Voracity.init_board()

    assert length(grid) == 100
  end

  test "can't move left" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9}]
    can_move = Voracity.can_move_left?(board, 5)
    assert can_move == false
  end

  test "can move left" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9}]
    can_move = Voracity.can_move_left?(board, 4)
    assert can_move == true
  end

  test "can't move right" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9}]
    can_move = Voracity.can_move_right?(board, 5)
    assert can_move == false
  end

  test "can move right" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9}]
    can_move = Voracity.can_move_right?(board, 4)
    assert can_move == true
  end

  test "can't move up" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9},
             {6,10},{2,11},{6,12},{4,13},{7,14},{1,15},{6,16},{8,17},{3,18},{1,19}]
    can_move = Voracity.can_move_up?(board, 10)
    assert can_move == false
  end

  test "can move up" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9},
             {6,10},{2,11},{6,12},{4,13},{7,14},{1,15},{6,16},{8,17},{3,18},{1,19}]
    can_move = Voracity.can_move_up?(board, 15)
    assert can_move == true
  end

  test "can't move down" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9},
             {6,10},{2,11},{6,12},{4,13},{7,14},{1,15},{6,16},{8,17},{3,18},{1,19}]
    can_move = Voracity.can_move_down?(board, 0)
    assert can_move == false
  end

  test "can move down" do
    board = [{6,0},{2,1},{6,2},{4,3},{7,4},{1,5},{6,6},{8,7},{3,8},{1,9},
             {6,10},{2,11},{6,12},{4,13},{7,14},{1,15},{6,16},{8,17},{3,18},{1,19}]
    can_move = Voracity.can_move_down?(board, 5)
    assert can_move == true
  end  
end
