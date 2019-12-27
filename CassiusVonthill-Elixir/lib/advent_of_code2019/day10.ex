defmodule AdventOfCode2019.Day10 do
  def load_file(path) when is_binary(path) do
    path
    |> File.stream!()
    |> Stream.with_index()
    |> Task.async_stream(fn {line, r} ->
      line
      |> String.trim()
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce([], fn
        {".", _c}, acc -> acc
        {"#", c}, acc -> [{c, r} | acc]
      end)
    end)
    |> Enum.flat_map(&elem(&1, 1))
  end

  def part1(asteroids) when is_list(asteroids) do
    asteroids
    |> find_best_asteroid
    # Found object is {coordinates, count of visible asteroids}
    |> elem(1)
  end

  def find_best_asteroid(asteroids) when is_list(asteroids) do
    asteroids
    |> Flow.from_enumerable()
    # Consider each asteroid in parallel using all cores
    |> Flow.map(&{&1, count_visible_asteroids(&1, asteroids)})
    # Find the one with the most visible asteroids
    |> Enum.max_by(&elem(&1, 1))
  end

  def count_visible_asteroids(target, asteroids) do
    calc_asteroid_cordinates(target, asteroids)
    |> Stream.uniq_by(fn {_polar = {_r, theta}, _catesian} -> theta end)
    |> Enum.count()
  end

  def calc_asteroid_cordinates(target = {t_x, t_y}, asteroids) do
    asteroids
    |> MapSet.new()
    |> MapSet.delete(target)
    |> Stream.map(fn cartesian = {a_x, a_y} -> {{a_x - t_x, a_y - t_y}, cartesian} end)
    |> Enum.map(fn {{dx, dy}, cartesian} ->
      # Atan2 is usually (y, x), but we flip it to (x, y)
      # So that Positive Y is considered 0
      # Later we iterate decreasing so that it moves clockwise
      {{Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2)), Math.atan2(dx, dy)}, cartesian}
    end)
  end

  # Pulled out into function incase there weren't over 200 groupings
  def find_nth_asteroid(theta_map, n) when map_size(theta_map) >= n do
    theta_map
    |> Enum.sort_by(&elem(&1, 0), &>=/2)
    # Account for zero-indexing
    |> Enum.at(n - 1)
    |> elem(1)
    |> List.first()
  end

  def part2(asteroids) when is_list(asteroids) do
    asteroids
    |> find_best_asteroid
    |> elem(0)
    |> calc_asteroid_cordinates(asteroids)
    # Further points are later in list
    |> Enum.sort_by(fn {{r, _theta}, _catesian} -> r end)
    # Turn into a map with theta as keys.
    # Values are kept in relative order so futher points are still later
    |> Enum.group_by(fn {{_r, theta}, _cartesian} -> theta end)
    |> Enum.into(%{})
    |> find_nth_asteroid(200)
    |> (fn {_polar, {x, y}} -> x * 100 + y end).()
  end
end
