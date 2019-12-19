defmodule AdventOfCode2019.Day6 do
  def load_file(path) do
    for line <- File.stream!(path) do
      line
      |> String.split(")", trim: true)
      |> List.to_tuple()
    end
  end

  defp _gen_tree(input) when is_list(input) do
    com = NaryTree.Node.new("COM")
    tree = NaryTree.new(com)
    name_to_id = %{"COM" => com.id}

    input
    |> Enum.reduce({tree, name_to_id}, fn {parent, child}, _acc = {tree, name_to_id} ->
      child_node = NaryTree.Node.new(child)
      parent_id = name_to_id[parent]

      {NaryTree.add_child(tree, child_node, parent_id),
       Map.put_new(name_to_id, child, child_node.id)}
    end)
    |> elem(0)
  end

  def part1(diagram) when is_list(diagram) do
    diagram
    |> _gen_tree()
    |> NaryTree.to_list()
    |> Enum.reduce(0, &(&1.level + &2))
  end
end
