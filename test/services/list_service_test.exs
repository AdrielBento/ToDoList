defmodule Services.ListServiceTest do
  use ExUnit.Case, async: true

  alias Services.ListService
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

  test "must create a new to-do list" do
    assert ListService.create('Homework') ==
             {:ok, %List{name: 'Homework', items: []}}
  end

  test "must add a new item to list" do
    item = %Item{description: "Do the math work"}
    list = %List{name: 'Homework'}

    assert ListService.add_item(list, item) ==
             {:ok,
              %List{
                name: 'Homework',
                items: [
                  %Item{description: "Do the math work"}
                ]
              }}
  end

  test "must check an item in the list", context do
    assert ListService.check_item(context[:list], "Do the math work") ==
             {:ok,
              %List{
                name: 'Homework',
                items: [
                  %Item{description: "Do the math work", done: true}
                ]
              }}
  end

  test "should return error when not find an item in the list", context do
    assert ListService.check_item(context[:list], "BANANA") == {:error, "Item not found"}
  end

  test "must uncheck an item in the list", context do
    assert ListService.uncheck_item(context[:list], "Do the math work") ==
             {:ok,
              %List{
                name: 'Homework',
                items: [
                  %Item{description: "Do the math work", done: false}
                ]
              }}
  end

  test "must remove a item from the list", context do
    assert ListService.remove_item(context[:list], "Do the math work") ==
             {:ok,
              %List{
                name: 'Homework',
                items: []
              }}
  end
end
