--- Creates beautiful menus for your Love2D games
---- @module horchata.menu
---- @author Juanjo Salvador
---- @copyright 2020
---- @license MIT

local Menu = {}

local entries = {}
local screenwidth, screenheight, percent_x, percent_y

Menu.color = {81, 185, 141}

--- Creates a new Menu
-- @param gamestate The Menu GAMESTATE (example: "main_menu")
-- @param color The default color for the menu entries (optional)
function Menu:new(gamestate, color)
    if color then
        Menu.color = color -- default color
    end

    screenwidth = love.graphics.getWidth()
    screenheight = love.graphics.getHeight()
    percent_x = screenwidth / 100
    percent_y = screenheight / 100

    self.GAMESTATE = gamestate
end

--- Refresh screen size values (if screen resizing)
function Menu:refresh()
    screenwidth = love.graphics.getWidth()
    screenheight = love.graphics.getHeight()
    percent_x = screenwidth / 100
    percent_y = screenheight / 100
end

--- Updates the Menu object
function Menu:update()
    for _, entry in pairs(entries) do
        local mouse_x = love.mouse.getX()
        local mouse_y = love.mouse.getY()

        if mouse_y >= entry.y * percent_y and mouse_y <= entry.y * percent_y + entry.h then
            if mouse_x >= entry.x * percent_x and mouse_x <= entry.x * percent_x + entry.w then
                entry.m_over = true
            else
                entry.m_over = false
            end
        else
            entry.m_over = false
        end
    end
end

--- Refresh screen size values (if screen resizing)
function Menu:refresh()
    screenwidth = love.graphics.getWidth()
    screenheight = love.graphics.getHeight()
    percent_x = screenwidth / 100
    percent_y = screenheight / 100
end

--- Updates the Menu object's label
function Menu:updateLabel(x, y, w, h, enabled, label)
    entries[label] = {
        x = self.x,
        y = self.y,
        w = self.w,
        h = self.h,
        enabled = self.enabled,
        label = self.label
    }
end

--- Draw the Menu
function Menu:draw()
    local oldFont = love.graphics.getFont()
    local r,g,b,a = love.graphics.getColor()
    for _, entry in pairs(entries) do

        if entry.m_over and entry.enabled then
            love.graphics.setColor(Menu.color)
            love.graphics.print(entry.label, entry.x * percent_x, entry.y * percent_y)
        else
            love.graphics.setColor(r,g,b,a)
            love.graphics.print(entry.label, entry.x * percent_x, entry.y * percent_y)
        end
    end

    love.graphics.setFont(oldFont)
    love.graphics.setColor(r,g,b,a)
end

--- Add a new Entry to the Menu
-- @param x The X position of the entry
-- @param y The Y position of the entry
-- @param w The width of the entry
-- @param h The height of the entry
-- @param enabled An Entry object can be enabled or not
-- @param label The Entry label
-- @param func The Entry function (whatever the function does)
function Menu:addEntry(x, y, w, h, enabled, label, func)
    entries[label] = {
        x = x,
        y = y,
        w = w,
        h = h,
        enabled = enabled,
        label = label,
        func = func,
        m_over = false
    }
end

-- Mouse click event listener
function love.mousereleased(x, y, m_button)
    if m_button == 1 then
        for _, entry in pairs(entries) do
            if entry.m_over and entry.enabled and GAMESTATE == Menu.GAMESTATE then
                entry:func()
            end
        end
    end
end

return Menu
