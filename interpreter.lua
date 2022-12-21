describer = {}
function tokenize(input)
  local tokens = {}
  for token in string.gmatch(input, "[%a%d_%p]+") do
    table.insert(tokens, token)
  end
  
  return tokens
end

function describer(input)
  local description = {}
  for token in string.gmatch(input, "[%w]+") do
    table.insert(tokens, token)
  end
  
  return tokens
end

local class_struct = {
  ["modifiers"] = "?",  -- pode ser um ou mais modificadores de acesso (public, private, etc.)
  "class",  -- obrigatório
  ["name"] = "string",  -- nome da classe (obrigatório)
  ["extends"] = "?",  -- pode estender outra classe
  ["implements"] = "*",  -- pode implementar uma ou mais interfaces
  "{",  -- abre chaves
  "*",  -- pode conter uma ou mais declarações de campo ou método
  "}"  -- fecha chaves
}


-- Define a função match_structure
function match_structure(tokens, struct)
  -- Itera sobre os elementos da estrutura
  for i, element in ipairs(struct) do
    -- Verifica se o elemento é uma tabela (representando um token opcional ou repetível)
    if type(element) == "table" then
      -- Verifica se o elemento é opcional
      if element["?"] then
        -- Pula o elemento se não houver tokens suficientes
        if #tokens < i then
          return true
        end
        -- Verifica se o token corresponde ao elemento opcional
        if tokens[i] ~= element["?"] then
          return false
        end
      elseif element["*"] then
        -- Repete o elemento enquanto houver tokens suficientes
        while #tokens >= i and tokens[i] == element["*"] do
          i = i + 1
        end
      else
        -- Erro: elemento é uma tabela mas não é opcional nem repetível
        error("Elemento inválido na estrutura: " .. element)
      end
    else
      -- Verifica se o token corresponde ao elemento da estrutura
      if tokens[i] ~= element then
        return false
      end
    end
  end
  
  -- Verifica se ainda há tokens sobrando
  if #tokens > #struct then
    return false
  end
  
  -- A estrutura está correta
  return true
end

-- Define a função de análise sintática
function parse_class(tokens)
  -- Verifica se a estrutura da classe está correta
  print("", match_structure(tokens, class_struct))
end
