defmodule Services.ListService do
  @spec create(String.t()) :: {:ok, Entities.List.t()}
  def create(list_name) do
    {:ok, %Entities.List{name: list_name}}
  end

  @spec add_item(Entities.List.t(), Entities.Item.t()) :: {:ok, Entities.List.t()}
  def add_item(list = %Entities.List{items: list_items}, item) do
    {:ok, %Entities.List{list | items: list_items ++ [item]}}
  end

  @spec check_item(Entities.List.t(), String.t()) :: {:ok, Entities.List.t()}
  def check_item(list = %Entities.List{items: list_items}, item_description) do
    case find_item_by_description(list_items, item_description) do
      {:error, message} ->
        {:error, message}

      {:ok, item} ->
        list_items = List.delete(list_items, item)
        item = %Entities.Item{item | done: true}
        {:ok, %Entities.List{list | items: list_items ++ [item]}}
    end
  end

  @spec uncheck_item(Entities.List.t(), String.t()) :: {:ok, Entities.List.t()}
  def uncheck_item(list = %Entities.List{items: list_items}, item_description) do
    case find_item_by_description(list_items, item_description) do
      {:error, message} ->
        {:error, message}

      {:ok, item} ->
        list_items = List.delete(list_items, item)
        item = %Entities.Item{item | done: false}
        {:ok, %Entities.List{list | items: list_items ++ [item]}}
    end
  end

  @spec find_item_by_description(any, any) :: any
  def find_item_by_description(list_items, item_description) do
    item = Enum.find(list_items, &(&1.description == item_description))

    case item do
      nil -> {:error, "Item not found"}
      _ -> {:ok, item}
    end
  end
end
