local Menu = {}

local entries = {}
local screenwidth, screenheight, percent_x, percent_y, color

-- local resolution = "1920 X 1080"
-- local resolution_available = {"1280 X 720", "1366 X 766", "1920 X 1080"}
-- local selected_res = 3

-- local fullscreen = true



function Menu:new(gmst, clr)
    if clr == nil then
        clr = {81, 185, 141} -- default color
    end

    screenwidth = love.graphics.getWidth()
    screenheight = love.graphics.getHeight()
    percent_x = screenwidth / 100
    percent_y = screenheight / 100

    color = Color:RGBtoLove(clr)
    Menu.gamestate = gmst
end

function Menu:update()
    for k, v in pairs(entries) do
        local over = false
        local mouse_x = love.mouse.getX()
        local mouse_y = love.mouse.getY()
    
        if mouse_y >= v.y * percent_y and mouse_y <= v.y * percent_y + v.h then
            if mouse_x >= v.x * percent_x and mouse_x <= v.x * percent_x + v.w then
                v.over = true
            else
                v.over = false
            end
        else
            v.over = false
        end
    end
end

function Menu:updateLabel(action, label)
    for k, v in pairs(entries) do
        print(v.action, v.label)
        if v.action == action then
            v.label = label
        end
    end
end

function Menu:draw()
    local oldFont = love.graphics.getFont()
    local r,g,b,a = love.graphics.getColor()

    --love.graphics.print("OPTIONS", button.x * percent_x, 10 * percent_y)

    --love.graphics.print("SCREEN RESOLUTION", button.x * percent_x, 25 * percent_y)
    for k, v in pairs(entries) do

        if v.over and v.clickable then
            love.graphics.setColor(color)
            love.graphics.print(v.label, v.x * percent_x, v.y * percent_y)
        else
            love.graphics.setColor(r,g,b,a)
            love.graphics.print(v.label, v.x * percent_x, v.y * percent_y)
        end
    end

    love.graphics.setFont(oldFont)
    love.graphics.setColor(r,g,b,a)
end

function Menu:addEntry(x, y, w, h, clickable, onClick, text)
    local entry = {
        x = x,
        y = y,
        w = w,
        h = h,
        mouse_over = false,
        clickable = clickable,
        action = onClick or nil,
        label = text
    }

    table.insert(entries, entry)
end

function love.mousereleased(x, y, m_button)
    print(gamestate)
    if m_button == 1 then
        for k, v in pairs(entries) do
            if v.over and v.clickable and gamestate == Menu.gamestate then
                MenuController(v.action)
            end
        end
    end
end


return Menu