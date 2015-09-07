defmodule VoracityTest do
  use ExUnit.Case

  test "generate grid of random numbers" do
    grid = Voracity.init_board()

    assert length(grid) == 100
  end

  test "can't move right because on edge" do
    board = [{1, 0}, {2, 1},
             {0, 2}, {0, 3}]
    position = 1
    taken = []

    assert Voracity.can_move_right?(board, position, taken, 2) == false
  end

  test "can move right ending on edge" do
    board = [{1, 0}, {1, 1},
             {0, 2}, {0, 3}]
    position = 0
    taken = []

    assert Voracity.can_move_right?(board, position, taken, 2) == true
  end

  test "can't move right because blocked" do
    board = [{1, 0}, {1, 1}, 
             {0, 2}, {0, 3}]
    position = 0
    taken = [1]

    assert Voracity.can_move_right?(board, position, taken, 2) == false
  end

  test "path right returns list of next moves" do
    board = [{1, 0}, {1, 1}, 
             {0, 2}, {0, 3}]
    position = 0

    assert Voracity.path_right(board, position) == [1]
  end 

  test "can't move left because on edge" do
    board = [{1, 0}, {2, 1},
             {0, 2}, {0, 3}]
    position = 0
    taken = []

    assert Voracity.can_move_left?(board, position, taken, 2) == false
  end

  test "can move left ending on edge" do
    board = [{1, 0}, {1, 1}, 
             {0, 2}, {0, 3}]
    position = 1
    taken = []

    assert Voracity.can_move_left?(board, position, taken, 2) == true
  end

  test "path left returns list of next moves" do
    board = [{1, 0}, {1, 1}, 
             {0, 2}, {0, 3}]
    position = 1
    
    assert Voracity.path_left(board, position) == [0]
  end 

  test "can't move left because blocked" do
    board = [{1, 0}, {1, 1},
             {0, 2}, {0, 3}]
    position = 1
    taken = [0]

    assert Voracity.can_move_left?(board, position, taken, 2) == false
  end

  test "can't move up because on edge" do
    board = [{1, 0}, {2, 1},
             {0, 2}, {0, 3}]
    position = 0
    taken = []

    assert Voracity.can_move_up?(board, position, taken, 2) == false
  end

  test "can move up ending on edge" do
    board = [{1, 0}, {1, 1},
             {1, 2}, {1, 3}]
    position = 2
    taken = []

    assert Voracity.can_move_up?(board, position, taken, 2) == true
  end

  test "can't move up because blocked" do
    board = [{1, 0}, {1, 1},
             {1, 2}, {1, 3}]
    position = 2
    taken = [0]

    assert Voracity.can_move_up?(board, position, taken, 2) == false
  end

  test "path up returns list of next moves" do
    board = [{1, 0}, {1, 1}, 
             {0, 2}, {0, 3}]
    position = 2

    assert Voracity.path_up(board, position, 2) == [0]
  end 

  test "can't move down because on edge" do
    board = [{1, 0}, {2, 1},
             {1, 2}, {1, 3}]
    position = 2
    taken = []

    assert Voracity.can_move_down?(board, position, taken, 2) == false
  end

  test "can move down ending on edge" do
    board = [{1, 0}, {1, 1},
             {1, 2}, {1, 3}]
    position = 1
    taken = []

    assert Voracity.can_move_down?(board, position, taken, 2) == true
  end

  test "can't move down because blocked" do
    board = [{1, 0}, {1, 1},
             {1, 2}, {1, 3}]
    position = 1
    taken = [3]

    assert Voracity.can_move_down?(board, position, taken, 2) == false
  end

 test "path down returns list of next moves" do
    board = [{1, 0}, {1, 1}, 
             {1, 2}, {1, 3}]
    position = 0

    assert Voracity.path_down(board, position, 2) == [2]
  end 

end
