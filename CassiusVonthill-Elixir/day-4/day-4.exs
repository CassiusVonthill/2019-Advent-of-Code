defmodule Day4 do
  require Integer

  # for when inputs are "123257-647015"
  def solution(input) when is_binary(input) do
    input
    |> String.trim()
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> (fn [a, b] -> solution(a, b) end).()
  end

  def solution(current, end_range), do: count_options(current, end_range, {0, 0})

  def count_options(current, end_range, results = {_unpure, _pure}) when current > end_range,
    do: results

  def count_options(current, end_range, {unpure, pure}) do
    {du, dp} =
      with dig <- Integer.digits(current),
           true <- dig == Enum.sort(dig),
           integer_counts <-
             Enum.reduce(dig, %{}, fn k, acc -> Map.update(acc, k, 1, &(&1 + 1)) end),
           true <- Enum.any?(integer_counts, fn {_k, v} -> v >= 2 end) do
        with true <-
               Enum.any?(integer_counts, fn {_k, v} -> v == 2 end) do
          {1, 1}
        else
          _err -> {1, 0}
        end
      else
        _err -> {0, 0}
      end

    count_options(current + 1, end_range, {unpure + du, pure + dp})
  end
end
