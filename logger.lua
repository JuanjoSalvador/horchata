-- Logger

logger = {}

function logger:info(text)
    print("[INFO] " .. text)
end

function logger:debug(text)
    print("[DEBUG] " .. text)
end

function logger:error(text)
    print("[ERROR] " .. text)
end

return logger