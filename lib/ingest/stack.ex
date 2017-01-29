defmodule Stack do
  use GenServer

  def new(s \\ []), do: GenServer.start_link(__MODULE__, s, name: __MODULE__)
  def get_state, do: GenServer.call(__MODULE__, :get_state)
  def peek, do: GenServer.call(__MODULE__, :peek)
  def pop, do: GenServer.call(__MODULE__, :pop)
  def push(item), do: GenServer.cast(__MODULE__, {:push, item})

  def handle_call( :get_state,  _f, state), do: {:reply, state, state}
  def handle_call( :peek,  _f, [item|state]), do: {:reply, item, [item|state]}
  def handle_call( :pop, _f, []), do: {:reply, nil, []}
  def handle_call( :pop, _f, [item|state]), do: {:reply, item, state}
  def handle_cast({:push, item}, state), do: {:noreply, [item | state]}
end
