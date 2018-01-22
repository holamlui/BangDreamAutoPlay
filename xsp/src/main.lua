require "function";
require "event";
require "bandBattle";
require "multiLive";
require "privateRoom"
appid = frontAppName();
if appid ~= "jp.co.craftegg.band" then
r = runApp("jp.co.craftegg.band");
end
init("jp.co.craftegg.band",1);--
currentPage = "";
songSelect = "random";
gamePlayed= 0;
multiLive();
--bandBattle();
--privateRoom()
--event(); --for event