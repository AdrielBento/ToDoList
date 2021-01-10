defmodule Services.ListServiceTest do
  use ExUnit.Case, async: true

  alias Services.ListService
  alias Entities.List

  test "must create a new to-do list" do
    assert ListService.create('Homework') ==
             {:ok, %List{name: 'Homework', items: []}}
  end
end
