defmodule AglogRobot.RandomTest do
  use ExUnit.Case
  import AglogRobot.Random

  describe "generate_random_seed" do
    test "generates the first seed from the sum of all the codepoints" do
      # given
      seed = [1, 2, 3]
      assert {6, _, _} = generate_random_seed(seed)
    end

    test "generates the second seed from the product of all the codepoints % 100k" do
      seed = [123, 456, 789, 234, 567]
      assert {_, 50896, _} = generate_random_seed(seed)
    end

    test "generates the third seed from product of sum of first four and last four codepoints" do
      seed = [1, 2, 3, 4, 5, 6, 7, 8]
      expected = (1 + 2 + 3 + 4) * (5 + 6 + 7 + 8)
      assert {_, _, ^expected} = generate_random_seed(seed)
    end

    test "seeded numbers always produce the same results" do
      seed = 'Marisa Kirisame'
      seed_generator(seed)
      result1 = :rand.uniform()
      seed_generator(seed)
      result2 = :rand.uniform()

      assert result1 === result2
    end
  end
end
