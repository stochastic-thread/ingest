defmodule Stack do
  use GenServer

  def new(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def handle_call( :get_state,   _from, state), do: {:reply, state, state}
  def handle_cast({:push, item}, state), do: {:noreply, [item | state]}
  def handle_call( :peek,  _from, [item|state]), do: {:reply, item, [item|state]}
  def handle_call( :pop, _from, []), do: {:reply, nil, []}
  def handle_call( :pop, _from, [item|state]), do: {:reply, item, state}

  def get_state, do: GenServer.call(__MODULE__, :get_state)
  def push(item), do: GenServer.cast(__MODULE__, {:push, item})
  def peek, do: GenServer.call(__MODULE__, :peek)
  def pop, do: GenServer.call(__MODULE__, :pop)
end
