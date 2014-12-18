local LuaCoroutine = {} 

local function runAsyncFunc( func, ... )
    local current = coroutine.running
    func(function (  )
        coroutine.resume(current)
    end, ...)
    coroutine.yield()
end

local co = coroutine.create(function (  )
    runAsyncFunc(bob.walkto, jane)
    runAsyncFunc(bob.say, "hello")
    jane.say("hello")
end)

coroutine.resume(co)




return LuaCoroutine;