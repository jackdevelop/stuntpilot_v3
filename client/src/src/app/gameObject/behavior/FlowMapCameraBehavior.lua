local BaseScene = require("engin.mvcs.view.BaseScene")
local FlowMapCameraBehavior = class("FlowMapCameraBehavior", BehaviorBase)


function FlowMapCameraBehavior:ctor()
    FlowMapCameraBehavior.super.ctor(self, "FlowMapCameraBehavior", nil, 1)
end


local max = 10;

function FlowMapCameraBehavior:bind(object)



	
    local function flowMapCamera(object)
		if object:isDestroyed() then
		
		else
			local positionX,positionY = self.oldPositionX_,self.oldPositionY_
			self.oldPositionX_,self.oldPositionY_ = object:getView():getPosition();
			
			
			--相机移动策略
			if self.oldPositionX_ ~= positionX or self.oldPositionY_ ~= positionY then
				local newOffsetX = 0;
				local newOffsetY = 0;
				if self.oldPositionX_ > display.cx and self.oldPositionX_ < self.cameraSizeX_ - display.cx  then 
					
					local offsetX = self.oldPositionX_ - positionX;
					newOffsetX = -offsetX
				end
				
				
				if self.oldPositionY_ > 138 then--and self.oldPositionX_ < self.cameraSizeX_ - display.cx  then 
					local offsetY = self.oldPositionY_ - positionY;
					newOffsetY = -offsetY
				end
				
				
				self.camera_:moveOffset(newOffsetX,newOffsetY);
			end
		end
    end
    object:bindMethod(self, "flowMapCamera", flowMapCamera)

	
	
end

function FlowMapCameraBehavior:unbind(object)
end

function FlowMapCameraBehavior:reset(object)
	local  runningScene = BaseScene:getRunningScene()
	self.camera_ = runningScene:getCamera();
	
	self.cameraSizeX_,self.cameraSizeY_ = runningScene:getSize();
end

return FlowMapCameraBehavior
