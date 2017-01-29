defmodule Queue do
  use GenServer
  alias GenServer

  def new(state \\ []), do: start_link(__MODULE__, state, name: __MODULE__)
  def get_state, do: GenServer.call(__MODULE__, :get_state)
  def enqueue(item), do: GenServer.cast(__MODULE__, {:enqueue, item})
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)

  def handle_call( :get_state,   _from, state), do: {:reply, state, state}
  def handle_cast({:enqueue, value}, state), do: {:noreply, state ++ [value]}
  def handle_call( :dequeue, _from, []), do: {:reply, nil, []}
  def handle_call( :dequeue, _from, [item|state]), do: {:reply, item, state}
end
