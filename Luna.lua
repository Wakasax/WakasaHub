local HttpService = game:GetService("HttpService")

local apiKey = "83e813ede7d1997b8c6e6ff5c5d02ac6acd88f445bb718e30b95dac1f9241480"
local apiUrl = "https://api.pandadevelopment.net/api/key/fetch"  -- Endpoint para buscar a chave

-- Função para verificar a chave
local function verificarChave(chave)
    local resposta
    local sucesso, erro = pcall(function()
        resposta = HttpService:GetAsync(apiUrl .. "?apiKey=" .. chave .. "&fetch=" .. chave)
    end)
    
    if sucesso then
        local data = HttpService:JSONDecode(resposta)
        if data.key and data.key.value == chave then
            return true  -- Chave válida
        else
            return false  -- Chave inválida ou não encontrada
        end
    else
        warn("Erro ao verificar chave: " .. erro)
        return false  -- Erro na requisição
    end
end

-- Chamada para verificar a chave
if verificarChave(apiKey) then
    print("Chave válida!")
else
    print("Chave inválida ou erro na verificação!")
end
