require "function";
timeCount = 0;
timeOut = 60;
currentTime = os.date("%H")+0;
function main()
	while true do
		mSleep(1000);
		timeCount = timeCount+1;
		--sysLog("Main Loop, current Page = "..currentPage);
		-- Just opened the app--
		if currentPage=="" then
			if checkTitle()==true then
				tap(630,630);
				sysLog("tapped <tap to start>");
				currentPage="main";
				timeCount = 0;
			elseif checkMusicRoomButton()==true then
				currentPage="main";
				timeCount = 0;
			elseif checkMultiLiveButton()==true then
				currentPage="multiLive";
				timeCount = 0;
			elseif checkBottomRightRedButton()==true then
				currentPage="loading";
				timeCount = 0;
			end
			reloadOnTimeOut(timeCount,timeOut);
		end
		-- Main Page --
		if currentPage=="main" then
			--sysLog("Now in Main");
			checkCloseButton();
			if checkMusicRoomButton()==true then
				tap(1170,630);
				--sysLog("tapped Music Room Button");
				currentPage="musicRoom";
				timeCount = 0;
			end
			reloadOnTimeOut(timeCount,timeOut);
		end
		if currentPage=="musicRoom" then
			if checkMusicRoomButton()==true then --check again
				tap(1170,630);
			end
			if checkMultiLiveButton()==true then
				mSleep(500);
				--sysLog("tapped MultiLive Button");
				currentPage="multiLive";
				timeCount = 0;
			end
			reloadOnTimeOut(timeCount,timeOut);
		end
		if currentPage=="multiLive" then
			if checkMultiLiveButton()==true then --check again
				mSleep(500);
			end
			while checkBottomRightRedButton()==true do
				mSleep(100);
				--tap(1000,640);
				--mSleep(1000);
				--sysLog("tapped OK Button");
				currentPage="loading";
				timeCount = 0;
			end
			checkErrorButton();
			reloadOnTimeOut(timeCount,timeOut);
		end
		if currentPage=="loading" then
			if checkCenterBlueButton()==true then
				--sysLog("blue button Detected, entering Room now");
			elseif checkCenterBlueButton()==false then
				--sysLog("Room loaded, wait 2s and go to selectSong");
				mSleep(2000);
				currentPage="selectSong"
				timeCount = 0;
			end
			reloadOnTimeOut(timeCount,timeOut);
		end
		if currentPage=="selectSong" then
			-- Check Disconnected function is currently buggy, need to improve accuracy
			checkErrorButton(); --Disconnected
			if checkConnectionFail() == true then
				currentPage = "";
			end
			--checkBottomRightRedButton();
			while checkConfirmButton()==true do
				mSleep(100);
				if songSelect=="random" then
					tap(760,630);
					sysLog("Random Song");
					currentPage = "readyToStart";
					timeCount = 0;
					--songSelect="default";
				elseif songSelect=="default" then
					sysLog("Default Song");
					tap(1000,630);
					currentPage = "readyToStart";
					timeCount = 0;
					--songSelect="random";
				end
			end
			reloadOnTimeOut(timeCount,timeOut);
		end
		if currentPage=="readyToStart" then
			if checkConnectionFail() == true then
				currentPage = "";
			end
			if checkErrorButton()==true then
				sysLog("Error in ready to start");
			else
				while checkBottomRightRedButton()==true and checkConfirmButton()==false do
					mSleep(100);
					currentPage="playing";
					timeCount = 0;
				end
			end
			reloadOnTimeOut(timeCount,timeOut);
		end
		if currentPage=="playing" then
			sysLog("Start Game "..gamePlayed+1);
			while checkHealthBar()==false do --loading, no HealthBar
				timeCount = timeCount+1;
				mSleep(500);		
				checkConnectionFail();		
				--sysLog("Loading . . .");
				if checkErrorButton()==true then
					break;
				end
				reloadOnTimeOut(timeCount,120);
			end
			timeCount = 0;
			while checkHealthBar()==true do
				--sysLog("playing - HealthBar still here...");
				mSleep(3000);
				timeCount = timeCount+1;
				checkErrorButton();
				reloadOnTimeOut(timeCount,120);
			end
			if checkHealthBar()==false and currentPage=="playing" then
				--sysLog("No more HealthBar");
				if checkConnectionFail() == true then
					currentPage = "";
				end
				while checkMusicRoomButton()==false do
					timeCount = timeCount + 1;
					reloadOnTimeOut(timeCount,300);
					checkCenterOkButton();
					mSleep(100);
					tap(630,530);
					mSleep(100);
					checkBottomRightRedButton();
				end
				gamePlayed=gamePlayed+1;
				sysLog("Finish Game "..gamePlayed);
				currentTime = os.date("%H")+0
				if currentTime>=0 and currentTime<=5 then
					songSelect=toggleSong(songSelect);
				else
					songSelect = "random";
				end
				timeCount = 0;
				currentPage="";
			end			
		end
	end
end