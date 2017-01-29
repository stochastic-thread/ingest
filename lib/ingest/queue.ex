defmodule Queue do
  use GenServer

  def new(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end


  def handle_cast({:enqueue, value}, state), do: {:noreply, state ++ [value]}
  def handle_call( :get_state,   _from, state), do: {:reply, state, state}
  def handle_call( :dequeue, _from, []), do: {:reply, nil, []}
  def handle_call( :dequeue, _from, [item|state]), do: {:reply, item, state}
  def enqueue(item), do: GenServer.cast(__MODULE__, {:enqueue, item})
  def get_state, do: GenServer.call(__MODULE__, :get_state)
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end
