--[[
 摇杆
]]
local EasyTouch = class("EasyTouch", function()
	return display.newNode();
end)


	
local pointAtCircle = Math2d.pointAtCircle


--[[
创建
@param On_JoystickMove 按下摇杆的回调函数
@param On_JoystickMoveEnd 移开摇杆的回调函数
]]
function EasyTouch:ctor(On_JoystickMove,On_JoystickMoveEnd)

	local easyTouchBg = display.newSprite("easyTouchBg.png");
	self:addChild(easyTouchBg);
	local size=easyTouchBg:getContentSize();
	self.width_ = size.width;
	self.height_ = size.height;
	self.radius_ = self.width_ /2;--移动的半轴
	
	
	
	local easyTouchCircle = display.newSprite("easyTouchCircle.png");
	self:addChild(easyTouchCircle);
	self.easyTouchCircle_ = easyTouchCircle;
	easyTouchCircle:setTouchEnabled(true)
    easyTouchCircle:setTouchSwallowEnabled(true)
    easyTouchCircle:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        local name, x, y, prevX, prevY = event.name, event.x, event.y, event.prevX, event.prevY
        if name == "began" then
        	self.drag = {
				startX  = x,
				startY  = y,
				lastX   = x,
				lastY   = y,
				offsetX = 0,
				offsetY = 0,
			}
             return true
        end

        if name == "moved" then
        	local offsetX =  x - self.drag.startX;
        	local offsetY = y - self.drag.startY
			
        	if Math2d.dist(0, 0, offsetX, offsetY) > self.radius_ then
        		local tempRad = Math2d.radians4point(0, 0, offsetX, offsetY)--得到摇杆与触屏点所形成的角度  
                offsetX,offsetY = Math2d.pointAtCircle(0, 0, tempRad, self.radius_) --保证内部小圆运动的长度限制  
        	end
        	self.drag.offsetX = offsetX
            self.drag.offsetY = offsetY
            self.drag.lastX = x
            self.drag.lastY = y
            easyTouchCircle:setPosition(offsetX,offsetY);
            
            --按下摇杆的回调
            if On_JoystickMove then
            	On_JoystickMove(offsetX/self.radius_,offsetY/self.radius_,self.radius_);
            end
            
            return true
        elseif name == "ended" then
        	easyTouchCircle:setPosition(0,0);
        else
        	easyTouchCircle:setPosition(0,0);
        	self.drag = nil
        end
        
        
        
        --移开摇杆的回调
        if On_JoystickMoveEnd then
        	On_JoystickMoveEnd();
        end
            
        return true
    end)
end






		
		
--获取轴距 [-半径，+半径]
function EasyTouch:getJoystickAxis()
	if self.drag then
		return self.drag.offsetX ,self.drag.offsetY
	end
	return 0,0
end
 
--获取大小
function EasyTouch:getSize()
	return self.width_,self.height_
end
--获取圆的半径
function EasyTouch:getRadius()
	return self.radius_
end






return EasyTouch