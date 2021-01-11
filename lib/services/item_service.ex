defmodule Services.ItemService do
  @spec add_item(Entities.List.t(), Entities.Item.t()) :: {:ok, Entities.List.t()}
  def add_item(list = %Entities.List{items: list_items}, item) do
    {:ok, %Entities.List{list | items: list_items ++ [item]}}
  end

  @spec check_item(Entities.List.t(), Entities.Item.t() | String.t()) ::
          {:ok, Entities.List.t()} | {:error, :item_not_found}
  def check_item(list = %Entities.List{}, item) do
    case maybe_find_item(list.items, item) do
      nil ->
        {:error, :item_not_found}

      item ->
        list = delete_item_from_list(item, list)
        item = %Entities.Item{item | done: true}
        {:ok, %Entities.List{list | items: list.items ++ [item]}}
    end
  end

  @spec uncheck_item(Entities.List.t(), Entities.Item.t() | String.t()) ::
          {:ok, Entities.List.t()} | {:error, :item_not_found}
  def uncheck_item(list = %Entities.List{}, item) do
    case maybe_find_item(list.items, item) do
      nil ->
        {:error, :item_not_found}

      item ->
        list = delete_item_from_list(item, list)
        item = %Entities.Item{item | done: false}
        {:ok, %Entities.List{list | items: list.items ++ [item]}}
    end
  end

  @spec remove_item(Entities.List.t(), Entities.Item.t() | String.t()) ::
          {:ok, Entities.List.t()} | {:error, :item_not_found}
  def remove_item(list = %Entities.List{}, item) do
    case maybe_find_item(list.items, item) do
      nil -> {:error, :item_not_found}
      item -> {:ok, delete_item_from_list(item, list)}
    end
  end

  @spec delete_item_from_list(Entities.Item.t(), Entities.List.t()) :: Entities.List.t()
  defp delete_item_from_list(item = %Entities.Item{}, list = %Entities.List{}) do
    %Entities.List{list | items: List.delete(list.items, item)}
  end

  defp maybe_find_item(list_items, %Entities.Item{description: item_description}) do
    maybe_find_item(list_items, item_description)
  end

  defp maybe_find_item(list_items, item_description) do
    Enum.find(list_items, &(&1.description == item_description))
  end
end
