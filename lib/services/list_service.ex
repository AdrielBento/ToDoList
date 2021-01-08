defmodule Services.ListService do

  def create(list_name) do
    {:ok, %Entities.List{name: list_name}}
  end

  def add_item(list = %Entities.List{items: list_items}, item) do
    {:ok, %Entities.List{list | items: list_items ++ [item]}}
  end

  def check_item(list = %Entities.List{items: list_items}, item_description) do
    item = Enum.find(list_items, &(&1.description == item_description))
    list_items = List.delete(list_items, item)

    item = %Entities.Item{item | done: true}

    {:ok, %Entities.List{list | items: list_items ++ [item]}}
  end
end
