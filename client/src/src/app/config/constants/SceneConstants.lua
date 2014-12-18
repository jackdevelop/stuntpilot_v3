

local Jscene = Jscene;


--场景的名称
SceneConstants.LoginScene = Jscene("LoginScene",nil);--登陆场景
SceneConstants.FightLoadingScene = Jscene("FightLoadingScene",nil); -- 战斗loading场景 
SceneConstants.FightScene =  Jscene("FightScene","LoginScene",true);--战斗场景,第三个参数为true表示是物理场景


