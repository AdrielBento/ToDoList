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

  test "must check an item in the list", context do
    assert ItemService.check_item(context[:list], "Do the math work") ==
             {:ok,
              %List{context[:list] | items: [%Item{description: "Do the math work", done: true}]}}
  end

  test "should return error when not find an item in the list", context do
    assert ItemService.check_item(context[:list], "BANANA") == {:error, "Item not found"}
  end

  test "must uncheck an item in the list", context do
    assert ItemService.uncheck_item(context[:list], "Do the math work") ==
             {:ok,
              %List{context[:list] | items: [%Item{description: "Do the math work", done: false}]}}
  end

  test "must remove an item from the list", context do
    assert ItemService.remove_item(context[:list], %Item{description: "Do the math work"}) ==
             {:ok, %List{context[:list] | items: []}}
  end
end
