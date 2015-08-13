defmodule VORACITYTest do
  use ExUnit.Case

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "random" do
    assert VORACITY.random(2) > 0
  end

  test "append random to" do
  	a = VORACITY.append_random_to(8, [], 10)
    Enum.each a, &IO.write(&1)
    [first, second | last] = a
    IO.puts(first)
    assert first > 0
  end
end
