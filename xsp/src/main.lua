init("0",1);
currentPage ="";
function tap(x,y)
	touchDown(1,x,y);
	mSleep(20);
	touchUp(1,x,y);
end
function checkTitle()
	return findColor({513, 619, 765, 655}, "0|0|0xfd5a85",95, 0, 0, 0);
end
function checkMusicRoomButton()
end
function checkMultiLiveButton()
end
function checkNextButton()
end
function checkCancelButton()
end
function checkOkButton()
end
function checkCloseButton()
end

while true do
	mSleep(1000);
	sysLog("current Page = "..currentPage);
	--Get currentPage--
	if checkTitle() > -1 then
		currentPage="title";
		sysLog("Title Page");
	end
	--End of Get currentPage--
	--Main Loop--
	sysLog("Main Loop");
	if currentPage=="title" then
		tap(630,630);
		sysLog("tapped <tap to start>");
		currentPage="main";
	end
end