defmodule Bitcoinminer do

    use GenServer
    
    def main(args) do
      if Enum.at(args,0) =~ "." do
            Slave.start_link(Enum.at(args,0))
        else
            {num,_} = Integer.parse(Enum.at(args,0))
            start_link(num)
        end
    end

    def start_link(k) do
        ip=resolve_ip(0)
        :global.sync()
        generate(k)
    end

    def slaves(node_name,k) do
        GenServer.cast({Slave1, :"#{node_name}"},{:param,k}) 
    end
    
    def resolve_ip(index) do
        l = Enum.at(:inet.getif() |> Tuple.to_list,1)
        ip_addr = ""
        if elem(Enum.at(l,index),0) == {127, 0, 0, 1} do
          resolve_ip(index+1) 
        else
          ip_addr = elem(Enum.at(l,index),0) |> Tuple.to_list |> Enum.join(".")
        end
        {:ok, _} = Node.start(:"Master@#{ip_addr}")
        cookie = Application.get_env(self(), :cookie)
        Node.set_cookie(cookie)
        GenServer.start_link(__MODULE__,:ok,name: Server)
       end
    
    def init(data) do
        {:ok,data}
    end
    
    def generate(k) do
        server = spawn (fn-> 
            listen(k)
        end)
        :global.sync()
        :global.register_name(:server,server)
        StringUtils.generate(k)
    end
    
    def listen(k) do
        receive do 
            msg->slaves(msg,k) 
        end
        listen(k)
    end
    
    def handle_cast({:receivehash, hashed}, state) do
        IO.puts  "#{hashed}"
        {:noreply,state}
    end
end