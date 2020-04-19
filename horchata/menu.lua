--- Creates beautiful menus for your Love2D games
---- @module horchata.menu
---- @author Juanjo Salvador
---- @copyright 2020
---- @license MIT

local Menu = {}

local Color = require "lib.horchata.color"

local entries = {}
local screenwidth, screenheight, percent_x, percent_y, color, sound

--- Creates a new Menu
-- @param gamestate The Menu GAMESTATE (example: "main_menu")
-- @param color The default color for the menu entries (optional)
-- @param sound A Source object for the menu sound
function Menu:new(gamestate, color, sound)
    color = color or {81, 185, 141} -- default color

    screenwidth = love.graphics.getWidth()
    screenheight = love.graphics.getHeight()
    percent_x = screenwidth / 100
    percent_y = screenheight / 100

    self.color = Color:RGBtoLove(color)
    self.GAMESTATE = gamestate
end

--- Updates the Menu object
function Menu:update()
    for k, v in pairs(entries) do
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

--- Updates the Menu object's label (internal use)
function Menu:updateLabel(action, label)
    for k, v in pairs(entries) do
        print(v.action, v.label)
        if v.action == action then
            v.label = label
        end
    end
end

--- Draw the Menu
function Menu:draw()
    local oldFont = love.graphics.getFont()
    local r,g,b,a = love.graphics.getColor()
    for k, v in pairs(entries) do

        if v.over and v.clickable then
            love.graphics.setColor(self.color)
            love.graphics.print(v.label, v.x * percent_x, v.y * percent_y)
        else
            love.graphics.setColor(r,g,b,a)
            love.graphics.print(v.label, v.x * percent_x, v.y * percent_y)
        end
    end

    love.graphics.setFont(oldFont)
    love.graphics.setColor(r,g,b,a)
end

--- Add a new Entry to the Menu
-- @param x number The X position of the entry
-- @param y number The Y position of the entry
-- @param w number The width of the entry
-- @param h number The height of the entry
-- @param clickable bool An Entry object could be clickable or not
-- @param onClick string Action to launch when you click this (default nil)
-- @param text string The Entry label
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

-- Mouse click event listener
function love.mousereleased(x, y, m_button)
    if m_button == 1 then
        for k, v in pairs(entries) do
            if v.over and v.clickable and GAMESTATE == Menu.GAMESTATE then
                MenuController(v.action)
            end
        end
    end
end


return Menu
