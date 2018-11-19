defmodule Demo do
  def run do
    try do
      # throw "val"
      # exit :normal # process ended normally
      # exit :very_bad
      exit :wat
    catch
      "val" -> "caught"
      :exit, :very_bad -> "exited due to very_bad"
      :exit, _ -> "ok...now we're screwed..."
      _ -> "not sure"
    end
  end
end

Demo.run |> IO.inspect