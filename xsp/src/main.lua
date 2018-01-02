init("0",1);
currentPage = "";
songSelect = "default";
gamePlayed= 0;
function tap(x,y)
	touchDown(1,x,y);
	mSleep(20);
	touchUp(1,x,y);
end
function checkTitle()
	x,y = findColor({513, 619, 765, 655}, "0|0|0xfd5a85",95, 0, 0, 0);
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
function checkMultiLiveButton()
	x, y = findColor({679, 394, 1144, 554}, 
		"0|0|0xffffff,196|0|0xff3b72,355|35|0xff9db9",95, 0, 0, 0)
	if x>-1 then
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
		mSleep(1000);
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
		95, 0, 0, 0)
	if x > -1 then
		return true;
	else
		return false;
	end
end
function checkCenterOkButton()--For Event Rewards or disconnect Error
	x, y = findColor({338, 134, 943, 585}, 
		"0|0|0xffbb44,46|22|0xff3b72,136|342|0xa0a0a0,231|353|0x505050",
		100, 0, 0, 0)
	if x > -1 then
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
		currentPage="multiLive";
		return true;
	else
		return false;
	end
end
function checkRedOkButton() --For Red OK Button in bottom-right
	x, y = findColor({849, 605, 1174, 680}, 
		"0|0|0xe90079,29|-21|0xffe1eb,76|-8|0xffb5ce,88|20|0xff4985,131|0|0xf81076,175|2|0xf81076",
		95, 0, 0, 0)
	if x>-1 then
		return true;
	else
		return false;
	end
end
function checkCloseButton()
	x, y = findColor({503,591, 767, 683}, 
		"0|0|0xa0a0a0,39|2|0xffffff,71|5|0x505050,109|-3|0x515151",95, 0, 0, 0)
	if x>-1 then
		mSleep(500);
		tap(640,650); --Tap close
		sysLog("Close Notification");
	end
end
while true do
	mSleep(1000);
	--sysLog("Main Loop, current Page = "..currentPage);
	-- Just opened the app--
	if currentPage=="" then
		if checkTitle()==true then
			tap(630,630);
			sysLog("tapped <tap to start>");
			currentPage="main";
		elseif checkMusicRoomButton()==true then
			currentPage="main";
		end
	end
	-- Main Page --
	if currentPage=="main" then
		--sysLog("Now in Main");
		checkCloseButton();
		if checkMusicRoomButton()==true then
			mSleep(1000);
			tap(1170,630);
			--sysLog("tapped Music Room Button");
			currentPage="musicRoom";
			mSleep(1000);
		end
	end
	if currentPage=="musicRoom" then
		if checkMultiLiveButton()==true then
			mSleep(1500);
			tap(900,500);
			mSleep(500);
			--sysLog("tapped MultiLive Button");
			currentPage="multiLive";
		end
	end
	if currentPage=="multiLive" then
		if checkMultiLiveButton()==true then --check again
			mSleep(500);
			tap(900,500);
			mSleep(500);
			--sysLog("tapped MultiLive Button");
			currentPage="multiLive";
		end
		if checkBottomRightRedButton()==true then
			--mSleep(1000);
			--tap(1000,640);
			--mSleep(1000);
			--sysLog("tapped OK Button");
			currentPage="loading";
		end
		checkErrorButton();
	end
	if currentPage=="loading" then
		if checkCenterBlueButton()==true then
			--sysLog("blue button Detected, entering Room now");
		elseif checkCenterBlueButton()==false then
			--sysLog("Room loaded, wait 2s and go to selectSong");
			mSleep(2000);
			currentPage="selectSong"
		end
	end
	if currentPage=="selectSong" then
		-- Check Disconnected function is currently buggy, need to improve accuracy
		checkErrorButton(); --Disconnected
		
		--checkBottomRightRedButton();
		if checkConfirmButton()==true then
			if songSelect=="random" then
				mSleep(1000);
				tap(760,630);
				sysLog("Random Song");
				mSleep(2000);
				currentPage = "readyToStart";
				songSelect="default";
			elseif songSelect=="default" then
				mSleep(1000);
				sysLog("Default Song");
				tap(1000,630);
				mSleep(2000);
				currentPage = "readyToStart";
				songSelect="random";
			end
		end
	end
	if currentPage=="readyToStart" then
		if checkErrorButton()==true then
			sysLog("Error in ready to start");
		elseif checkBottomRightRedButton()==true then
			currentPage="playing";
		end
	end
	if currentPage=="playing" then
		sysLog("Start Game "..gamePlayed+1);
		while checkHealthBar()==false do --loading, no HealthBar
			mSleep(5000);
			--sysLog("Loading . . .");
			if checkErrorButton()==true then
				break;
			end
		end
		while checkHealthBar()==true do
			--sysLog("playing - HealthBar still here...");
			mSleep(3000);
			checkErrorButton();
		end
		if checkHealthBar()==false and currentPage=="playing" then
			--sysLog("No more HealthBar");
			while checkMusicRoomButton()==false do
				tap(630,530);
				mSleep(100);
				tap(630,530);
				mSleep(100);
				checkBottomRightRedButton();
			end
			gamePlayed=gamePlayed+1;
			sysLog("Finish Game "..gamePlayed);
			if checkMusicRoomButton()==true then
				currentPage="main";
			end
		end
	end
end