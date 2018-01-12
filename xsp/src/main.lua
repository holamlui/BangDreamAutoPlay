require "function";
require "event";
require "bandBattle";
require "multiLive";
appid = frontAppName();
if appid ~= "jp.co.craftegg.band" then
r = runApp("jp.co.craftegg.band");
end
init("jp.co.craftegg.band",1);--
currentPage = "";
songSelect = "default";
gamePlayed= 0;
bandBattle();
--main();
--event(); --for event