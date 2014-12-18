--[[
战斗场景
]]
local Timer  = require("engin.util.Timer");
local EasyTouch = require("engin.util.easyTouch.EasyTouch")
local FightSceneUI = class("FightSceneUI", Base)

local jump = true;
	
function FightSceneUI:initView()
	local batch = self:getBatch();
    
    local On_JoystickMove = function(axisX,axisY,radius)
    	self:On_JoystickMoveHandle(axisX,axisY,radius);
    end
    local On_JoystickMoveEnd = function(offsetX,offsetY,radius)
    	if not self.focusObject_  then return end
    	self.focusObject_:stopPhysics();
    	self.focusObject_:changeAction("chuanqidz");
    	jump = true;
    end
    local easyTouch = EasyTouch.new(On_JoystickMove,On_JoystickMoveEnd);
    batch:addChild(easyTouch);
	easyTouch:setPosition(display.left + 120,display.bottom + 100);
end




--按下摇杆的回调
function FightSceneUI:On_JoystickMoveHandle(axisX,axisY,radius)
	if not self.focusObject_  then return end
	
	
	local batch = self:getBatch();
	if axisY > -0.5 and axisY < 0.5 then --左右在移动
		self.focusObject_:resetForces();
		self.focusObject_:setVelocitySpeed(axisX,axisY);
		self.focusObject_:changeAction("paobudz");
		if axisX < 0 then
			self.focusObject_:getView():setScaleX(-1); 
		else 
			self.focusObject_:getView():setScaleX(1); end
			
		return
	elseif axisY < - 0.5 then--蹲下
		self.focusObject_:stopPhysics();
	elseif axisY > 0.5 then --跳起
		if jump == true then
			jump = false;
			self.focusObject_:changeAction("shangtiao");
			transition.moveTo(self.focusObject_:getView(), {y = display.cy, time = 0.2})
--			self.focusObject_:setForceSpeed(0,1);
			batch:performWithDelay(function()
				self.focusObject_:resetForces();
			end, 2)
		end
	end
end










function FightSceneUI:setFocusObject(object)
	self.focusObject_ = object;
end


return FightSceneUI
