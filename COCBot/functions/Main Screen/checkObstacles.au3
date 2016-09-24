
; #FUNCTION# ====================================================================================================================
; Name ..........: checkObstacles
; Description ...: Checks whether something is blocking the pixel for mainscreen and tries to unblock
; Syntax ........: checkObstacles()
; Parameters ....:
; Return values .: Returns True when there is something blocking
; Author ........: Hungle (2014)
; Modified ......: KnowJack (2015), Sardo 2015-08, The Master 2015-10, MonkeyHunter (08-2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
;
Func checkObstacles() ;Checks if something is in the way for mainscreen
	Local $x, $y, $result
	$MinorObstacle = False

	If WinGetAndroidHandle() = 0 Then
		; Android not available
		Return True
	EndIf

    ;Chalicucu click Cancel Button while load other village
    ; If _ColorCheck(_GetPixelColor(443, 430, True), Hex(4284390935, 6), 20) Then
    If _GetPixelColor(443, 430, True) = Hex(4284390935, 6) Then
        PureClick(383, 430, 1, 0, "Click Cancel")      ;Click Cancel
        If _Sleep(250) Then Return
    EndIf

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Detect All Reload Button errors => 1- Another device, 2- Take a break, 3- Connection lost or error, 4- Out of sync, 5- Inactive, 6- Maintenance
	$Message = _PixelSearch($aIsReloadError[0], $aIsReloadError[1], $aIsReloadError[0] + 3, $aIsReloadError[1] + 11, Hex($aIsReloadError[2], 6), $aIsReloadError[3])
	If IsArray($Message) Then
		_CaptureRegion()
		If $debugsetlog = 1 Then SetLog("(Inactive=" & _GetPixelColor($aIsInactive[0], $aIsInactive[1]) & ")(DC=" & _GetPixelColor($aIsConnectLost[0], $aIsConnectLost[1]) & ")(OoS=" & _GetPixelColor($aIsCheckOOS[0], $aIsCheckOOS[1]) & ")", $COLOR_PURPLE)
		If $debugsetlog = 1 Then SetLog("(Maintenance=" & _GetPixelColor($aIsMaintenance[0], $aIsMaintenance[1]) & ")(RateCoC=" & ")", $COLOR_PURPLE)
		If $debugsetlog = 1 Then SetLog("33B5E5=>true, 282828=>false", $COLOR_PURPLE)
		;;;;;;;##### 1- Another device #####;;;;;;;
		$result = getOcrMaintenanceTime(184, 325 + $midOffsetY) ; OCR text to find Another device message
		If StringInStr($result, "device", $STR_NOCASESENSEBASIC) Or _
			_ImageSearchAreaImgLoc($device, 0, 220, 300 + $midOffsetY, 300, 360 + $midOffsetY, $x, $y, 95) Then
			;_ImageSearchArea($device, 0, 237, 321 + $midOffsetY, 293, 346 + $midOffsetY, $x, $y, 80) Then
			If $sTimeWakeUp > 3600 Then
				SetLog("Another Device has connected, waiting " & Floor(Floor($sTimeWakeUp / 60) / 60) & " hours " & Floor(Mod(Floor($sTimeWakeUp / 60), 60)) & " minutes " & Floor(Mod($sTimeWakeUp, 60)) & " seconds", $COLOR_RED)
				PushMsgToPushBullet("AnotherDevice3600")
			ElseIf $sTimeWakeUp > 60 Then
				SetLog("Another Device has connected, waiting " & Floor(Mod(Floor($sTimeWakeUp / 60), 60)) & " minutes " & Floor(Mod($sTimeWakeUp, 60)) & " seconds", $COLOR_RED)
				PushMsgToPushBullet("AnotherDevice60")
			Else
				SetLog("Another Device has connected, waiting " & Floor(Mod($sTimeWakeUp, 60)) & " seconds", $COLOR_RED)
				PushMsgToPushBullet("AnotherDevice")
			EndIf
			If _SleepStatus($sTimeWakeUp * 1000) Then Return ; Wait as long as user setting in GUI, default 120 seconds
			checkObstacles_ReloadCoC($aReloadButton, "#0127")
			If _Sleep(2000) Then Return
			If $ichkSinglePBTForced = 1 Then $bGForcePBTUpdate = True
			checkObstacles_ResetSearch()
			Return True
		EndIf
		;;;;;;;##### 2- Take a break #####;;;;;;;
		;If _ImageSearchArea($break, 0, 165, 257 + $midOffsetY, 335, 295 + $midOffsetY, $x, $y, 100) Then ; used for all 3 different break messages
		If _ImageSearchAreaImgLoc($break, 0, 165, 257 + $midOffsetY, 335, 295 + $midOffsetY, $x, $y, 95) Then ; used for all 3 different break messages
			SetLog("Village must take a break, wait ...", $COLOR_RED)
			PushMsgToPushBullet("TakeBreak")
			If _SleepStatus($iDelaycheckObstacles4) Then Return ; 2 Minutes
			checkObstacles_ReloadCoC($aReloadButton, "#0128");Click on reload button
			If $ichkSinglePBTForced = 1 Then $bGForcePBTUpdate = True
			checkObstacles_ResetSearch()
			Return True
		EndIf
		;;;;;;;##### Connection Lost & OoS & Inactive & Maintenance #####;;;;;;;
		Select
			Case _CheckPixel($aIsInactive, $bNoCapturePixel) ; Inactive only
				SetLog("Village was Inactive, Reloading CoC...", $COLOR_RED)
				If $ichkSinglePBTForced = 1 Then $bGForcePBTUpdate = True
			Case _CheckPixel($aIsConnectLost, $bNoCapturePixel) ; Connection Lost
				;  Add check for banned account :(
				$result = getOcrMaintenanceTime(171, 358 + $midOffsetY, "Check Obstacles OCR 'policy at super'=") ; OCR text for "policy at super"
				If StringInStr($result, "policy", $STR_NOCASESENSEBASIC) Then
					SetLog("Sorry but account has been banned, Bot must stop!!", $COLOR_RED)
					BanMsgBox()
					Btnstop() ; stop bot
					Return True
				EndIf
				$result = getOcrMaintenanceTime(171, 337 + $midOffsetY, "Check Obstacles OCR 'prohibited 3rd'= ") ; OCR text for "prohibited 3rd party"
				If StringInStr($result, "3rd", $STR_NOCASESENSEBASIC) Then
					SetLog("Sorry but account has been banned, Bot must stop!!", $COLOR_RED)
					BanMsgBox()
					Btnstop() ; stop bot
					Return True
				EndIf
				SetLog("Connection lost, Reloading CoC...", $COLOR_RED)
				ChckInetCon()
			Case _CheckPixel($aIsCheckOOS, $bNoCapturePixel) ; Check OoS
				SetLog("Out of Sync Error, Reloading CoC...", $COLOR_RED)
			Case _CheckPixel($aIsMaintenance, $bNoCapturePixel) ; Check Maintenance
				$result = getOcrMaintenanceTime(171, 345 + $midOffsetY, "Check Obstacles OCR Maintenance Break=") ; OCR text to find wait time
				Local $iMaintenanceWaitTime = 0
				Select
					Case $result = ""
						$iMaintenanceWaitTime = $iDelaycheckObstacles4 ; Wait 2 min
					Case StringInStr($result, "few", $STR_NOCASESENSEBASIC)
						$iMaintenanceWaitTime = $iDelaycheckObstacles4 ; Wait 2 min
					Case StringInStr($result, "10", $STR_NOCASESENSEBASIC)
						$iMaintenanceWaitTime = $iDelaycheckObstacles6 ; Wait 5 min
					Case StringInStr($result, "15", $STR_NOCASESENSEBASIC)
						$iMaintenanceWaitTime = $iDelaycheckObstacles6 ; Wait 5 min
					Case StringInStr($result, "20", $STR_NOCASESENSEBASIC)
						$iMaintenanceWaitTime = $iDelaycheckObstacles7 ; Wait 10 min
					Case StringInStr($result, "30", $STR_NOCASESENSEBASIC)
						$iMaintenanceWaitTime = $iDelaycheckObstacles8 ; Wait 15 min
					Case StringInStr($result, "45", $STR_NOCASESENSEBASIC)
						$iMaintenanceWaitTime = $iDelaycheckObstacles9 ; Wait 20 min
					Case StringInStr($result, "hour", $STR_NOCASESENSEBASIC)
						$iMaintenanceWaitTime = $iDelaycheckObstacles10 ; Wait 30 min
					Case Else
						$iMaintenanceWaitTime = $iDelaycheckObstacles4 ; Wait 2 min
						SetLog("Error reading Maintenance Break time?", $COLOR_RED)
				EndSelect
				SetLog("Maintenance Break, waiting: " & $iMaintenanceWaitTime / 60000 & " minutes....", $COLOR_RED)
				If $ichkSinglePBTForced = 1 Then $bGForcePBTUpdate = True
				If _SleepStatus($iMaintenanceWaitTime) Then Return
				checkObstacles_ResetSearch()
			Case Else
				;  Add check for misc error messages
				If $debugImageSave = 1 Then DebugImageSave("ChkObstaclesReloadMsg_")  ; debug only
				$result = getOcrMaintenanceTime(171, 325 + $midOffsetY, "Check Obstacles OCR 'Good News!'=") ; OCR text for "Good News!"
				If StringInStr($result, "new", $STR_NOCASESENSEBASIC) Then
					SetLog("Game Update is required, Bot must stop!!", $COLOR_RED)
					Btnstop() ; stop bot
					Return True
				EndIf
				$result = getOcrRateCoc(228, 380 + 12 + $midOffsetY)
				If $debugsetlog = 1 Then SetLog("Check Obstacles getOCRRateCoC= " & $result, $COLOR_PURPLE)  ; debug only
				If StringInStr($result, "never", $STR_NOCASESENSEBASIC) Then
					SetLog("Clash feedback window found, permanently closed!", $COLOR_RED)
					PureClick(248, 408 + $midOffsetY, 1, 0, "#9999") ; Click on never to close window and stop reappear. Never=248,408 & Later=429,408
					$MinorObstacle = True
					Return True
				EndIf
				;  Add check for banned account :(
				$result = getOcrMaintenanceTime(171, 358 + $midOffsetY, "Check Obstacles OCR 'policy at super'=") ; OCR text for "policy at super"
				If StringInStr($result, "policy", $STR_NOCASESENSEBASIC) Then
					SetLog("Sorry but account has been banned, Bot must stop!!", $COLOR_RED)
					BanMsgBox()
					Btnstop() ; stop bot
					Return True
				EndIf
				$result = getOcrMaintenanceTime(171, 337 + $midOffsetY, "Check Obstacles OCR 'prohibited 3rd'= ") ; OCR text for "prohibited 3rd party"
				If StringInStr($result, "3rd", $STR_NOCASESENSEBASIC) Then
					SetLog("Sorry but account has been banned, Bot must stop!!", $COLOR_RED)
					BanMsgBox()
					Btnstop() ; stop bot
					Return True
				EndIf
				SetLog("Warning: Can not find type of Reload error message", $COLOR_RED)
				SetDebugLog("OCR Text: " & $result)
		EndSelect
		checkObstacles_ReloadCoC($aReloadButton, "#0131"); Click for out of sync or inactivity or connection lost or maintenance
		If _Sleep($iDelaycheckObstacles3) Then Return
		Return True
	EndIf
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	_CaptureRegion() ; Bot restart is not required for These cases just close window then WaitMainScreen then continue
	If _ColorCheck(_GetPixelColor(235, 209 + $midOffsetY), Hex(0x9E3826, 6), 20) Then
		PureClick(429, 493 + $midOffsetY, 1, 0, "#0132") ;See if village was attacked, clicks Okay
		$iShouldRearm = True
		$MinorObstacle = True
		If _Sleep($iDelaycheckObstacles1) Then Return
		Return False
	EndIf
	If _CheckPixel($aIsMainGrayed, $bNoCapturePixel) Then
		PureClickP($aAway, 1, 0, "#0133") ;Click away If things are open
		If _Sleep(1000) Then Return
		If _ColorCheck(_GetPixelColor(383, 405), Hex(0xF0BE70, 6), 20) Then
			SetLog("Found Window Load Click Cancel", $COLOR_RED)
			PureClick(354, 435, 1, 0, "Click Cancel") ;Click Cancel Button
		EndIf
		$MinorObstacle = True
		If _Sleep($iDelaycheckObstacles1) Then Return
		Return False
	EndIf
	If _ColorCheck(_GetPixelColor(792, 39), Hex(0xDC0408, 6), 20) Then
		PureClick(792, 39, 1, 0, "#0134") ;Clicks X
		$MinorObstacle = True
		If _Sleep($iDelaycheckObstacles1) Then Return
		Return False
	EndIf
	If _CheckPixel($aCancelFight, $bNoCapturePixel) Or _CheckPixel($aCancelFight2, $bNoCapturePixel) Then
		PureClickP($aCancelFight, 1, 0, "#0135") ;Clicks X
		$MinorObstacle = True
		If _Sleep($iDelaycheckObstacles1) Then Return
		Return False
	EndIf
	If _CheckPixel($aChatTab, $bNoCapturePixel) Then
		PureClickP($aChatTab, 1, 0, "#0136") ;Clicks chat tab
		$MinorObstacle = True
		If _Sleep($iDelaycheckObstacles1) Then Return
		Return False
	EndIf
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	If _CheckPixel($aEndFightSceneBtn, $bNoCapturePixel) Then
		PureClickP($aEndFightSceneBtn, 1, 0, "#0137") ;If in that victory or defeat scene
		Return True
	EndIf
	If _CheckPixel($aSurrenderButton, $bNoCapturePixel) Then
		ReturnHome(False, False) ;If End battle is available
		Return True
	EndIf
	;If _ImageSearchArea($CocStopped, 0, 250, 328 + $midOffsetY, 618, 402 + $midOffsetY, $x, $y, 70) Then
	If _ImageSearchAreaImgLoc($CocStopped, 0, 250, 328 + $midOffsetY, 618, 402 + $midOffsetY, $x, $y, 95) Then
		SetLog("CoC Has Stopped Error .....", $COLOR_RED)
		PushMsgToPushBullet("CoCError")
		If _Sleep($iDelaycheckObstacles1) Then Return
		PureClick(250 + $x, 328 + $midOffsetY + $y, 1, 0, "#0129");Check for "CoC has stopped error, looking for OK message" on screen
		If _Sleep($iDelaycheckObstacles2) Then Return
		CloseCoC(True)
		Return True
	EndIf
	If _CheckPixel($aNoCloudsAttack, $bNoCapturePixel) Then ; Prevent drop of troops while searching
		$Message = _PixelSearch(23, 566 + $bottomOffsetY, 36, 580 + $bottomOffsetY, Hex(0xF4F7E3, 6), 10)
		If IsArray($Message) Then
			; If _ColorCheck(_GetPixelColor(67,  602 + $bottomOffsetY), Hex(0xDCCCA9, 6), 10) = False Then  ; add double check?
			PureClick(67, 602 + $bottomOffsetY, 1, 0, "#0138");Check if Return Home button available
			If _Sleep($iDelaycheckObstacles2) Then Return
			Return True
		EndIf
	EndIf
	If IsPostDefenseSummaryPage() Then
		$Message = _PixelSearch(23, 566 + $bottomOffsetY, 36, 580 + $bottomOffsetY, Hex(0xE0E1CE, 6), 10)
		If IsArray($Message) Then
			PureClick(67, 602 + $bottomOffsetY, 1, 0, "#0138");Check if Return Home button available
			If _Sleep($iDelaycheckObstacles2) Then Return
			Return True
		EndIf
	EndIf
	Return False
EndFunc   ;==>checkObstacles

; It's more stable to restart CoC app than click the message restarting the game
Func checkObstacles_ReloadCoC($point, $debugtxt = "")
	;PureClickP($point, 1, 0, $debugtxt)
	CloseCoC(True)
EndFunc   ;==>checkObstacles_ReloadCoC

Func checkObstacles_ResetSearch()
	; reset fast restart flags to ensure base is rearmed after error event that has base offline for long duration, like PB or Maintenance
	$Is_ClientSyncError = False
	$Is_SearchLimit = False
	$Quickattack = False
	$Restart = True ; signal all calling functions to return to runbot
EndFunc   ;==>checkObstacles_ResetSearch

Func BanMsgBox()
	Local $MsgBox
	Local $stext = "Sorry, youy account is banned!!" & @CRLF & "Bot will stop now..."
	While 1
		_ExtMsgBoxSet(4, 1, 0x004080, 0xFFFF00, 20, "Comic Sans MS", 600)
		$MsgBox = _ExtMsgBox(48, "Ok", "Banned", $stext, 1, $frmBot)
		If $MsgBox = 1 Then Return
		_ExtMsgBoxSet(4, 1, 0xFFFF00, 0x004080, 20, "Comic Sans MS", 600)
		$MsgBox = _ExtMsgBox(48, "Ok", "Banned", $stext, 1, $frmBot)
		If $MsgBox = 1 Then Return
	WEnd
EndFunc   ;==>BanMsgBox
