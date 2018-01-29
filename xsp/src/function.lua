function toggleSong(songSelect)
	if songSelect == "random" then
	songSelect = "default";
	elseif songSelect == "default" then
	songSelect = "random"
	end
	return songSelect;
end
function checkConnectionFail()
	blueX,blueY = checkCancelButton();
	redX,redY = checkRetryButton();
	if(blueX>-1 and redX>-1) then
		sysLog("detected connection error");
		tap(redX,redY); --retry first
		mSleep(500);
		tap(blueX,blueY); -- cancel if fail
		sysLog("tapped cancel button");
		okX,okY = checkOkButton();
		mSleep(1000); --wait 1 second
		if okX>-1 then
			tap(okX,okY);
			sysLog("tapped ok button");
			currentPage="";
		end
		return true;
	else
		return false;
	end
	sysLog('BlueX: '..blueX..' BlueY: '..blueY);
end

function checkCancelButton() -- Blue cancelButton
	x, y = findColor({0, 0, 1280, 720}, 
	"0|0|0xb4e5ff,-91|-23|0xe1f5ff,-87|-9|0xb7e7ff,-87|11|0x43bfff,100|-15|0xb4e5ff,102|10|0x43bfff,2|-28|0x0089e9,-62|0|0xffffff,10|10|0xffffff,77|1|0xffffff",
	95, 0, 0, 0)
	return x,y;
end
function checkRetryButton() --Red retry button
	x, y = findColor({0, 0, 1280, 720}, 
	"0|0|0xffb5ce,-93|-16|0xffe1eb,-89|0|0xffb5ce,-93|22|0xff4784,92|-9|0xffb5ce,96|14|0xff4784,-60|5|0xffffff,-23|6|0xffffff,31|6|0xffffff,56|6|0xffffff",
	95, 0, 0, 0)
	return x,y;
end
function checkOkButton()
	x, y = findColor({0, 0, 1280, 720}, 
	"0|0|0xffffff,-98|-17|0xffffff,-99|18|0xdedede,88|-14|0xffffff,93|21|0xdedede,-2|-30|0xa0a0a0,-1|37|0x878787,-22|-2|0x525252,12|1|0x505050",
	95, 0, 0, 0)
	return x,y;
end
function tap(x,y)
	touchDown(1,x,y);
	mSleep(20);
	touchUp(1,x,y);
end
function checkTitle()
	x, y = findColor({1175, 610, 1274, 709}, 
"0|0|0xfefdfe,-6|-8|0xff3b72,9|-8|0xff3b72,-7|9|0xff3b72,7|7|0xff3b72,-36|5|0xa0a0a0,0|-28|0xa0a0a0,36|3|0xa0a0a0,1|44|0xa0a0a0",
95, 0, 0, 0);
	if x>-1 then
		currentPage="title";
		return true;
	else
		return false;
	end
end
function checkMusicRoomButton()
	x, y = findColor({1105, 544, 1255, 693}, 
		"0|0|0xfa9ebb,0|52|0xf4125d,4|59|0xf51f65,45|52|0xfccfde",
		90, 0, 0, 0)
	if x>-1 then
		return true;
	else
		return false;
	end
end
function checkBandBattleButton()
	x, y = findColor({898, 358, 1169, 570}, 
	"0|0|0xd778ff,-111|-53|0xffffff,-93|-11|0xffffff,25|24|0xe6b3fb,57|21|0xe6b3fb,-14|89|0xffffff",
	95, 0, 0, 0)
	if x > -1 then
		tap(x,y)
		return true;
	else
		return false;
end

end
function checkMultiLiveButton()
	x, y = findColor({679, 394, 1144, 554}, 
		"0|0|0xffffff,196|0|0xff3b72,355|35|0xff9db9",95, 0, 0, 0)
	if x>-1 then
		tap(x,y)
		return true;
	else
		return false;
	end
end
function checkConfirmButton()
	x, y = findColor({845, 603, 1174, 689}, 
		"0|0|0xe90079,37|-31|0xffe1eb,77|-11|0xffb5ce,107|12|0xff4885,144|-6|0xfeeaf3,189|-4|0xf81076,315|4|0xe90079",
		95, 0, 0, 0)
	if x > -1 then
		return true;
	else
		return false;
	end
end
function checkBottomRightRedButton()
	--Include Next,Ok,Ready Button
	x, y = findColor({845, 604, 1176, 699}, 
		"0|0|0xe90079,44|-20|0xffe1eb,50|-1|0xffb5ce,54|28|0xff4c89",
		95, 0, 0, 0)
	if x > -1 then
		--sysLog("Red Button Detected on Coordinate:"..x..","..y);
		--mSleep(500);
		tap(1000,y);
		return true;
	else
		return false;
	end
end
function checkCenterBlueButton()
	--Include Cancel Room and Continue Private Room Panel
	x, y = findColor({341, 304, 939, 596}, 
		"0|0|0x0089e9,17|-20|0xe1f5ff,19|-6|0xb7e7ff,19|18|0x43bfff",
		95, 0, 0, 0)
	--sysLog("Result of Blue Button: "..x..","..y);
	if x > -1 then
		return true;
	else
		return false;
	end
end
function checkHealthBar()
	x, y = findColor({939, 20, 1194, 61}, 
		"0|0|0x6eff69,1|14|0x49aa46,32|5|0x6eff69,34|13|0x49aa46",
		95, 0, 0, 0);
	x2, y2 = findColor({1170, 3, 1281, 104}, 
	"0|0|0x818286,-10|0|0x801e39,11|3|0x801e39,1|27|0x6c6c70",
	95, 0, 0, 0);
	if x > -1 or x2 > -1 then
		return true;
	else
		return false;
	end
end
function checkCenterOkButton()--For Event Rewards or disconnect Error
	x, y = findColor({250, 60, 1018, 700}, 
"0|0|0xffffff,-5|-2|0x505050,6|-2|0x505050,-4|-30|0xa0a0a0,-3|23|0xdedede,-97|-12|0xffffff,-95|20|0xdedede,80|-12|0xffffff,80|18|0xdedede",
95, 0, 0, 0)
	if x > -1 then
		tap(x,y);
		return true;
	else
		return false;
	end
end
function checkErrorButton()--For disconnect Error
	x, y = findColor({326, 125, 951, 595}, 
	"0|0|0xa0a0a0,55|-22|0xffffff,48|22|0xdedede,95|-4|0x545454,113|-4|0x505050,124|-4|0x505050,136|-13|0x545454,138|8|0x505050,206|-10|0xffffff,219|15|0xdedede",
	95, 0, 0, 0)
	if x > -1 then
		mSleep(1000);
		tap(630,520);
		mSleep(1000);
		sysLog("Disconnected");
		currentPage="";
		return true;
	else
		return false;
	end
end

function checkCloseButton()
	x, y = findColor({180, 0, 1100, 720}, 
"0|0|0xfdfdfd,-7|-1|0x515151,35|-3|0x515151,-32|4|0x515151,-97|-15|0xffffff,-94|14|0xdedede,-7|-31|0xa0a0a0,89|-14|0xffffff,93|16|0xdedede",
95, 0, 0, 0)
	if x>-1 then
		tap(x,y);
	end
end
function reloadOnTimeOut(timeout,limit)
	if timeout>=limit then
		closeApp("jp.co.craftegg.band");
		sysLog("Restart App and script!");
		lua_restart();
	end
end