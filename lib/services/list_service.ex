defmodule Services.ListService do
  @spec create(String.t()) :: {:ok, Entities.List.t()}
  def create(list_name) do
    {:ok, %Entities.List{name: list_name}}
  end
end
