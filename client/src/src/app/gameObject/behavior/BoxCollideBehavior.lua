--[[
box刚体的物理组件 
]]
local PhysicsWorldBehavior = require("app.gameObject.behavior.PhysicsWorldBehavior");
local BoxCollideBehavior = class("BoxCollideBehavior", BehaviorBase)

function BoxCollideBehavior:ctor()
    BoxCollideBehavior.super.ctor(self, "BoxCollideBehavior", nil, 0)
end



local maxSpeed = 5;-- The fastest the player can travel in the x axis.
local moveForce = 365;	--Amount of force added to move the player left and right.
	
	


function BoxCollideBehavior:bind(object)
	
	
	--创建box刚体
	local function createPhysicsBody(object,physicsBodyParam)
		
		local type = physicsBodyParam.type; --类型 1圆形 2方向  3多边形
		local mass = physicsBodyParam.mass or 0;
		local dynamic = physicsBodyParam.dynamic ;
		--local linearDamping = physicsBodyParam.linearDamping or 0;--设置线性阻尼。它是用来模拟流体或空气上摩擦身体的力量。*值为0.0到1.0。
		local friction = physicsBodyParam.friction or 1 ;--摩擦系数 0-1.0
		local elasticity = physicsBodyParam.elasticity or 0;-- 反弹系数 0-1.0
		local x = physicsBodyParam.x or 0;
		local y = physicsBodyParam.y or 0;
		local param = physicsBodyParam.param;--参数
		local physicsMaterial = cc.PhysicsMaterial(0, friction, elasticity)
--		local offsetVertex2F =  cc.p(0,0)--cc.vertex2F(0,0);
		
		local physicsBody ;
		if type == 1 then
			physicsBody = cc.PhysicsBody:createCircle(mass, param.radius, param.offsetX, param.offsetY)
		elseif type == 2 then
			--因为是笛卡尔坐标系的问题  必须宽高做一定的转换
			x = x + param.width/2;
			y = y + param.height/2;
			physicsBody = cc.PhysicsBody:createEdgeBox(cc.size( param.width, param.height),physicsMaterial)--摩擦力，宽，高 
		elseif type == 3 then
			--因为是笛卡尔坐标系的问题  必须宽高做一定的转换
			x = x + param.width/2;
			y = y + param.height/2;
			physicsBody = cc.PhysicsBody:createBox(cc.size( param.width, param.height),physicsMaterial)--摩擦力，宽，高 
		else
		end
		
		if physicsBody then
			physicsBody:setMass(mass)
			physicsBody:setDynamic(dynamic);
--			physicsBody:setLinearDamping(linearDamping);
			physicsBody:setRotationEnable(false);
			
--		    physicsBody:setPosition(x, y)
	--		body:setVelocity(velocityX, velocityY)-- 速度
	--		body:setAngleVelocity(velocity)-- 角速度
	--		Body:setCollisionType(type)--设置物体的碰撞类别，默认所有物体都是类别0
			-- 是否是感应
	--		body:setIsSensor(isSensor)
	--		body:isSensor()
	--		-- 推力
	--		body:applyForce(forceX, forceY, offsetX, offsetY)
	--		body:applyForce(force, offsetX, offsetY)
	--		body:applyImpulse(forceX, forceY, offsetX, offsetY)
	--		body:applyImpulse(force, offsetX, offsetY)
	
			return physicsBody,x,y;
		end
	end
	object:bindMethod(self, "createPhysicsBody", createPhysicsBody, true)
	
	
	local function getPhysicsBody(object)
		return self.physicsBody_
	end
	object:bindMethod(self, "getPhysicsBody", getPhysicsBody)
	
	
	
	
	
	
	
	
	
	
	
	local function createView(object,batch, floorsLayer,flysLayer, debugLayer)
		if object.physicsBodyParam_ then
			local physicsBody,x,y = object:createPhysicsBody(object.physicsBodyParam_)
			local view = object:getView();
			view:setPhysicsBody(physicsBody)
			self.physicsBody_ = physicsBody;
		end
	end
	object:bindMethod(self, "createView", createView)
	
	
	
	
	
	local function removeView(object)
		--[[
		 	unbind=true时将解除绑定的CCNode，但不会从场景里删除node,只是执行CC_SAFE_RELEASE_NULL(node);
		 	unbind=false时CCNode将继续绑定在该Body上，默认为true
		 	
		 	World:removeBody(body, unbind)
			World:removeBodyByTag(tag, unbind)
		]]
		if self.physicsBody_ then
			self.physicsBody_:removeSelf(true)
			self.physicsBody_:removeFromWorld()
			self.physicsBody_ = nil;
		end
	end
    object:bindMethod(self, "removeView", removeView, true)
	
	
	
	
-- 	local function tick(object,dt)	
--	    if object.getView and object:getView() then
--	         echoj("1:", self.physicsBody_:getPosition());
--	    	 echoj("1:", object:getView():getPosition());
--	 	end
-- 	end
-- 	object:bindMethod(self, "tick", tick)
	
	
end



function BoxCollideBehavior:unbind(object)
end


function BoxCollideBehavior:reset(object)
	
end



return BoxCollideBehavior
