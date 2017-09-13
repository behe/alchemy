defmodule Alchemy do
  @moduledoc """
  Documentation for Alchemy.
  """

  def parse(xml) do
    {:ok, tree, _} = :erlsom.simple_form(xml)
    hd(parse_tree(tree))
  end

  defp parse_tree({node, _, [value]}) when is_list(value) do
    [%{to_string(node) => to_string(value)}]
  end
  defp parse_tree({node, _, children}) do
    [%{to_string(node) => children_to_struct(children, [])}]
  end

  defp children_to_struct([], acc) do
    keys = Enum.flat_map(acc, &Map.keys/1)
    list_or_map(keys -- Enum.uniq(keys), acc)
  end
  defp children_to_struct([value | rest], acc) when is_tuple(value) do
    children_to_struct(rest, acc ++ parse_tree(value))
  end

  defp list_or_map([], []), do: []
  defp list_or_map([], list) do
    Enum.reduce(list, fn (x, list) -> Map.merge(list, x) end)
  end
  defp list_or_map(_, list), do: list
end
