local Collision = {}

-- ob1: objeto que impacta
-- ob2: objeto impactado
-- devuelve las coordenadas donde ha sido impactado

function Collision:detect(ob1, ob2)
    local col = {}

    if ob1 ~= nil then
        if ob1.y <= ob2.y + ob2.h and ob1.y + ob1.h >= ob2.y then
            if ob1.x + ob1.w >= ob2.x and ob1.x + ob1.w <= ob2.x + ob2.w then
                col.enter = true
            end
        end
    end

    col.x = ob2.x
    col.y = ob2.y
    
    return col
end

return Collision