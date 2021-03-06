--[[
显示对象
]]
local ObjectViewBehavior = class("ObjectViewBehavior", BehaviorBase)

function ObjectViewBehavior:ctor()
    ObjectViewBehavior.super.ctor(self, "ObjectViewBehavior", nil, 0)
end

function ObjectViewBehavior:bind(object)
    object.isSelected_ = false

    local function isSelected(object)
        return object.isSelected_
    end
    object:bindMethod(self, "isSelected", isSelected)

    local function setSelected(object, isSelected)
        object.isSelected_ = isSelected
    end
    object:bindMethod(self, "setSelected", setSelected)

	
	--x,y点是否在当前的对象的范围内
    local function checkPointIn(object, x, y)
        return math2d.dist(x,
                           y,
                           object.x_ + object.radiusOffsetX_,
                           object.y_ + object.radiusOffsetY_) <= object.radius_
    end
    object:bindMethod(self, "checkPointIn", checkPointIn)

	
	
	
	
	--[[
	获取当前显示的视图动画
	]]
	local function getAnimation(object, x, y)
        return self.animation_
    end
    object:bindMethod(self, "getAnimation", getAnimation)
	 
	--[[
	更改动作
	]]
	local function changeAction(object, actionName)
        if self.animation_ then
        	self.animation_:changeAction(actionName);
        end
    end
    object:bindMethod(self, "changeAction", changeAction)
	
	
	
	
	
	
	
	
	
	
	
	
	
    --[[
    	停止所有动作
    ]]
     local function pausePlay(object)
     	 local animation = self.animation_
     	 animation:stopAnimation();
     end
    object:bindMethod(self, "pausePlay", pausePlay)
    
      --[[
   	 重新播放所有动作
    ]]
     local function resumePlay(object)
     	 local animation = self.animation_
     	animation:resumePlay();
     end
    object:bindMethod(self, "resumePlay", resumePlay)
	--[[
   	强制播放
    ]]
     local function enforcePlay(object)
     	 local animation = self.animation_
     	animation:enforcePlay();
     end
    object:bindMethod(self, "enforcePlay", enforcePlay)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	--创建动画
    local function createView(object, batch, marksLayer, debugLayer)
--        local animation = AnimationCache.new()
--     	local animationParam  = AnimationProperties.get(object.animation_);
--     	animation:initData(object.animation_,animationParam)
--        animation:createView(batch)
--        animation:updateView(true);
        
        local animation = AnimationFactory.create(batch,object);
        
        local view = animation:getView()
        object.sprite_ = view;
        self.animation_ = animation;
	
	    local size = object.sprite_:getContentSize()
	    object.spriteSize_ = {size.width, size.height}
		
	    if object.scale_ then
	        object.sprite_:setScale(self.scale_)
	    end
    end
    object:bindMethod(self, "createView", createView)

	
	
	
	
	
	
    local function removeView(object)
    	if self.animation_ then 
    		self.animation_:removeView();
    		self.animation_ = nil;
    	end
    	 
    	if object.sprite_ then
			object.sprite_:removeSelf()
			object.sprite_ = nil
		end
    end
    object:bindMethod(self, "removeView", removeView, true)



	
    local function updateView(object)		
        local x, y = math.floor(object.x_), math.floor(object.y_)
        object.sprite_:setPosition(x,y)
    end
    object:bindMethod(self, "updateView", updateView)
end

function ObjectViewBehavior:unbind(object)
    object.isSelected_ = nil

    object:unbindMethod(self, "isSelected")
    object:unbindMethod(self, "setSelected")
    object:unbindMethod(self, "checkPointIn")
    object:unbindMethod(self, "createView")
    object:unbindMethod(self, "removeView")
    object:unbindMethod(self, "updateView")
    object:unbindMethod(self, "fastUpdateView")
end

return ObjectViewBehavior
