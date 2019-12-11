defmodule Day4Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day4

  test "{Unpure, Pure} possibilites" do
    output = Day4.solution("123257-647015")

    assert output == {2220, 1515}
  end
end
