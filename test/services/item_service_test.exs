defmodule Services.ItemServiceTest do
  use ExUnit.Case, async: true

  alias Services.ItemService
  alias Entities.{List, Item}

  setup [:list_data_provider]

  defp list_data_provider(_context) do
    {:ok,
     list: %List{
       name: 'Homework',
       items: [
         %Item{description: "Do the math work"}
       ]
     }}
  end

  test "must add a new item to list" do
    item = %Item{description: "Do the math work"}
    list = %List{name: 'Homework'}

    assert ItemService.add_item(list, item) ==
             {:ok,
              %List{
                list
                | items: [
                    %Item{description: "Do the math work"}
                  ]
              }}
  end

  test "must check an item in the list", %{list: list} do
    assert {:ok, %List{items: [%Item{description: "Do the math work", done: true}]}} =
             ItemService.check_item(list, "Do the math work")
  end

  test "should return error when not find an item in the list", %{list: list} do
    assert {:error, :item_not_found} = ItemService.check_item(list, "BANANA")
  end

  test "must uncheck an item in the list", %{list: list} do
    assert {:ok, %List{items: [%Item{done: false}]}} =
             ItemService.uncheck_item(list, "Do the math work")
  end

  test "must remove an item from the list", %{list: list} do
    assert {:ok, %List{items: []}} =
             ItemService.remove_item(list, %Item{description: "Do the math work"})
  end
end
