defmodule Entities.Item do
  defstruct description: "", done: false

  @type t(description, done) :: %Entities.Item{description: description, done: done}
  @type t :: %Entities.Item{description: String.t(), done: true | false}
end
