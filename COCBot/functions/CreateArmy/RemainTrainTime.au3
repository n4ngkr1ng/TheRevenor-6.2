; #FUNCTION# ====================================================================================================================
; Name ..........: RemainTrainTime() - Read the remain train troops and spells from ArmyOverView Window
; Description ...: This file contens the Sequence that runs all MBR Bot
; Author ........: ProMac (made for Doc Octopus mod - Close COC while training)
; Modified ......: Chalicucu (add $opnArmOver argument to check with army overview opened)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func RemainTrainTime($Troops = True, $Spells = True, $opnArmOver = True) ; Function from DocOctopus Mod
	Local $flag = True		;Chalicucu add flag to check if needed to open army overview window or not
	; Lets open the ArmyOverView Window (this function will check if we are on Main Page and wait for the window open returning True or False)
	If $opnArmOver Then $flag = openArmyOverview()
	;If openArmyOverview() Then
	If $flag Then

		Local $aRemainTrainTroopTimer = 0
		Local $aRemainTrainSpellsTimer = 0
		Local $ResultTroopsHour, $ResultTroopsMinutes
		Local $ResultSpellsHour, $ResultSpellMinutes

		Local $ResultTroops = getRemainTrainTimer(688, 176)
		Local $ResultSpells = getRemainTrainTimer(363, 423)

		If $Troops Then SetLog(" Total time to train troop(s): " & $ResultTroops )
		If $Spells Then SetLog(" Total time to brew Spell(s): " & $ResultSpells )

		If $Troops = True Then

			If StringInStr($ResultTroops, "h") > 1 Then
				$ResultTroopsHour = StringSplit($ResultTroops, "h", $STR_NOCOUNT)
				; $ResultTroopsHour[0] will be the Hour and the $ResultTroopsHour[1] will be the Minutes with the "m" at end
				$ResultTroopsMinutes = StringTrimRight($ResultTroopsHour[1], 1) ; removing the "m"
				$aRemainTrainTroopTimer = (Number($ResultTroopsHour[0]) * 60) + Number($ResultTroopsMinutes)
			 Else
				If StringInStr($ResultTroops,"m") > 1 then
				   $aRemainTrainTroopTimer = Number(StringTrimRight($ResultTroops, 1)) ; removing the "m"
				EndIf
			 EndIf
		  EndIf

		If $Spells = True Then
			If StringInStr($ResultSpells, "h") > 1 Then
				$ResultSpellsHour = StringSplit($ResultSpells, "h", $STR_NOCOUNT)
				; $ResultSpellsHour[0] will be the Hour and the $ResultSpellsHour[1] will be the Minutes with the "m" at end
				$ResultTroopsMinutes = StringTrimRight($ResultSpellsHour[1], 1) ; removing the "m"
				$aRemainTrainSpellsTimer = (Number($ResultSpellsHour[0]) * 60) + Number($ResultTroopsMinutes)
			 Else
				If StringInStr($ResultSpells,"m") > 1 then
				   $aRemainTrainSpellsTimer = Number(StringTrimRight($ResultSpells, 1)) ; removing the "m"
				EndIf
			EndIf
		EndIf

		; Verify the higest value to return in minutes
		If $aRemainTrainTroopTimer > $aRemainTrainSpellsTimer Then
			Return $aRemainTrainTroopTimer
		Else
			Return $aRemainTrainSpellsTimer
		EndIf
	Else
		SetLog("Can not read the remaining Troops&Spells time!", $COLOR_RED)
		Return -1
	EndIf

EndFunc   ;==>RemainTrainTime