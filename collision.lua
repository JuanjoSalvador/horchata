local Collision = {}

function Collision:detect(ob1, ob2)
    local col = false

    if ob1.y <= ob2.y and ob1.y >= ob2.y - ob2.h then
        if ob1.x >= ob2.x and ob1.x <= ob2.x + ob2.w then
            col = true
        end
    end
    
    return col
end

return Collision