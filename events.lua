local module = {}
local emitter = {}

emitter.listeners = {}

function emitter:on(eventName, func)
    if self.listeners[eventName] == nil then
        self.listeners[eventName] = {}
    end

    table.insert(self.listeners[eventName], func)
end

function emitter:off(eventName, func)
    if self.listeners[eventName] == nil then
        self.listeners[eventName] = {}
        return -- optimization
    end

    if #self.listeners[eventName] == 0 then return end

    for k, v in pairs(self.listeners[eventName]) do
        if v == func then
            return table.remove(self.listeners[eventName], k)
        end
    end
end

function emitter:emit(eventName, ...)
    if self.listeners[eventName] == nil then
        self.listeners[eventName] = {}
        return
    end

    if #self.listeners[eventName] == 0 then return end

    for _, v in pairs(self.listeners[eventName]) do
        v(...)
    end
end

function module:getEmitter()
    return setmetatable(emitter, {})
end

return module