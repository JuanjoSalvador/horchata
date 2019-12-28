local Color = {}

-- Como parámetro acepta números entre 0 y 255
-- y devuelve el valor relativo entre 0 y 1
-- (Love2D 11.0)

function toDecimal (number)
    return number/255
end

-- @param rgb: tabla con tres valores RGB
function Color:RGBtoLove(rgb)
    colorTable = nil

    if rgb ~= nil then
        colorTable = {}

        for i in pairs(rgb) do
            table.insert(colorTable, toDecimal(rgb[i]))
        end
    end
    
    return colorTable
end

function Color:randomColor()
    local colorSet = {}

    for i = 1, 3, 1 do 
        table.insert(colorSet, math.random(0, 255))
    end

    return self:RGBtoLove(colorSet)
end

return Color