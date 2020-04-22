local Collision = {}

-- ob1: objeto que impacta
-- ob2: objeto impactado
-- hbx: ajuste hitbox X
-- hby: ajuste hitbox y
-- devuelve las coordenadas donde ha sido impactado

function Collision:detect(ob1, ob2, hbx, hby)
    local col = {}

    hbx = hbx or 0
    hby = hby or 0

    if ob1 ~= nil then
        if ob1.y <= ob2.y + (ob2.h - hby) and ob1.y + ob1.h >= ob2.y + hby then
            if ob1.x + ob1.w >= ob2.x + hbx and ob1.x <= ob2.x + (ob2.w - hbx) then
                col.enter = true
            end
        end
    end

    col.x = ob2.x
    col.y = ob2.y

    return col
end

return Collision
