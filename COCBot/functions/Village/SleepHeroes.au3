; #FUNCTION# ====================================================================================================================
; Name ..........: Sleep Heroes
; Description ...: A Function To Put Heroes In Sleep Mode
; Syntax ........: ToggleGuard($ActivateGuard)
; Parameters ....: $ActivateGuard              - [optional] If You Want To DeActivate Barbarian King/Archer Queen/Grand Warden Guard Set It False, Default value is TRUE
; Return values .: None
; Author ........: MR.ViPER
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func ToggleGuard($ActivateGuard = True)
	If $ClosedDueToPB = True Then
		If $ichkPBSleepBK = 1 Then SleepHeroes("BK", $ActivateGuard)
		If $ichkPBSleepAQ = 1 Then SleepHeroes("AQ", $ActivateGuard)
		If $ichkPBSleepGW = 1 Then SleepHeroes("GW", $ActivateGuard)
		If $ActivateGuard = False Then $ClosedDueToPB = False
	EndIf
EndFunc   ;==>ToggleGuard

Func SleepHeroes($Hero, $Guard = True)
	Local $HeroFullName
	Select
		Case $Hero = "BK"
			$HeroFullName = "Barbarian King"
		Case $Hero = "AQ"
			$HeroFullName = "Archer Queen"
		Case $Hero = "GW"
			$HeroFullName = "Grand Warden"
		Case Else
			$HeroFullName = "Unknown Hero!!"
	EndSelect
	Local $SelectionStatus = SelectHero($Hero)
	If $SelectionStatus = True Then
		If $Guard = True Then
			If ClickOnGuard() = True Then SetLog("Guard Activated For " & $HeroFullName, $COLOR_GREEN)
		Else
			If ClickOnSleep() = True Then SetLog("Guard DeActivated For " & $HeroFullName, $COLOR_GREEN)
		EndIf
	Else
		SetLog("Failed to Toggle " & $HeroFullName & ", Failed to Select " & $HeroFullName, $COLOR_ORANGE)
	EndIf
	ClickP($aTopLeftClient, 1, 0, "#0166") ; Click away
	Sleep(500)
EndFunc   ;==>SleepHeroes

Func SelectHero($Hero)
	Select
		Case $Hero = "BK"
			SetLog("Selecting Barbarian King To Toggle Guard", $COLOR_BLUE)
			If isInsideDiamond($KingAltarPos) = False Then LocateKingAltar()
			ClickP($aTopLeftClient, 1, 0, "#0166") ; Click away
			Click($KingAltarPos[0], $KingAltarPos[1])
			Local $sInfo = BuildingInfo(242, 520 + $bottomOffsetY); 860x780
			If @error Then SetError(0, 0, 0)
			Local $CountGetInfo = 0
			While IsArray($sInfo) = False
				$sInfo = BuildingInfo(242, 520 + $bottomOffsetY); 860x780
				If @error Then SetError(0, 0, 0)
				Sleep(100)
				$CountGetInfo += 1
				If $CountGetInfo >= 50 Then Return
			WEnd
			If $debugSetlog = 1 Then SetLog(_ArrayToString($sInfo, " "))
			If @error Then Return SetError(0, 0, 0)
			If $sInfo[0] > 1 Or $sInfo[0] = "" Then
			If StringInStr($sInfo[1], "Barbarian") = 0 Then
				SetLog("Bad King location", $COLOR_ORANGE)
				Return False
			EndIf
			EndIf
			Return True
		Case $Hero = "AQ"
			SetLog("Selecting Archer Queen To Toggle Guard", $COLOR_BLUE)
			If isInsideDiamond($QueenAltarPos) = False Then LocateQueenAltar()
			ClickP($aTopLeftClient, 1, 0, "#0166") ; Click away
			Click($QueenAltarPos[0], $QueenAltarPos[1])
			Local $sInfo = BuildingInfo(242, 520 + $bottomOffsetY); 860x780
			If @error Then SetError(0, 0, 0)
			Local $CountGetInfo = 0
			While IsArray($sInfo) = False
				$sInfo = BuildingInfo(242, 520 + $bottomOffsetY); 860x780
				If @error Then SetError(0, 0, 0)
				Sleep(100)
				$CountGetInfo += 1
				If $CountGetInfo >= 50 Then Return
			WEnd
			If $debugSetlog = 1 Then SetLog(_ArrayToString($sInfo, " "))
			If @error Then Return SetError(0, 0, 0)
			If $sInfo[0] > 1 Or $sInfo[0] = "" Then
			If StringInStr($sInfo[1], "Quee") = 0 Then
				SetLog("Bad AQ location", $COLOR_ORANGE)
				Return False
			EndIf
			EndIf
			Return True
		Case $Hero = "GW"
			SetLog("Selecting Grand Warden To Toggle Guard", $COLOR_BLUE)
			If isInsideDiamond($WardenAltarPos) = False Then LocateWardenAltar()
			ClickP($aTopLeftClient, 1, 0, "#0166") ; Click away
			Click($WardenAltarPos[0], $WardenAltarPos[1])
			Local $sInfo = BuildingInfo(242, 520 + $bottomOffsetY); 860x780
			If @error Then SetError(0, 0, 0)
			Local $CountGetInfo = 0
			While IsArray($sInfo) = False
				$sInfo = BuildingInfo(242, 520 + $bottomOffsetY); 860x780
				If @error Then SetError(0, 0, 0)
				Sleep(100)
				$CountGetInfo += 1
				If $CountGetInfo >= 50 Then Return
			WEnd
			If $debugSetlog = 1 Then SetLog(_ArrayToString($sInfo, " "))
			If @error Then Return SetError(0, 0, 0)
			If $sInfo[0] > 1 Or $sInfo[0] = "" Then
			If StringInStr($sInfo[1], "Grand") = 0 Then
				SetLog("Bad Warden location", $COLOR_ORANGE)
				Return False
			EndIf
			EndIf
			Return True
		Case Else
			Return False
	EndSelect
	Return False
