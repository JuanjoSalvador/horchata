--- Creates beautiful menus for your Love2D games
---- @module horchata.menu
---- @author Juanjo Salvador
---- @copyright 2020
---- @license MIT

local Menu = {}

local entries = {}
local screenwidth, screenheight, percent_x, percent_y
local highlighted, old_highlighted  = nil

local col = love.graphics.getWidth() / 16
local row = love.graphics.getHeight() / 9

--- Creates a new Menu
-- @param gamestate The Menu GAMESTATE (example: "main_menu")
-- @param color The default color for the menu entries (optional)
-- @param sound A Source object for the menu sound
-- @param font Font for the menu labels (recommended size, 25)
function Menu:new(gamestate, color, sound, font)
    self.font = font

    self.color = color or {81/255, 185/255, 141/255} -- default color
    if sound ~= nil then
        self.sound = sound
    end

    screenwidth = love.graphics.getWidth()
    screenheight = love.graphics.getHeight()
    percent_x = screenwidth / 100
    percent_y = screenheight / 100

    self.sound:setLooping(false)
    self.gamestate = gamestate
end

--- Refresh screen size values (if screen resizing)
function Menu:refresh()
    screenwidth = love.graphics.getWidth()
    screenheight = love.graphics.getHeight()
    percent_x = screenwidth / 100
    percent_y = screenheight / 100
    col = screenwidth / 16
    row = screenheight / 9
    
    -- Updates the entry X position
    for _, entry in pairs(entries) do
        entry.m_x = (screenwidth / 2) - (self.font:getWidth(entry.label) / 2)
    end
end

--- Updates the Menu object
function Menu:update()
    for _, entry in pairs(entries) do
        local mouse_x = love.mouse.getX()
        local mouse_y = love.mouse.getY()

        if mouse_y >= entry.y * row and mouse_y <= (entry.y * row) + entry.h then
            if mouse_x >= entry.m_x and mouse_x <= entry.m_x + entry.w then
                entry.m_over = true
            else
                entry.m_over = false
            end
        else
            entry.m_over = false
        end
    end

    -- Mouse click event listener
    function love.mousereleased(x, y, m_button)
        if m_button == 1 then
            for _, entry in pairs(entries) do
                print(entry.w, entry.h)
                if entry.m_over and entry.enabled and GAMESTATE == Menu.gamestate then
                    entry:func()
                end
            end
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
    love.graphics.setFont(self.font)
    local r,g,b,a = love.graphics.getColor()

    for k, v in pairs(entries) do
        local center = (love.graphics.getWidth() / 2) - (v.w / 2)

        if v.m_over and v.enabled then
            love.graphics.setColor(self.color)
            love.graphics.print(v.label, center, row * v.y)
        else
            love.graphics.setColor(r,g,b,a)
            love.graphics.print(v.label, center, row * v.y)
        end
    end

    love.graphics.setColor(r,g,b,a)
end

--- Add a new Entry to the Menu
-- @param x The column (X coord) of the entry (0-16),  mandatory
-- @param y The row (Y coord) of the entry (0-9),  mandatory
-- @param enabled An Entry object can be enabled or not
-- @param label The Entry label, mandatory
-- @param func The Entry function (whatever the function does)
function Menu:addEntry(x, y, enabled, label, func)
    assert(x, "Column must be defined")
    assert(y, "Row must be defined")
    assert(label, "Label must be defined")
    entries[label] = {
        x = x,
        y = y,
        w = self.font:getWidth(label),
        h = self.font:getHeight(label),
        enabled = enabled or false,
        label = label,
        func = func,
        m_over = false,
        m_x = (love.graphics.getWidth() / 2) - (self.font:getWidth(label) / 2),
        m_y = y * row
    }
end

return Menu
