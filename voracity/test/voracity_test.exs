defmodule VoracityTest do
  use ExUnit.Case

  test "random" do
    assert Voracity.random(2) > 0
    assert Voracity.random(2) < 3
  end

  test "generate grid of random numbers" do
    grid = Voracity.start()

    IO.puts "#{IO.ANSI.clear}"
    IO.puts grid

    assert length(grid) == 100
  end

end
