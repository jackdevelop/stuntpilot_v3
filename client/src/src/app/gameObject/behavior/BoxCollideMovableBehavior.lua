--[[
box刚体的物理移动组件 
]]
local PhysicsWorldBehavior = require("app.gameObject.behavior.PhysicsWorldBehavior");
local BoxCollideMovableBehavior = class("BoxCollideMovableBehavior", BehaviorBase)

function BoxCollideMovableBehavior:ctor()
    BoxCollideMovableBehavior.super.ctor(self, "BoxCollideMovableBehavior", nil, 0)
end



local maxSpeed = 100;-- The fastest the player can travel in the x axis.
local moveForce = 15000;	--Amount of force added to move the player left and right.
	


local function checkVelocitySpeed(physicsBody)
	local velocity = physicsBody:getVelocity();
	if math.abs(velocity.x) > maxSpeed then
		velocity.x = math.sin(velocity.x/maxSpeed)*maxSpeed;
	end
	
	if math.abs(velocity.y) > maxSpeed then
		velocity.y = math.sin(velocity.y/maxSpeed)*maxSpeed;
	end
	
	physicsBody:setVelocity(velocity);		
	return velocity;
end
	


function BoxCollideMovableBehavior:bind(object)
	
	
	
--	--[[
--	设置力
--	]]
--	local function setForceSpeed(object,axisX,axisY)
--		local  physicsBody = object:getPhysicsBody();
--		if physicsBody then
--			local forceSpeed = cc.vertex2F(0,moveForce)
--			physicsBody:applyForce(forceSpeed);
--			--checkVelocitySpeed(physicsBody);
--		end
--	end
--	object:bindMethod(self, "setForceSpeed", setForceSpeed)
	
	
	
	
	
	--[[
	速度移动
	]]
	local function setVelocitySpeed(object,axisX,axisY)
		local  physicsBody = object:getPhysicsBody();
		if physicsBody then
			physicsBody:setVelocity(cc.vertex2F(axisX*maxSpeed,axisY*maxSpeed));
		end
	end
	object:bindMethod(self, "setVelocitySpeed", setVelocitySpeed)
	
	
	
	
	
	
	--[[
		停止所有力
		@param 1 表示消除x方向的力
		@param 2表示消除y方向的力
		@param 0或者nil表示消除所有
	]]
   	local function resetForces(object)
   		local  physicsBody = object:getPhysicsBody();
		if physicsBody then
			physicsBody:resetForces();
	   	end
	end
	object:bindMethod(self, "resetForces", resetForces)
    			   
	
	
	--[[
	停止力和速度
	]]
	local function stopPhysics(object)
   		local  physicsBody = object:getPhysicsBody();
		if physicsBody then
			physicsBody:resetForces();
		   	physicsBody:setVelocity(cc.vertex2F(0,0));	
	   	end
	   	
	end
	object:bindMethod(self, "stopPhysics", stopPhysics)
	
	
	
	
	
	local function tick(object)
   		local  physicsBody = object:getPhysicsBody();
		if physicsBody then
--			local velocity= physicsBody:getVelocity();
--			local x,y = physicsBody:getPosition()
--			if object.updated__ then
				object:flowMapCamera();
--			end 
	   	end
	end
	object:bindMethod(self, "tick", tick)
	
end






function BoxCollideMovableBehavior:unbind(object)
end


function BoxCollideMovableBehavior:reset(object)
end



return BoxCollideMovableBehavior
