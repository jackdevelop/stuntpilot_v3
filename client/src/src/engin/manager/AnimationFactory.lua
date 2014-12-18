local CCSArmature = require("engin.ccs.view.CCSArmature");
		
local AnimationFactory = {}




AnimationFactory.ccs_type = 2;
AnimationFactory.sprite_type = 1;










function AnimationFactory.create(batch,param)
	local animationProperties  = AnimationProperties.get(param.animation_);
	if animationProperties.animationType ==  AnimationFactory.ccs_type then
		local ccsArmature = CCSArmature.new();
		--[[
		local param = {
			png ="ccs/dragon/baoshihecheng/baoshigonghui0.png", --png地址
			plist = "ccs/dragon/baoshihecheng/baoshigonghui0.plist", --plist地址
			json = "ccs/dragon/baoshihecheng/baoshigonghui.ExportJson" --json地址
			name = "baoshigonghui",--动画名称
		}
		]]
		ccsArmature:initData(batch,animationProperties.animationParam);
		--ccsArmature:initView();
		return ccsArmature;
	else
	 	local animation = AnimationCache.new()
     	animation:initData(param.animation_,animationProperties)
        animation:createView(batch)
        animation:updateView(true);
        
        return animation;
	end
end























return AnimationFactory;