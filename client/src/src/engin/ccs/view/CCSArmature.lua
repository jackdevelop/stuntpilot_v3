--[[
	动画文件统一放在res\ccs\dragon 下自定义文件夹

	使用方法
	local CCSArmature = require("client.view.css.ui.base.CCSArmature");
	local ccsArmature = CCSArmature.new();
	local param = {
		png ="ccs/dragon/baoshihecheng/baoshigonghui0.png", --png地址
		plist = "ccs/dragon/baoshihecheng/baoshigonghui0.plist", --plist地址
		json = "ccs/dragon/baoshihecheng/baoshigonghui.ExportJson" --json地址
		name = "baoshigonghui",--动画名称
		biaoqianName = "",--标签名字
	}
	ccsArmature:initData(param);
	self:addChild(ccsArmature);
]]
local CCSArmature = class("CCSArmature");



--[[

@param  ccsName  ccs的面板名称
@param  plistArr  plist的响应资源 数组
]]
function CCSArmature:initData(batch,param)
	self.batch_ = batch;
	if not param then param = {} end
	self.param_ = param;
	
	--资源加载
	local function dataLoaded(percent)
--        self:completeHandle();
    end
	local manager = ccs.ArmatureDataManager:getInstance()
    --manager:removeArmatureFileInfo("armature/bear.ExportJson")
    --manager:addArmatureFileInfo(param.json)
    manager:addArmatureFileInfoAsync(param.png, param.plist,param.json, dataLoaded)
    self:completeHandle();
end






--初始化视图
function CCSArmature:completeHandle()
	local param = self.param_;
	
	local armature = ccs.Armature:create(param.name) --动画的名称
    --armature:setPosition(display.cx,display.cy)
    --armature:getAnimation():setSpeedScale(0.4)
   	self:changeAction(param.actionName);
    --armature:setAnchorPoint(cc.p(1,1))
    --self.armature:getBone("armInside"):getChildArmature():getAnimation():playWithIndex(self.weaponIndex)
    --self.armature:getBone("armOutside"):getChildArmature():getAnimation():playWithIndex(self.weaponIndex)
    self.batch_:addChild(armature)
    self.armature_ = armature;
end




--移除
function CCSArmature:removeView()
    if self.armature_ then
    	self.armature_:removeSelf();
    	self.armature_ = nil;
    end
end









function CCSArmature:stopAnimation()
	self:pause();
end
--直接停止在第几帧
function CCSArmature:pause(frameIndex)
	if self.armature_ then
		self.armature_:getAnimation():pause(frameIndex);
	end
end
--从第几帧开始播放
function CCSArmature:gotoAndPlay(frameIndex)
	if self.armature_ then
		self.armature_:getAnimation():gotoAndPlay(frameIndex);
	end
end
--从第一帧播放后，停止在第几帧
function CCSArmature:gotoAndPause(frameIndex)
	if self.armature_ then
		self.armature_:getAnimation():gotoAndPause(frameIndex);
	end
end
function CCSArmature:changeAction(actionName)
	if self.armature_ then
		 self.armature_:getAnimation():play(actionName)--"chuanqidz")
	end
end










function CCSArmature:setPosition(x,y)
	if self.armature_ then
		self.armature_:setPosition(x,y);
	end
end


--[[
获取动画
]]
function CCSArmature:getCCArmature()
	return  self.armature_;
end


function CCSArmature:getView()
	return  self.armature_;
end

return CCSArmature
