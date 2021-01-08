defmodule Services.ListService do
  alias Entities.{List, Item}

  def create(list_name) do
    {:ok, %List{name: list_name}}
  end

  def add_item(list = %List{items: list_items}, item) do
    {:ok, %List{list | items: list_items ++ [item]}}
  end
end
