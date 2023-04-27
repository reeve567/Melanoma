defmodule MelanomaTest do
  use ExUnit.Case
  doctest Melanoma

  test "greets the world" do
    assert Melanoma.hello() == :world
  end
end
