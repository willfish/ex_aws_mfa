defmodule CacheOnlyTest do
  use ExUnit.Case

  @subject ExAwsMfa.Executors.CacheOnly

  describe "execute/2" do
    test "returns nil" do
      assert @subject.execute(nil, nil) == nil
    end
  end
end