EndFunc   ;==>SelectHero

Func ClickOnSleep()
	Local $ImagesToUse = @ScriptDir & "\images\Button\Sleep.png"
	$ToleranceImgLoc = 0.90
	_CaptureRegion2(125, 610, 740, 715)
	$res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $ImagesToUse, "float", $ToleranceImgLoc, "str", "FV", "int", 1)
	If IsArray($res) Then
		If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
			If $res[0] = "0" Or $res[0] = "" Then
				; failed to find Sleep Button
				SetLog("No Sleep Button Found",$COLOR_RED)
				Return False
			ElseIf $res[0] = "-1" Then
				SetLog("DLL Error", $COLOR_RED)
				Return False
			ElseIf $res[0] = "-2" Then
				SetLog("Invalid Resolution", $COLOR_RED)
				Return False
			Else
				$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
				$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
				$ButtonX = 125 + Int($posPoint[0])
				$ButtonY = 610 + Int($posPoint[1])
				Click($ButtonX, $ButtonY, 1, 0, "#04009")
				Sleep(50)
				Return True
			EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>SleepHeroes

Func ClickOnGuard()
	Local $ImagesToUse = @ScriptDir & "\images\Button\Guard.png"
	$ToleranceImgLoc = 0.90
	_CaptureRegion2(125, 610, 740, 715)
	$res = DllCall($hImgLib, "str", "SearchTile", "handle", $hHBitmap2, "str", $ImagesToUse, "float", $ToleranceImgLoc, "str", "FV", "int", 1)
	If IsArray($res) Then
		If $DebugSetlog = 1 Then SetLog("DLL Call succeeded " & $res[0], $COLOR_RED)
			If $res[0] = "0" Or $res[0] = "" Then
				; failed to find Guard Button
				SetLog("No Guard Button Found",$COLOR_RED)
				Return False
			ElseIf $res[0] = "-1" Then
				SetLog("DLL Error", $COLOR_RED)
				Return False
			ElseIf $res[0] = "-2" Then
				SetLog("Invalid Resolution", $COLOR_RED)
				Return False
			Else
				$expRet = StringSplit($res[0], "|", $STR_NOCOUNT)
				$posPoint = StringSplit($expRet[1], ",", $STR_NOCOUNT)
				$ButtonX = 125 + Int($posPoint[0])
				$ButtonY = 610 + Int($posPoint[1])
				Click($ButtonX, $ButtonY, 1, 0, "#04009")
				Sleep(50)
				Return True
			EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>ClickOnSleep