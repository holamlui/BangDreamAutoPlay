require "function";
init("0",1);--jp.co.craftegg.band
currentPage = "";
songSelect = "default";
gamePlayed= 0;
function confirmButton()
	x, y = findColor({630, 555, 913, 671}, 
		"0|0|0xffb5ce,-49|-15|0xffe1eb,-44|-2|0xffb5ce,-43|23|0xff4784,123|-10|0xffb5ce,132|22|0xff4784,32|3|0xffffff",
		90, 0, 0, 0)
	sysLog('X :'..x..'Y :'..y);
	if x > -1 then
		tap(x,y);
		return true;
	else
		tap(725,603);
		return false;
	end
end
function event()
	while true do
		mSleep(1000);
		if currentPage=="" then
			if checkTitle()==true then
				tap(630,630);
				sysLog("tapped <tap to start>");
				currentPage="main";
			elseif checkMusicRoomButton()==true then
				currentPage="main";
			end
		end
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
				tap(1000,250);--purple button
				mSleep(500);
				--sysLog("tapped MultiLive Button");
				currentPage="event";
			end
		end
		if currentPage=="event" then
			if checkMultiLiveButton()==true then --check again
				mSleep(1500);
				tap(1000,250);--purple button
				mSleep(500);
				--sysLog("tapped MultiLive Button");
				currentPage="event";
			end
			if checkBottomRightRedButton()==true then
				 checkBottomRightRedButton();
				currentPage="loading";
			end
		end
		if currentPage=='loading' then
			mSleep(3500);
			confirmButton();
			mSleep(1500);
			tap(1000,640);
			currentPage="playing";
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
				if checkConnectionFail() == true then
					currentPage = "";
				end
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
end