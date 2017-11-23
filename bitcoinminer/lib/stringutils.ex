defmodule StringUtils do

    def repeat do
        receive do
            {input, k} -> check_string{input, k}
        end
    end

    def check_string{input, k} do
        hash = Base.encode16(:crypto.hash(:sha256, input))
        leading_zeros = String.slice(hash, 0..k-1)
        ch = String.to_charlist(leading_zeros)
        temp = Enum.all?(ch, fn(x) -> x == 48 end)
        if temp == true do
          IO.puts input <>" "<>"#{hash}"
        end
    end


    def generate(k) do
        pids = Enum.map(1..10, fn (_) -> spawn(&StringUtils.repeat/0) end)
        Enum.each pids, fn pid ->
            inp = :crypto.strong_rand_bytes(6) |> Base.encode64 |> binary_part(0,6)
            input = Enum.join(["abhisheksharma", inp], ";")
            send(pid, {input, k})
        end
        generate(k)
    end
  end