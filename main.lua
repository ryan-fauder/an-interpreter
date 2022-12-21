require "interpreter"
io.write("Oriented Language\n")
while true do
  io.write(">>> ")
  local line = io.read()
  local tokens = tokenize(line)
  for i, token in ipairs(tokens) do
    print(i, token)
  end
  -- public class MinhaClasse { int campo1; void metodo1() {} }
  print(parse_class(tokens))
end