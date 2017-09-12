defmodule Alchemy do
  @moduledoc """
  Documentation for Alchemy.
  """

  def parse(xml) do
    {:ok, tree, _} = :erlsom.simple_form(xml)
    hd(parse_children(tree))
  end

  defp parse_children({node, _, [value]}) when is_list(value) do
    [%{to_string(node) => to_string(value)}]
  end
  defp parse_children({node, _, children}) do
    [%{to_string(node) => children_to_struct(children, [])}]
  end

  defp children_to_struct([], acc) do
    keys = Enum.flat_map(acc, &Map.keys/1)
    case keys -- Enum.uniq(keys) do
      [] ->
        Enum.reduce(acc, fn (x, acc) -> Map.merge(acc, x) end)
      _ -> acc
    end
  end
  defp children_to_struct([value | rest], acc) when is_tuple(value) do
    children_to_struct(rest, acc ++ parse_children(value))
  end
end
