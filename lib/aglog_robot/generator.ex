defmodule AglogRobot.Generator do
  alias AglogRobot.Random
  alias AglogRobot.Processor

  @sources_right "sources_right"
  @sources_filtered "sources_filtered"
  @sources_severe "sources_severe"

  @type in_directory(t) :: {integer(), String.t(), t}

  @spec get_path(String.t()) :: String.t()
  @spec get_path(String.t(), String.t()) :: String.t()
  defp get_path(directory, file \\ ""), do: "#{File.cwd!()}/assets/#{directory}/#{file}"

  @spec read_files() :: [in_directory(String.t())]
  def read_files() do
      [@sources_right, @sources_filtered, @sources_severe]
      |> Enum.flat_map(fn dir -> File.ls!(get_path(dir)) |> Enum.map(fn file -> {dir, file} end) end)
      |> Enum.with_index()
      |> Enum.map(fn {{dir, file}, index} -> {dir, File.read!(get_path(dir, file)), index} end)
  end

  @spec split_long_line(String.t()) :: [String.t()]
  def split_long_line(line) do
    line
    |> String.split(" ")
    |> Enum.chunk_every(13)
    |> Enum.map(&Enum.join(&1, " "))
  end

  @spec get_processor(String.t()) :: ((String.t, integer()) -> String.t())
  def get_processor(@sources_filtered), do: &Processor.filtered_processor/2
  def get_processor(@sources_right), do: &Processor.right_processor/2
  def get_processor(@sources_severe), do: &Processor.severe_processor/2

  @spec generate_logs(String.t() | nonempty_charlist) :: String.t()
  def generate_logs(seed) do
    :ok = Random.seed_generator(seed)

    read_files()
    |> Enum.map(fn {dir, content, index} ->
      {dir, content |> String.trim() |> String.split("\n") |> Enum.flat_map(&split_long_line/1) |> Enum.with_index(), index}
    end)
    |> Enum.flat_map(fn {dir, lines, source_index} -> 
      processor = get_processor(dir)
      timestamp = source_index * 1000
      Enum.map(lines, fn {line, line_index} -> processor.(line, timestamp + line_index) end)
    end)
    |> Enum.shuffle()
    |> Enum.join("\n")
  end
end
