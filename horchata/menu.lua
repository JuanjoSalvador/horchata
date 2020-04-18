--- Creates beautiful menus for your Love2D games
-- @module horchata.menu
-- @author Juanjo Salvador
-- @copyright 2020
-- @license MIT

local Menu = {}

local Color = require "lib.horchata.color"

local entries = {}
local screenwidth, screenheight, percent_x, percent_y, color

--- Creates a new Menu.
-- @param gmst The Menu gamestate (example: "main_menu").
-- @param clr The default color for the menu entries (optional).
function Menu:new(gmst, clr)
    if clr == nil then
        clr = {81, 185, 141} -- default color
    end

    screenwidth = love.graphics.getWidth()
    screenheight = love.graphics.getHeight()
    percent_x = screenwidth / 100
    percent_y = screenheight / 100

    color = Color:RGBtoLove(clr)
    self.gamestate = gmst
end

--- Updates the Menu object. Add this on your main love:update().
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

--- Updates the Menu object's label.
-- @param action Action to be updated
-- @param label New label to set
function Menu:updateLabel(action, label)
    for k, v in pairs(entries) do
        if v.action == action then
            v.label = label
        end
    end
end

--- Draw the Menu. Add this on your main love.draw().
function Menu:draw()
    local oldFont = love.graphics.getFont()
    local r,g,b,a = love.graphics.getColor()
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

--- Add a new Entry to the Menu.
-- @param x The X position of the entry.
-- @param y The Y position of the entry.
-- @param w The width of the entry.
-- @param h The height of the entry.
-- @param clickable An Entry object could be clickable or not.
-- @param onClick Action to launch when you click this (default nil).
-- @param text The Entry label.
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
    if m_button == 1 then
        for k, v in pairs(entries) do
            if v.over and v.clickable and gamestate == Menu.gamestate then
                MenuController(v.action)
            end
        end
    end
end

return Menu
