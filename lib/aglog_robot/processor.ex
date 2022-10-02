defmodule AglogRobot.Processor do
  @moduledoc """
  This module contains the line processors for every file type.
  """

  @severe_threshold 50
  @information "I"
  @warning "W"
  @error "E"

  @message_types [@information, @warning, @error]

  @spec randomized_type() :: String.t()
  defp randomized_type() do
    type = @message_types |> Enum.random()

    if type === @error do
      severity = :rand.uniform(@severe_threshold - 1)
      "#{type} #{severity}"
    else
      type
    end
  end

  @spec severe_type() :: String.t()
  defp severe_type() do
    severity = :rand.uniform(@severe_threshold) + 50
    "#{@error} #{severity}"
  end

  @spec filtered_processor(String.t(), integer()) :: String.t()
  def filtered_processor(line, _timestamp), do: line

  @spec right_processor(String.t(), integer()) :: String.t()
  def right_processor(line, timestamp), do: "#{randomized_type()} #{timestamp} #{line}"

  @spec severe_processor(String.t(), integer()) :: String.t()
  def severe_processor(line, timestamp), do: "#{severe_type()} #{timestamp} #{line}" 
end
