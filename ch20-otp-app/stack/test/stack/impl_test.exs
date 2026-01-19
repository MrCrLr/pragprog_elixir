defmodule Stack.ImplTest do
  use ExUnit.Case

  @empty_stack []
  @stack [113, "mrcrlr", 666, "crash"]

  test "returns :stack_empty when calling pop on empty stack" do
    assert Stack.Impl.pop(@empty_stack) == {:reply, :stack_empty, []}
  end

  test "returns item on top of stack and updates stack" do
    assert Stack.Impl.pop(@stack) == {:reply, {:ok, 113}, ["mrcrlr", 666, "crash"]}
  end
end

