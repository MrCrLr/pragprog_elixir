defmodule Stack.Server do
  use GenServer

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _from, []) do
    {:reply, :stack_empty, []}
  end

  def handle_call(:pop, _from, [top | rest]) do
    {:reply, {:ok, top}, rest}
  end

  def handle_call(:print, _from, stack) do
    {:reply, {:ok, inspect(stack)}, stack}
  end 

  def handle_cast({:push, item}, stack) do
    {:noreply, [item | stack]}
  end
end

"""
iex> {:ok, pid} = GenServer.start_link(
         Stack.Server, [69, 666, "usurper", 7, 11],
         [debug: [:trace, :statistics]])
{:ok, #PID<0.170.0>}

iex> {:ok, pid} = GenServer.start_link(Stack.Server, [69, 666, "usurper", 7, 11])
### alt ### iex> {:ok, pid} = GenServer.start_link(Stack.Server, [69, 666, "usurper", 7, 11], name: :stack)
{:ok, #PID<0.148.0>}

iex> GenServer.call(pid, :pop)
### alt ### iex> GenServer.call(:stack, :pop)
{:ok, 69}

iex> GenServer.cast({:push, "oink oink"})
:ok

iex> GenServer.call(pid, :print)
{:ok, "[\"oink oink\", 666, \"usurper\", 7, 11]"}

iex> :sys.statistics pid, :get
{:ok,
 [
  start_time: {{2026, 1, 9}, {19, 21, 14}},
   current_time: {{2026, 1, 9}, {19, 27, 2}},
   reductions: 1445,
   messages_in: 4,
   messages_out: 3
 ]}

iex> :sys.get_status pid
{:status, #PID<0.158.0>, {:module, :gen_server},
 [
   [
     "$initial_call": {Stack.Server, :init, 1},
     "$ancestors": [#PID<0.148.0>, #PID<0.94.0>]
   ],
   :running,
   #PID<0.148.0>,
   [
     statistics: {{{2026, 1, 9}, {19, 21, 14}}, {:reductions, 233}, 4, 3},
     trace: true
   ],
   [
     header: ~c"Status for generic server <0.158.0>",
     data: [
       {~c"Status", :running},
       {~c"Parent", #PID<0.148.0>},
       {~c"Logged events", []}
     ],
     data: [{~c"State", ["oink oink", 666, "usurper", 7, 11]}]
   ]
 ]}
"""
