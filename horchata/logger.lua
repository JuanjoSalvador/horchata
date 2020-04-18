-- Logger

Logger = {}

function Logger:info(text)
    print("[INFO] " .. text)
end

function Logger:debug(text)
    print("[DEBUG] " .. text)
end

function Logger:error(text)
    print("[ERROR] " .. text)
end

return Logger
