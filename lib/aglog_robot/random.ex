defmodule AglogRobot.Random do
  @moduledoc """
  Generates a seed from a charlist that can be passed to :random.seed/1
  """
  @type seed() :: {number(), number(), number()}
  @spec generate_random_seed([number()]) :: seed()
  def generate_random_seed([_|_] = seed) do
    first_seed = Enum.sum(seed)
    second_seed = seed |> Enum.reject(&(&1 === 0)) |> Enum.reduce(1, &Kernel.*/2) |> rem(100_000)
    third_seed = (seed |> Enum.take(4) |> Enum.sum()) * (seed |> Enum.take(-4) |> Enum.sum())

    {first_seed, second_seed, third_seed}
  end

  @spec seed_generator(binary() | [number()]) :: :ok
  def seed_generator(seed) when is_list(seed) do
    :rand.seed(:exsplus, generate_random_seed(seed))
    :ok
  end

  def seed_generator(seed) when is_binary(seed) do
    :rand.seed(:exsplus, generate_random_seed(String.to_charlist(seed)))
    :ok
  end
end
