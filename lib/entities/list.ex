defmodule Entities.List do
  defstruct name: "", items: []

  @type t(name, items) :: %Entities.List{name: name, items: items}
  @type t :: %Entities.List{name: String.t(), items: [Entities.Item]}
end
