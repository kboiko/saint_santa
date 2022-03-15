defmodule SaintSanta.Generator do
  def generate(item_list) do
    #%{name: name, entrance: entrance, floor: floor, flat: flat, number: number} = item

    name_list =
      for i <- item_list do
        {i.name, i.number}
      end
      |> Enum.shuffle

    Enum.reduce(name_list, [],
    fn santa, acc -> acc ++ %{santa, item_list} end)

  end
end
