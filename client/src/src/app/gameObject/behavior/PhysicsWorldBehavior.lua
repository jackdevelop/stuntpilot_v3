--[[
总物理世界 
一个场景中一般只有一个 
http://cn.cocos2d-x.org/tutorial/show?id=1356
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local TiledMapUtil = require("engin.util.TiledMapUtil")
local PhysicsWorldBehavior = class("PhysicsWorldBehavior", BehaviorBase)





function PhysicsWorldBehavior:ctor()
    PhysicsWorldBehavior.super.ctor(self, "PhysicsWorldBehavior", nil, 0)
end


local GRAVITY         = -400
local physicsWorld;

function PhysicsWorldBehavior.getPhysicsWorld()
	return physicsWorld
end



function PhysicsWorldBehavior:bind(object)


	local function createView(object,batch, floorsLayer,flysLayer, debugLayer)
		local  runningScene = BaseScene:getRunningScene()
		
		--创建物理世界 
		-- create physics world
	    local physicsWorld = runningScene:getScenePhysicsWorld()
	    physicsWorld:setGravity(cc.p(0, GRAVITY))
	    physicsWorld:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL);--true and cc.PhysicsWorld.DEBUGDRAW_ALL or cc.PhysicsWorld.DEBUGDRAW_NONE)
    	--[[
    		cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN = 53
			cc.Handler.EVENT_PHYSICS_CONTACT_PRESOLVE = 54
			cc.Handler.EVENT_PHYSICS_CONTACT_POSTSOLVE = 55
			cc.Handler.EVENT_PHYSICS_CONTACT_SEPERATE = 56
    	]]
--    	local function onCollisionListener(eventType, event)
--		    print("是什么:",eventType)
--		    return true
--		end
--		physicsWorld:addNodeEventListener(cc.Handler.EVENT_PHYSICS_CONTACT_POSTSOLVE, onCollisionListener)
--    	physicsWorld:collisionPostSolveCallback(onCollisionListener);
		
		
		
		
		--创建一个包含世界的
		local width,height = runningScene:getSize();
		local  physicsBodyParam = {
	    	type =2,
	    	mass = 0,--质量
	    	linearDamping = 1,
	    	elasticity = 0,
	    	friction =0,
	    	param = {
	    		width = width,
		    	height = height,
	    	},
	    };
		local wallBox = display.newNode()
		wallBox:setAnchorPoint(cc.p(0.5, 0.5))
		local bady,x,y = object:createPhysicsBody(physicsBodyParam);
	 	wallBox:setPhysicsBody(bady);
	 	wallBox:setPosition(x,y);
	 	batch:addChild(wallBox);
			 	
		--解析地图的碰撞层
		local tiledMap = runningScene.tiledMap_;
		if tiledMap then
			local function callBack(physicsBodyParam)
				physicsBodyParam.elasticity = 1;
				physicsBodyParam.friction = 1;
				local wallBox = display.newNode()
    			wallBox:setAnchorPoint(cc.p(0.5, 0.5))
				local bady,x,y = object:createPhysicsBody(physicsBodyParam);
			 	wallBox:setPhysicsBody(bady);
			 	wallBox:setPosition(x,y);
			 	batch:addChild(wallBox);
			end
			TiledMapUtil.getPhysicsWorldProperties(tiledMap,"pengzhuang",callBack)
		end
	end
	object:bindMethod(self, "createView", createView)
	
	
	
	
    
	
	
	local function removeView(object)
	end
    object:bindMethod(self, "removeView", removeView, true)
end



function PhysicsWorldBehavior:unbind(object)
end



return PhysicsWorldBehavior
