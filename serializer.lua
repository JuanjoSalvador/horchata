-- Serializer

Serializer = {}

function Serializer:serialize(table)
    local str = ""

    for k, v in ipairs(table) do
        str = str .. k .. ": " .. v .. ", \r\n"
    end
    
    return "{ " .. str .. " }" 
end

return Serializer
