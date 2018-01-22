require "function";
currentPage = "";
songSelect = "random";
function isRoomFull()
	x, y = findColor({308, 174, 1211, 535}, 
		"0|0|0xbbbbbb,-10|36|0xb8b8b8,-12|83|0xadadad,62|14|0xc4c4c4,41|44|0xadadad,83|43|0xadadad,126|101|0xbbbbbb,130|10|0xadadad,131|144|0xadadad",
		95, 0, 0, 0)
	if x > -1 then
		return false;
	else
		return true;
	end
end
function reEnterRoom()
	x, y = findColor({336, 210, 944, 511}, 
		"0|0|0xffb5ce,-97|-25|0xffe1eb,-90|-9|0xffb6ce,-87|8|0xff4784,-27|-5|0xffffff,-9|5|0xffffff,8|-1|0xffffff,29|-1|0xffffff,8|-30|0xe90079,106|-2|0xff4784",
		95, 0, 0, 0)
	if x > -1 then
		tap(x,y);
		return true;
	else
		return false;
	end
end
function isLobby()
	x, y = findColor({70, 156, 1205, 253}, 
		"0|0|0xfe2d4a,216|-1|0x0291ff,442|3|0xff8902,666|2|0x02a76a,885|2|0xb433ff",
		90, 0, 0, 0)
	if x > -1 then
		return true;
	else
		return false;
	end
end
function privateRoom()
	while true do
		mSleep(1000);
		if currentPage=="" then
			if isLobby()==true then
				sysLog("In Lobby");
				currentPage = "lobby";
			end
			if checkHealthBar()==true then
				currentPage="playing";
				sysLog("currentPage: Playing");
			end
			reEnterRoom();
		end
		if currentPage=="lobby" then
			if isRoomFull()==true then
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
			end
			timeCount = 0;
			while checkHealthBar()==true do
				--sysLog("playing - HealthBar still here...");
				mSleep(3000);
				timeCount = timeCount+1;
				checkErrorButton();
			end
			if checkHealthBar()==false and currentPage=="playing" then
				--sysLog("No more HealthBar");
				if checkConnectionFail() == true then
					currentPage = "";
				end
				while isLobby()==false do
					timeCount = timeCount + 1;
					reloadOnTimeOut(timeCount,300);
					checkCenterOkButton();
					mSleep(100);
					tap(630,530);
					checkCloseButton();
					mSleep(100);
					checkBottomRightRedButton();
					reEnterRoom();
				end
				currentPage="lobby";
				gamePlayed=gamePlayed+1;
				sysLog("Finish Game "..gamePlayed);
			end
		end
	end
end