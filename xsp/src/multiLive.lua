require "function";
init("0",1);--jp.co.craftegg.band
currentPage = "";
songSelect = "random";--random / default
gamePlayed= 0;
function main()
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
			elseif checkMultiLiveButton()==true then
				currentPage="multiLive";
			elseif checkBottomRightRedButton()==true then
				currentPage="loading";
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
			if checkConnectionFail() == true then
				currentPage = "";
			end
			--checkBottomRightRedButton();
			if checkConfirmButton()==true then
				if songSelect=="random" then
					mSleep(1000);
					tap(760,630);
					sysLog("Random Song");
					mSleep(2000);
					currentPage = "readyToStart";
					--songSelect="default";
				elseif songSelect=="default" then
					mSleep(1000);
					sysLog("Default Song");
					tap(1000,630);
					mSleep(2000);
					currentPage = "readyToStart";
					--songSelect="random";
				end
			end
		end
		if currentPage=="readyToStart" then
			if checkConnectionFail() == true then
				currentPage = "";
			end
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