; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GKevinOD (2014)
; Modified ......: DkEd, Hervidero (2015)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

$hGUI_ARMY = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_ATTACK)
;GUISetBkColor($COLOR_WHITE, $hGUI_ARMY)

;~ -------------------------------------------------------------
;~ Language Variables used a lot
;~ -------------------------------------------------------------

$textBoostLeft = GetTranslated(623,1, "Boosts left")

$sTxtSetPerc = GetTranslated(621,26, "Enter the No. of")
$sTxtSetPerc2 = GetTranslated(621,27, " to make.")
$sTxtSetPerc3 = GetTranslated(621,28, "Enter the No. of")
$sTxtSetSpell = GetTranslated(621,29, "Spells to make.")

$sTxtNone = GetTranslated(603,0, "None")


;~ -------------------------------------------------------------
;~ Troops Tab Main controls always visible
;~ -------------------------------------------------------------

;Local $x = 20, $y = 20
;	$grpRaidComp = GUICtrlCreateGroup(GetTranslated(621,19, "Army Strength"), $x - 20, $y - 20, 155, 55)
;		$y += 10
;		GUICtrlCreateIcon ($pIconLib, $eIcnBldgTarget, $x - 10, $y - 8, 24, 24)
;		$lblFullTroop = GUICtrlCreateLabel(GetTranslated(621,20, "'Full' Camps="),$x + 20, $y , -1, 17)
;		$txtFullTroop = GUICtrlCreateInput("100",  $x + 85, $y - 3, 30, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
;			_GUICtrlSetTip(-1, GetTranslated(621,21, "Army camps are 'Full' when reaching this %, then start attack."))
;		$lblFullTroop = GUICtrlCreateLabel("%",$x + 117, $y, -1, 17)
;			GUICtrlSetLimit(-1, 3)
;	GUICtrlCreateGroup("", -99, -99, 1, 1)


;~ -------------------------------------------------------------
;~ Troops Tab
;~ -------------------------------------------------------------

$hGUI_ARMY_TAB = GUICtrlCreateTab(0, 0, $_GUI_MAIN_WIDTH - 30, $_GUI_MAIN_HEIGHT - 255 - 30, BitOR($TCS_MULTILINE, $TCS_RIGHTJUSTIFY))
$hGUI_ARMY_TAB_ITEM1 = GUICtrlCreateTabItem(GetTranslated(600,20,"Troops"))
Local $xStart = 0, $yStart = 0

Local $x = $xStart +  25, $y = $yStart +  80 + 25 - 60
	$grpTroopComp = GUICtrlCreateGroup(GetTranslated(621,1, "Elixir Troops"), $x - 20, $y - 20, 142, 50)
		$x -= 5
		$cmbTroopComp = GUICtrlCreateCombo("", $x - 10, $y, 130, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslated(621,2, "Set the type of Army composition.") & @CRLF & GetTranslated(621,3, "'Use Barrack Mode' or 'Custom Army' for manual compositions."))
			GUICtrlSetOnEvent(-1, "cmbTroopComp")
			GUICtrlSetData(-1, GetTranslated(621,4, "Preset: Archers") &"|" & GetTranslated(621,5, "Preset: Barbarians") & "|" & GetTranslated(621,6, "Preset: Goblins") & "|" & GetTranslated(621,7, "Preset: B.Arch") & "|" &  GetTranslated(621,8, "Preset: B.A.G.G.") & "|" & GetTranslated(621,9, "Preset: B.A.Giant") & "|" & GetTranslated(621,10, "Preset: B.A.Goblin")  &"|" & GetTranslated(621,11, "Preset: B.A.G.G.Wall") & "|" & GetTranslated(621,12, "Use Barrack Mode") & "|" & GetTranslated(621,13, "Custom Army"), GetTranslated(621,13, -1))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = $xStart +  25, $y = $yStart +  75 + 25
	$grpTroops = GUICtrlCreateGroup(GetTranslated(621,14, "Troops"), $x - 20, $y - 20, 142, 95)
		$x -= 5
		$icnBarb = GUICtrlCreateIcon ($pIconLib, $eIcnBarbarian, $x - 10, $y - 5, 24, 24)
		$lblBarbarians = GUICtrlCreateLabel($sTxtBarbarians, $x + 20, $y, -1, -1)
		$txtNumBarb = GUICtrlCreateInput("50", $x + 80, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, $sTxtSetPerc & " " & $sTxtBarbarians & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentBarbarians = GUICtrlCreateLabel("x", $x + 112, $y, -1, -1)
		$y += 25
		$icnArch = GUICtrlCreateIcon ($pIconLib, $eIcnArcher, $x - 10, $y - 5, 24, 24)
		$lblArchers = GUICtrlCreateLabel($sTxtArchers, $x + 20, $y, -1, -1)
		$txtNumArch = GUICtrlCreateInput("50", $x + 80, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, $sTxtSetPerc & " " & $sTxtArchers & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentArchers = GUICtrlCreateLabel("x", $x + 112, $y, -1, -1)
		$y += 25
		$icnGobl = GUICtrlCreateIcon ($pIconLib, $eIcnGoblin, $x - 10, $y - 5, 24, 24)
		$lblGoblins = GUICtrlCreateLabel($sTxtGoblins, $x + 20, $y, -1, -1)
		$txtNumGobl = GUICtrlCreateInput("20", $x + 80, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, $sTxtSetPerc & " " & $sTxtGoblins & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblPercentGoblins = GUICtrlCreateLabel("x", $x + 112, $y, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = $xStart + 20, $y = $yStart +  75 + 25
	$grpBarrackMode = GUICtrlCreateGroup(GetTranslated(621,17, "Barrack Mode"), $x - 15, $y -20, 142, 117 )
		GUICtrlSetState(-1, $GUI_HIDE)
		$lblBarrack1 = GUICtrlCreateLabel("1:", $x - 5, $y + 5, -1, -1)
		GUICtrlSetState(-1, $GUI_HIDE)
		$cmbBarrack1 = GUICtrlCreateCombo("", $x + 10, $y, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(621,18, "Set the Troops to make in Barrack")
			_GUICtrlSetTip(-1, $txtTip & " 1.")
			GUICtrlSetData(-1,$sTxtElixirTroops, $sTxtBarbarians)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetState(-1, $GUI_HIDE)
		$y += 2
		$lblBarrack2 = GUICtrlCreateLabel("2:", $x - 5, $y + 26, -1, -1)
		GUICtrlSetState(-1, $GUI_HIDE)
		$cmbBarrack2 = GUICtrlCreateCombo("", $x + 10, $y + 21, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, $txtTip & " 2.")
			GUICtrlSetData(-1, $sTxtElixirTroops, $sTxtArchers)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetState(-1, $GUI_HIDE)
		$y += 2
		$lblBarrack3 = GUICtrlCreateLabel("3:", $x - 5, $y + 47, -1, -1)
		GUICtrlSetState(-1, $GUI_HIDE)
		$cmbBarrack3 = GUICtrlCreateCombo("", $x + 10, $y + 42, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, $txtTip & " 3.")
			GUICtrlSetData(-1, $sTxtElixirTroops, $sTxtArchers)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetState(-1, $GUI_HIDE)
		$y += 2
		$lblBarrack4 = GUICtrlCreateLabel("4:", $x - 5, $y + 68, -1, -1)
		GUICtrlSetState(-1, $GUI_HIDE)
		$cmbBarrack4 = GUICtrlCreateCombo("", $x + 10, $y + 63, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, $txtTip & " 4.")
			GUICtrlSetData(-1, $sTxtElixirTroops, $sTxtGoblins)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = $xStart +  160 + 5, $y = $yStart +  45
	$grpRaidComp = GUICtrlCreateGroup(GetTranslated(621,19, "Army Strength"), $x - 15, $y - 20, 139, 50)
		$y += 5
		GUICtrlCreateIcon ($pIconLib, $eIcnBldgTarget, $x - 10, $y - 8, 24, 24)
		$lblFullTroop = GUICtrlCreateLabel(GetTranslated(621,20, "'Full' Camps"),$x + 16, $y, 55, 17)
		$lblFullTroop2 = GUICtrlCreateLabel(ChrW(8805),$x + 75, $y, -1, 17)
		$txtFullTroop = GUICtrlCreateInput("100",  $x + 83, $y - 3, 30, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetOnEvent(-1, "SetComboTroopComp")
			_GUICtrlSetTip(-1, GetTranslated(621,21, "Army camps are 'Full' when reaching this %, then start attack."))
			GUICtrlSetLimit(-1, 3)
		$lblFullTroop3 = GUICtrlCreateLabel("%",$x + 114, $y, -1, 17)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = $xStart +  160 + 5, $y = $yStart +  75 + 25
	$grpOtherTroops = GUICtrlCreateGroup(GetTranslated(621,22, "Add. Troops"), $x - 15, $y - 20, 139, 247)
		$icnGiant = GUICtrlCreateIcon ($pIconLib, $eIcnGiant, $x - 10, $y - 5, 24, 24)
		$lblGiants = GUICtrlCreateLabel($sTxtGiants, $x + 16, $y, -1, -1)
		$txtNumGiant = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtGiants & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesGiants = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)
		$y +=25
		$icnWall = GUICtrlCreateIcon ($pIconLib, $eIcnWallBreaker, $x - 10, $y - 5, 24, 24)
		$lblWallBreakers = GUICtrlCreateLabel($sTxtWallBreakers, $x + 16, $y, -1, -1)
		$txtNumWall = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtWallBreakers & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesWallBreakers = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)
		$y +=25
		$icnBall = GUICtrlCreateIcon ($pIconLib, $eIcnBalloon, $x - 10, $y - 5, 24, 24)
		$lblBalloons = GUICtrlCreateLabel($sTxtBalloons, $x + 16, $y, -1, -1)
		$txtNumBall = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtBalloons & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesBalloons = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)
		$y +=25
		$icnWiza = GUICtrlCreateIcon ($pIconLib, $eIcnWizard, $x - 10, $y - 5, 24, 24)
		$lblWizards = GUICtrlCreateLabel($sTxtWizards, $x + 16, $y, -1, -1)
		$txtNumWiza = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtWizards & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesWizards = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)
		$y +=25
		$icnHeal = GUICtrlCreateIcon ($pIconLib, $eIcnHealer, $x - 10, $y - 5, 24, 24)
		$lblHealers = GUICtrlCreateLabel($sTxtHealers, $x + 16, $y, -1, -1)
		$txtNumHeal = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtHealers & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesHealers = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)
		$y +=25
		$icnDrag = GUICtrlCreateIcon ($pIconLib, $eIcnDragon, $x - 10, $y - 5, 24, 24)
		$lblDragons = GUICtrlCreateLabel($sTxtDragons, $x + 16, $y, -1, -1)
		$txtNumDrag = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtDragons & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesDragons = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)
		$y +=25
		$icnPekk = GUICtrlCreateIcon ($pIconLib, $eIcnPekka, $x - 10, $y - 5, 24, 24)
		$lblPekka = GUICtrlCreateLabel($sTxtPekkas, $x + 16, $y, -1, -1)
		$txtNumPekk = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtPekkas & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesPekka = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)
		$y +=25
		$icnBabyD= GUICtrlCreateIcon ($pIconLib, $eIcnBabyDragon, $x - 10, $y - 5, 24, 24)
		$lblBabyDragons = GUICtrlCreateLabel($sTxtBabyDragons, $x + 16, $y, -1, -1)
		$txtNumBabyD = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtBabyDragons & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesBabyDragons = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)
		$y +=25
		$icnMine = GUICtrlCreateIcon ($pIconLib, $eIcnMiner, $x - 10, $y - 5, 24, 24)
		$lblMine = GUICtrlCreateLabel($sTxtMiners, $x + 16, $y, -1, -1)
		$txtNumMine = GUICtrlCreateInput("0", $x + 83, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtMiners & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesMine = GUICtrlCreateLabel("x", $x + 115, $y, -1, -1)

		$y += 33
		$chkTotalCampForced = GUICtrlCreateCheckbox(GetTranslated(636,46, "Force Total Army Camp")&":", $x - 158, $y-4, -1, -1)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkTotalCampForced")
			_GUICtrlSetTip(-1, GetTranslated(636,47, "If not detected set army camp values (instead ask)"))
		$txtTotalCampForced = GUICtrlCreateInput("200", $x - 23 , $y - 2, 30, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			;GUICtrlSetBkColor($txtTotalCampForced, $COLOR_MONEYGREEN)
			GUICtrlSetOnEvent(-1, "SetComboTroopComp")
			GUICtrlSetLimit(-1, 3)
			;GUICtrlSetState(-1, $GUI_DISABLE)
		;#######################################################################;
		$caltotaltroops = GUICtrlCreateProgress($x - 159, $y + 17, 427, 10)
		$lbltotalprogress = GUICtrlCreateLabel("", $x - 158, $y + 18, 425, 8)
			GUICtrlSetBkColor (-1, $COLOR_RED)
			GUICtrlSetState(-1, BitOR($GUI_DISABLE, $GUI_HIDE))
		$lblTotalTroops = GUICtrlCreateLabel(GetTranslated(621,15, "Total"), $x + 190, $y, -1, -1, $SS_RIGHT)
		$lblTotalCount = GUICtrlCreateLabel(200, $x + 227, $y, 30, 15, $SS_CENTER)
			_GUICtrlSetTip(-1, GetTranslated(621,16, "The total Units of Troops should equal Total Army Camps."))
			GUICtrlSetBkColor (-1, $COLOR_MONEYGREEN) ;lime, moneygreen
		$lblPercentTotal = GUICtrlCreateLabel("x", $x + 260, $y, -1, -1)
		; Don't Empty Barracks Mode =======================
		$y -= 27
		$chkDontRemove = GUICtrlCreateCheckbox("Don't Empty Barracks", $x - 158, $y, -1, -1)
			$txtTip ="The bot will not remove existing troops in the barracks when training."
			_GUICtrlSetTip(-1, $txtTip)
		;#######################################################################;
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = $xStart +  160 + 148, $y = $yStart +  80 + 25 - 60
	$grpDarkTroopComp = GUICtrlCreateGroup(GetTranslated(621,23, "Dark Elixir Troops"), $x - 15, $y - 20, 140, 50)
		$cmbDarkTroopComp = GUICtrlCreateCombo("", $x - 10, $y, 125, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslated(621,2, -1) & @CRLF & GetTranslated(621,3, -1))
			GUICtrlSetOnEvent(-1, "cmbDarkTroopComp")
			GUICtrlSetData(-1,  GetTranslated(621,12, -1) & "|" &GetTranslated(621,13, -1) & "|" & $sTxtNone, GetTranslated(621,13, -1))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y = $yStart +  75 + 25
	$grpDarkTroops = GUICtrlCreateGroup(GetTranslated(621,24, "Add. Dark Troops"), $x - 15, $y - 20, 140, 200)
		$icnMini = GUICtrlCreateIcon ($pIconLib, $eIcnMinion, $x - 10, $y - 5, 24, 24)
		$lblMinion = GUICtrlCreateLabel($sTxtMinions, $x + 16, $y, -1, -1)
		$txtNumMini = GUICtrlCreateInput("0", $x + 84, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtMinions & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesMinions = GUICtrlCreateLabel("x", $x + 116, $y, -1, -1)
		$y +=25
		$icnHogs = GUICtrlCreateIcon ($pIconLib, $eIcnHogRider, $x - 10, $y - 5, 24, 24)
		$lblHogRiders = GUICtrlCreateLabel($sTxtHogRiders, $x + 16, $y, -1, -1)
		$txtNumHogs = GUICtrlCreateInput("0", $x + 84, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtHogRiders & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesHogRiders = GUICtrlCreateLabel("x", $x + 116, $y, -1, -1)
		$y +=25
		$icnValk = GUICtrlCreateIcon ($pIconLib, $eIcnValkyrie, $x - 10, $y - 5, 24, 24)
		$lblValkyries = GUICtrlCreateLabel($sTxtValkyries, $x + 16, $y, -1, -1)
		$txtNumValk = GUICtrlCreateInput("0", $x + 84, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtValkyries & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesValkyries = GUICtrlCreateLabel("x", $x + 116, $y, -1, -1)
		$y +=25
		$icnGole = GUICtrlCreateIcon ($pIconLib, $eIcnGolem, $x - 10, $y - 5, 24, 24)
		$lblGolems = GUICtrlCreateLabel($sTxtGolems, $x + 16, $y, -1, -1)
		$txtNumGole = GUICtrlCreateInput("0", $x + 84, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtGolems & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesGolems = GUICtrlCreateLabel("x", $x + 116, $y, -1, -1)
		$y +=25
		$icnWitc = GUICtrlCreateIcon ($pIconLib, $eIcnWitch, $x - 10, $y - 5, 24, 24)
		$lblWitches = GUICtrlCreateLabel($sTxtWitches, $x + 16, $y, -1, -1)
		$txtNumWitc = GUICtrlCreateInput("0", $x + 84, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtWitches & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesWitches = GUICtrlCreateLabel("x", $x + 116, $y, -1, -1)
		$y +=25
		$icnLava = GUICtrlCreateIcon ($pIconLib, $eIcnLavaHound, $x - 10, $y - 5, 24, 24)
		$lblLavaHounds = GUICtrlCreateLabel($sTxtLavaHounds, $x + 16, $y, -1, -1)
		$txtNumLava = GUICtrlCreateInput("0", $x + 84, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtLavaHounds & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesLavaHounds = GUICtrlCreateLabel("x", $x + 116, $y, -1, -1)
		$y +=25
		$icnBowl = GUICtrlCreateIcon ($pIconLib, $eIcnBowler, $x - 10, $y - 5, 24, 24)
		$lblBowlers = GUICtrlCreateLabel($sTxtBowlers, $x + 16, $y, -1, -1)
		$txtNumBowl = GUICtrlCreateInput("0", $x + 84, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtBowlers & " " & $sTxtSetPerc2)
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
		$lblTimesBowlers = GUICtrlCreateLabel("x", $x + 116, $y, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$y = $yStart +  75 + 25
	$grpDarkBarrackMode = GUICtrlCreateGroup(GetTranslated(621,25, "Dark Barracks Troops"), $x - 15, $y -20, 140, 76 )
		GUICtrlSetState(-1, $GUI_HIDE)
		$lblDarkBarrack1 = GUICtrlCreateLabel("1:", $x - 5, $y + 5, -1, -1)
		GUICtrlSetState(-1, $GUI_HIDE)
		$cmbDarkBarrack1 = GUICtrlCreateCombo("", $x + 10, $y, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(621,18, -1)
			_GUICtrlSetTip(-1, $txtTip & " 1.")
			GUICtrlSetData(-1, $sTxtMinions & "|" & $sTxtHogRiders & "|" & $sTxtValkyries & "|" & $sTxtGolems & "|" & $sTxtWitches & "|" & $sTxtLavaHounds & "|" & $sTxtBowlers & "|" & $sTxtNone, $sTxtMinions)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetState(-1, $GUI_HIDE)
		$y += 2
		$lblDarkBarrack2 = GUICtrlCreateLabel("2:", $x - 5, $y + 26, -1, -1)
		GUICtrlSetState(-1, $GUI_HIDE)
		$cmbDarkBarrack2 = GUICtrlCreateCombo("", $x + 10, $y + 21, 100, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, $txtTip & " 2.")
			GUICtrlSetData(-1, $sTxtMinions & "|" & $sTxtHogRiders & "|" & $sTxtValkyries & "|" & $sTxtGolems & "|" & $sTxtWitches & "|" & $sTxtLavaHounds & "|" & $sTxtBowlers & "|" & $sTxtNone, $sTxtMinions)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

$hGUI_ARMY_TAB_ITEM2 = GUICtrlCreateTabItem(GetTranslated(600,21,"Spells"))

Local $x = $xStart + 25, $y = $yStart +  80 + 25 - 60

	$grpSpells = GUICtrlCreateGroup(GetTranslated(622,1, "Spells Composition"), $x - 20, $y - 20, 430, 335)
		$lblTotalSpell = GUICtrlCreateLabel(GetTranslated(622,2, "Spells Capacity"), $x - 20 , $y + 4, -1, -1, $SS_RIGHT)
		$txtTotalCountSpell = GUICtrlCreateCombo("", $x + 105, $y , 35, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslated(622,3, "Enter the No. of Spells Capacity. Set to ZERO if you don't want any Spells"))
			GUICtrlSetBkColor (-1, $COLOR_MONEYGREEN) ;lime, moneygreen
			GUICtrlSetData(-1, "0|2|4|6|7|8|9|10|11", "0")
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$y += 55
		$lblLightningIcon = GUICtrlCreateIcon ($pIconLib, $eIcnLightSpell, $x - 10, $y - 5, 24, 24)
		$lblLightningSpell = GUICtrlCreateLabel($sTxtLiSpell, $x + 18, $y, -1, -1)
		$txtNumLightningSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtLiSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblTimesLightS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblHealIcon=GUICtrlCreateIcon ($pIconLib, $eIcnHealSpell, $x - 10, $y - 5, 24, 24)
		$lblHealSpell = GUICtrlCreateLabel($sTxtHeSpell, $x + 18, $y, -1, -1)
		$txtNumHealSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtHeSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblTimesHealS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblRageIcon=GUICtrlCreateIcon ($pIconLib, $eIcnRageSpell, $x - 10, $y - 5, 24, 24)
		$lblRageSpell = GUICtrlCreateLabel($sTxtRaSpell, $x + 18, $y, -1, -1)
		$txtNumRageSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtRaSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblTimesRageS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblJumpSpellIcon=GUICtrlCreateIcon ($pIconLib, $eIcnJumpSpell, $x - 10, $y - 5, 24, 24)
		$lblJumpSpell = GUICtrlCreateLabel($sTxtJuSPell, $x + 18, $y, -1, -1)
		$txtNumJumpSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtJuSPell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblTimesJumpS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblFreezeIcon=GUICtrlCreateIcon ($pIconLib, $eIcnFreezeSpell, $x - 10, $y - 5, 24, 24)
		$lblFreezeSpell = GUICtrlCreateLabel($sTxtFrSpell, $x + 18, $y, -1, -1)
		$txtNumFreezeSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtFrSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblFreezeS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblCloneIcon=GUICtrlCreateIcon ($pIconLib, $eIcnCloneSpell, $x - 10, $y - 5, 24, 24)
		$lblCloneSpell = GUICtrlCreateLabel($sTxtClSpell, $x + 18, $y, -1, -1)
		$txtNumCloneSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtClSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblCloneS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblPoisonIcon = GUICtrlCreateIcon ($pIconLib, $eIcnPoisonSpell, $x - 10, $y - 5, 24, 24)
		$lblPoisonSpell = GUICtrlCreateLabel($sTxtPoSpell, $x + 18, $y, -1, -1)
		$txtNumPoisonSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtPoSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblTimesPoisonS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblEarthquakeIcon = GUICtrlCreateIcon ($pIconLib, $eIcnEarthquakeSpell, $x - 10, $y - 5, 24, 24)
		$lblEarthquakeSpell = GUICtrlCreateLabel($sTxtEaSpell, $x + 18, $y, -1, -1)
		$txtNumEarthSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtEaSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblTimesEarthquakeS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblHasteIcon = GUICtrlCreateIcon ($pIconLib, $eIcnHasteSpell, $x - 10, $y - 5, 24, 24)
		$lblHasteSpell = GUICtrlCreateLabel($sTxtHaSpell, $x + 18, $y, -1, -1)
		$txtNumHasteSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtHaSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblTimesHasteS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
		$y +=25
		$lblSkeletonIcon = GUICtrlCreateIcon ($pIconLib, $eIcnSkeletonSpell, $x - 10, $y - 5, 24, 24)
		$lblSkeletonSpell = GUICtrlCreateLabel($sTxtSkSpell, $x + 18, $y, -1, -1)
		$txtNumSkeletonSpell = GUICtrlCreateInput("0", $x + 105, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			_GUICtrlSetTip(-1, $sTxtSetPerc3 & " " & $sTxtSkSpell & " " & $sTxtSetSpell)
			GUICtrlSetLimit(-1, 2)
			;GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "lblTotalCountSpell")
		$lblTimesSkeletonS = GUICtrlCreateLabel("x", $x + 137, $y, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	;====================== Spell Barrack Mode ======================
	$x = 265
	$y = 313
	$grpMods = GUICtrlCreateGroup("Spells Training Options", $x - 20, $y + 2, 182, 40)
		$y +=18
		$chkBarrackSpell = GUICtrlCreateCheckbox("Spell Barrack Mode", $x - 10, $y, -1, -1)
			$txtTip ="Train spells continuously in barrack mode (Lightning, Heal, and Rage only)."
			_GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

$hGUI_ARMY_TAB_ITEM3 = GUICtrlCreateTabItem(GetTranslated(600,22,"Boost"))

Global $chkBoostBarracksHours
Global $chkBoostBarracksHours0, $chkBoostBarracksHours1, $chkBoostBarracksHours2, $chkBoostBarracksHours3, $chkBoostBarracksHours4, $chkBoostBarracksHours5
Global $chkBoostBarracksHours6, $chkBoostBarracksHours7, $chkBoostBarracksHours8, $chkBoostBarracksHours9, $chkBoostBarracksHours10, $chkBoostBarracksHours11
Global $chkBoostBarracksHours12, $chkBoostBarracksHours13, $chkBoostBarracksHours14, $chkBoostBarracksHours15, $chkBoostBarracksHours16, $chkBoostBarracksHours17
Global $chkBoostBarracksHours18, $chkBoostBarracksHours19, $chkBoostBarracksHours20, $chkBoostBarracksHours21, $chkBoostBarracksHours22, $chkBoostBarracksHours23
Global $lbBoostBarracksHours1, $lbBoostBarracksHours2, $lbBoostBarracksHours3, $lbBoostBarracksHours4, $lbBoostBarracksHours5, $lbBoostBarracksHours6
Global $lbBoostBarracksHours7, $lbBoostBarracksHours8, $lbBoostBarracksHours9, $lbBoostBarracksHours10, $lbBoostBarracksHours11, $lbBoostBarracksHours12
Global $lbBoostBarracksHoursED, $lbBoostBarracksHoursPM, $lbBoostBarracksHoursAM, $chkBoostBarracksHoursE1, $chkBoostBarracksHoursE2

Global $tabBoost, $tabBoostOptions, $grpBoosterOptions
Global $lblQuantBoostBarracks, $cmbQuantBoostBarracks, $cmbBoostBarracks

Global $lblQuantBoostDarkBarracks, $cmbQuantBoostDarkBarracks, $cmbBoostDarkBarracks	; DARK Barrackses

Global $lblBoostSpellFactory, $cmbBoostSpellFactory, $lblBoostDarkSpellFactory, $cmbBoostDarkSpellFactory
Global $lblBoostBarbarianKing, $cmbBoostBarbarianKing, $lblBoostArcherQueen, $cmbBoostArcherQueen
Global $lblBoostWarden, $cmbBoostWarden

Local $x = $xStart + 25, $y = $yStart +  45
	$grpBoosterBarracks = GUICtrlCreateGroup(GetTranslated(623,2, "Boost Barracks"), $x - 20, $y - 20, 430, 70)
		GUICtrlCreateIcon ($pIconLib, $eIcnBarrackBoost, $x - 10, $y - 2, 24, 24)
		$lblQuantBoostBarracks = GUICtrlCreateLabel(GetTranslated(623,3, "Num. Of Barracks to Boost"), $x + 20, $y + 4 , -1, -1)
		$txtTip = GetTranslated(623,4, "How many Barracks to boost with GEMS! Use with caution!")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbQuantBoostBarracks = GUICtrlCreateCombo("", $x + 160, $y, 37, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2|3|4", "0")
			_GUICtrlSetTip(-1, $txtTip)
		;########################## START DARK Barrackses ##########################
		GUICtrlCreateIcon ($pIconLib, $eIcnDarkBarrackBoost, $x + 207, $y - 2, 24, 24)
		$lblQuantBoostDarkBarracks = GUICtrlCreateLabel("Dark Barracks to Boost", $x + 237, $y + 4 , -1, -1)
		$txtTip = "How many Dark Barracks to boost with GEMS! Use with caution!"
			_GUICtrlSetTip(-1, $txtTip)
		$cmbQuantBoostDarkBarracks = GUICtrlCreateCombo("", $x + 365, $y, 37, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2", "0")
			_GUICtrlSetTip(-1, $txtTip)
		;########################## END DARK Barrackses ##########################
		$lblBoostBarracks = GUICtrlCreateLabel(GetTranslated(623,5,"Barracks") & " "&$textBoostLeft, $x + 20, $y + 27, -1, -1)
		$txtTip = GetTranslated(623,6, "Use this to boost your Barracks with GEMS! Use with caution!")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbBoostBarracks = GUICtrlCreateCombo("", $x + 160, $y + 23 , 37, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12", "0")
			_GUICtrlSetTip(-1, $txtTip)
		;########################## START DARK Barrackses ##########################
		$lblBoostDarkBarracks = GUICtrlCreateLabel("Dark Barracks" & " " & $textBoostLeft, $x + 237, $y + 27 , -1, -1)
		$txtTip = "Use this to boost your Dark Barracks with GEMS! Use with caution!"
			_GUICtrlSetTip(-1, $txtTip)
		$cmbBoostDarkBarracks = GUICtrlCreateCombo("", $x + 365, $y + 23, 37, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12", "0")
			_GUICtrlSetTip(-1, $txtTip)
		;########################## END DARK Barrackses ##########################
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 75
	$grpBoosterSpellFactories = GUICtrlCreateGroup(GetTranslated(623,7,"Boost Spell Factories"), $x - 20, $y - 20, 430, 70)
		GUICtrlCreateIcon ($pIconLib, $eIcnSpellFactoryBoost, $x - 10, $y - 2, 24, 24)
		$lblBoostSpellFactory = GUICtrlCreateLabel(GetTranslated(623,8,"Spell Factory") & " "&$textBoostLeft, $x + 20, $y + 4, -1, -1)
		$txtTip = GetTranslated(623,9, "Use this to boost your Spell Factory with GEMS! Use with caution!")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbBoostSpellFactory = GUICtrlCreateCombo("", $x + 200, $y, 30, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12", "0")
			_GUICtrlSetTip(-1, $txtTip)
 	$y += 25
		GUICtrlCreateIcon ($pIconLib, $eIcnDarkSpellBoost, $x - 10, $y - 2, 24, 24)
		$lblBoostDarkSpellFactory = GUICtrlCreateLabel(GetTranslated(623,10,"Dark Spell Factory") & " "&$textBoostLeft, $x + 20, $y + 4, -1, -1)
		$txtTip = GetTranslated(623,11, "Use this to boost your Dark Spell Factory with GEMS! Use with caution!")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbBoostDarkSpellFactory = GUICtrlCreateCombo("", $x + 200, $y, 30, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12", "0")
			_GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 50
	$grpBoosterHeroes = GUICtrlCreateGroup(GetTranslated(623,12,"Boost Heroes"), $x - 20, $y - 20, 430, 95)
		GUICtrlCreateIcon ($pIconLib, $eIcnKingBoost, $x - 10, $y - 2, 24, 24)
		$lblBoostBarbarianKing = GUICtrlCreateLabel(GetTranslated(623,13,"Barbarian King" ) & " "&$textBoostLeft, $x + 20, $y + 4, -1, -1)
 		$txtTip = GetTranslated(623,14, "Use this to boost your Barbarian King with GEMS! Use with caution!")
			_GUICtrlSetTip(-1, $txtTip)
		$cmbBoostBarbarianKing = GUICtrlCreateCombo("", $x + 200, $y, 30, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12", "0")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkUpgradeKing")
 	$y += 25
		GUICtrlCreateIcon ($pIconLib, $eIcnQueenBoost, $x - 10, $y - 2, 24, 24)
		$lblBoostArcherQueen = GUICtrlCreateLabel(GetTranslated(623,15,"Archer Queen") & " " &$textBoostLeft, $x + 20, $y + 4, -1, -1)
 		$txtTip = GetTranslated(623,16, "Use this to boost your Archer Queen with GEMS! Use with caution!")
 		_GUICtrlSetTip(-1, $txtTip)
		$cmbBoostArcherQueen = GUICtrlCreateCombo("", $x + 200, $y, 30, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12", "0")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkUpgradeQueen")
 	$y += 25
		GUICtrlCreateIcon ($pIconLib, $eIcnWardenBoost, $x - 10, $y - 2, 24, 24)
		$lblBoostWarden = GUICtrlCreateLabel(GetTranslated(623,17,"Grand Warden") & " "&$textBoostLeft, $x + 20, $y + 4, -1, -1)
 		$txtTip = GetTranslated(623,18, "Use this to boost your Grand Warden with GEMS! Use with caution!")
 		_GUICtrlSetTip(-1, $txtTip)
		$cmbBoostWarden = GUICtrlCreateCombo("", $x + 200, $y, 30, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12", "0")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkUpgradeWarden")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
$y += 60
	$grpBoosterSchedule = GUICtrlCreateGroup(GetTranslated(623,19,"Boost Schedule"), $x - 20, $y - 20, 430, 70)

	$lbBoostBarracksHours1 = GUICtrlCreateLabel(" 0", $x + 30, $y)
	$lbBoostBarracksHours2 = GUICtrlCreateLabel(" 1", $x + 45, $y)
	$lbBoostBarracksHours3 = GUICtrlCreateLabel(" 2", $x + 60, $y)
	$lbBoostBarracksHours4 = GUICtrlCreateLabel(" 3", $x + 75, $y)
	$lbBoostBarracksHours5 = GUICtrlCreateLabel(" 4", $x + 90, $y)
	$lbBoostBarracksHours6 = GUICtrlCreateLabel(" 5", $x + 105, $y)
	$lbBoostBarracksHours7 = GUICtrlCreateLabel(" 6", $x + 120, $y)
	$lbBoostBarracksHours8 = GUICtrlCreateLabel(" 7", $x + 135, $y)
	$lbBoostBarracksHours9 = GUICtrlCreateLabel(" 8", $x + 150, $y)
	$lbBoostBarracksHours10 = GUICtrlCreateLabel(" 9", $x + 165, $y)
	$lbBoostBarracksHours11 = GUICtrlCreateLabel("10", $x + 180, $y)
	$lbBoostBarracksHours12 = GUICtrlCreateLabel("11", $x + 195, $y)
	$lbBoostBarracksHoursED = GUICtrlCreateLabel("X", $x + 213, $y+2, 11, 11)
	$y += 15
	$chkBoostBarracksHours0 = GUICtrlCreateCheckbox("", $x + 30, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours1 = GUICtrlCreateCheckbox("", $x + 45, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours2 = GUICtrlCreateCheckbox("", $x + 60, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours3 = GUICtrlCreateCheckbox("", $x + 75, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours4 = GUICtrlCreateCheckbox("", $x + 90, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours5 = GUICtrlCreateCheckbox("", $x + 105, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours6 = GUICtrlCreateCheckbox("", $x + 120, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours7 = GUICtrlCreateCheckbox("", $x + 135, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours8 = GUICtrlCreateCheckbox("", $x + 150, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours9 = GUICtrlCreateCheckbox("", $x + 165, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours10 = GUICtrlCreateCheckbox("", $x + 180, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours11 = GUICtrlCreateCheckbox("", $x + 195, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHoursE1 = GUICtrlCreateCheckbox("", $x + 211, $y+1, 13, 13, BitOR($BS_PUSHLIKE, $BS_ICON))
	GUICtrlSetImage(-1, $pIconLib, $eIcnGoldStar, 0)
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	$txtTip = GetTranslated(603,2, "This button will clear or set the entire row of boxes")
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkBoostBarracksHoursE1")
	$lbBoostBarracksHoursAM = GUICtrlCreateLabel(GetTranslated(603,3, "AM"), $x + 5, $y)
	$y += 15
	$chkBoostBarracksHours12 = GUICtrlCreateCheckbox("", $x + 30, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours13 = GUICtrlCreateCheckbox("", $x + 45, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours14 = GUICtrlCreateCheckbox("", $x + 60, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours15 = GUICtrlCreateCheckbox("", $x + 75, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours16 = GUICtrlCreateCheckbox("", $x + 90, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours17 = GUICtrlCreateCheckbox("", $x + 105, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours18 = GUICtrlCreateCheckbox("", $x + 120, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours19 = GUICtrlCreateCheckbox("", $x + 135, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours20 = GUICtrlCreateCheckbox("", $x + 150, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours21 = GUICtrlCreateCheckbox("", $x + 165, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours22 = GUICtrlCreateCheckbox("", $x + 180, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHours23 = GUICtrlCreateCheckbox("", $x + 195, $y, 15, 15)
	GUICtrlSetState(-1, $GUI_CHECKED )
	$chkBoostBarracksHoursE2 = GUICtrlCreateCheckbox("", $x + 211, $y+1, 13, 13, BitOR($BS_PUSHLIKE, $BS_ICON))
	GUICtrlSetImage(-1, $pIconLib, $eIcnGoldStar, 0)
	GUICtrlSetState(-1, $GUI_UNCHECKED )
	$txtTip = GetTranslated(603,2, -1)
	_GUICtrlSetTip(-1, $txtTip)
	GUICtrlSetOnEvent(-1, "chkBoostBarracksHoursE2")
	$lbBoostBarracksHoursPM = GUICtrlCreateLabel(GetTranslated(603,4, "PM"), $x + 5, $y)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

$hGUI_ARMY_TAB_ITEM4 = GUICtrlCreateTabItem(GetTranslated(641,1,"Options"))
	$x = $xStart + 25
	$y = $yStart + 45
	$grpCloseWaitTrain = GUICtrlCreateGroup(GetTranslated(641, 2, "Training Idle Time"), $x - 20, $y - 20, 151, 215)
		;
		$chkCloseWaitEnable = GUICtrlCreateCheckbox(GetTranslated(641, 3, "Close While Training"),$x - 12, $y, 140, -1)
			$txtTip = GetTranslated(641, 4, "Option will exit CoC game for time required to complete TROOP training when SHIELD IS ACTIVE")& @CRLF & _
			GetTranslated(641, 5, "Close for Spell creation will be enabled when 'Wait for Spells' is selected on Search tabs")  & @CRLF & _
			GetTranslated(641, 6, "Close for Hero healing will be enabled when 'Wait for Heroes' is enabled on Search tabs")
			GUICtrlSetState(-1, $GUI_CHECKED)
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkCloseWaitEnable")
	$y +=	28
		$chkCloseWaitTrain = GUICtrlCreateCheckbox(GetTranslated(641, 7, "Without Shield"),$x + 18, $y+1, 110, -1)
			$txtTip = GetTranslated(641, 8, "Option will ALWAYS close CoC for idle training time and when NO SHIELD IS ACTIVE!") & @CRLF & _
				GetTranslated(641, 9, "Note - You can be attacked and lose trophies when this option is enabled!")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkCloseWaitTrain")
		$picCloseWaitTrain = GUICtrlCreateIcon ($pIconLib, $eIcnNoShield, $x-13, $y, 24, 24)
			_GUICtrlSetTip(-1, $txtTip)
	$y +=	28
		$btnCloseWaitStop = GUICtrlCreateCheckbox(GetTranslated(641,13, "Close Emulator"),$x + 18, $y+1, 110, -1)
			$txtTip = GetTranslated(641,14, "Option will close Android Emulator completely when selected")& @CRLF & _
			GetTranslated(641,15, "Adding this option may increase offline time slightly due to variable times required for startup")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "btnCloseWaitStop")
		$picCloseWaitStop = GUICtrlCreateIcon ($pIconLib, $eIcnRecycle, $x-13, $y+13, 24, 24)
			_GUICtrlSetTip(-1, $txtTip)
	$y +=	28
		$btnCloseWaitStopRandom = GUICtrlCreateCheckbox(GetTranslated(641,10, "Random Close"),$x + 18, $y+1, 110, -1)
			$txtTip = GetTranslated(641,11, "Option will Randomly choose between time out, close CoC, or Close emulator when selected")& @CRLF & _
			GetTranslated(641,15, "Adding this option may increase offline time slightly due to variable times required for startup")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "btnCloseWaitStopRandom")
	$y +=	28
		$btnCloseWaitExact = GUICtrlCreateRadio(GetTranslated(641,16, "Exact Time"),$x + 18, $y+1, 110, -1)
			$txtTip = GetTranslated(641,17, "Select to wait exact time required for troops to complete training")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "btnCloseWaitRandom")
		$picCloseWaitExact = GUICtrlCreateIcon ($pIconLib, $eIcnHourGlass, $x-13, $y + 13, 24, 24)
			$txtTip = GetTranslated(641,18, "Select how much time to wait when feature enables")
			_GUICtrlSetTip(-1, $txtTip)
	$y +=	24
		$btnCloseWaitRandom = GUICtrlCreateRadio(GetTranslated(641,19, "Random Time"), $x + 18, $y+1, 110, -1)
			$txtTip = GetTranslated(641,20, "Select to ADD a random extra wait time like human who forgets to clash")
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "btnCloseWaitRandom")
	$y +=	28
		$cmbCloseWaitRdmPercent = GUICtrlCreateCombo("", $x + 36, $y, 40, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = GetTranslated(641,21, "Enter maximum percentage of additional time to be used creating random wait times,") & @CRLF & _
			GetTranslated(641,22,"Bot will compute a random wait time between exact time needed, and") & @CRLF & _
			GetTranslated(641,23,"maximum random percent entered to appear more human like")
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10|11|12|13|14|15", "10")
			_GUICtrlSetTip(-1, $txtTip)
		$lblCloseWaitRdmPercent = GUICtrlCreateLabel("%",$x + 84, $y+3, -1, 18)
		_GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += 53
	$grpTiming = GUICtrlCreateGroup(GetTranslated(636,30, "Train Click Timing"), $x - 20, $y - 20, 151, 60)
		$lbltxtTrainITDelay = GUICtrlCreateLabel(GetTranslated(636,32, "delay"), $x-10, $y, 37, 30)
			$txtTip = GetTranslated(636,33, "Increase the delay if your PC is slow or to create human like training click speed")
			_GUICtrlSetTip(-1, $txtTip)
		$lbltxtTrainITDelayTime = GUICtrlCreateLabel("25 ms", $x-10, $y+15, 37, 30)
			_GUICtrlSetTip(-1, $txtTip)
		$sldTrainITDelay = GUICtrlCreateSlider($x + 30, $y, 90, 25, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS))
			_GUICtrlSetTip(-1, GetTranslated(636,33, -1))
			_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
			_GUICtrlSlider_SetTicFreq(-100, 100)
			GUICtrlSetLimit(-1, 500, 1) ; change max/min value
			GUICtrlSetData(-1, 25) ; default value
			GUICtrlSetOnEvent(-1, "sldTrainITDelay")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

$x = $xStart + 182
$y = $yStart + 45
	$grpTrainOrder = GUICtrlCreateGroup(GetTranslated(641, 25, "Training Order"), $x - 20, $y - 20, 271, 335)
		$chkTroopOrder = GUICtrlCreateCheckbox(GetTranslated(641, 26, "Custom Elixir Order"),$x - 5, $y, -1, -1)
			$txtTip = GetTranslated(641, 27, "Enable to select a custom elixir troop training order") & @CRLF & _
			GetTranslated(641, 28, "Changing train order can be useful with CSV scripted attack armies!")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			_GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkTroopOrder2")

	Local $sComboData = ""
	; Do Not Use translated names here or ChangeTroopTrainOrder() code breaks
	Local $aTroopOrderList[13] = [ "", "Barbarians", "Archers", "Giants", "Goblins", "Wall Breakers", "Balloons", "Wizards", "Healers", "Dragons", "Pekkas", "Baby Dragons", "Miners"]

	; Create translated list of Troops for combo box
	For $j = 0 To UBound($aTroopOrderList) - 1
		$sComboData &= $aTroopOrderList[$j] & "|"
	Next
	Local $txtTroopOrder = GetTranslated(641, 29, "Enter sequence order for training of troop #")

	; Create ComboBox(es) for selection of troop training order
$y += 23
	For $z = 0 To UBound($aTroopOrderList) - 2
		$lblTroopOrder[$z] = GUICtrlCreateLabel($z+1 & ":" , $x-16, $y+2, -1, 18)
		$cmbTroopOrder[$z] = GUICtrlCreateCombo("", $x+4, $y, 94, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetOnEvent(-1, "GUITrainOrder")
		GUICtrlSetData(-1, $sComboData, "")
		_GUICtrlSetTip(-1, $txtTroopOrder & $z+1)
		GUICtrlSetState(-1, $GUI_DISABLE)
		$ImgTroopOrder[$z] = GUICtrlCreateIcon ($pIconLib, $eIcnOptions, $x + 100, $y+1, 18, 18)
		$y += 22 ; move down to next combobox location
	Next
$y = $yStart + 45 + 291
	; Create push button to set training order once completed
	$btnTroopOrderSet = GUICtrlCreateButton(GetTranslated(641, 30, "Apply New Order"),$x+2, $y, 92, 20)
		$txtTip = GetTranslated(641, 31, "Push button when finished selecting custom troop training order")& @CRLF & _
		GetTranslated(641, 32, "Icon changes color based on status: Red= Not Set, Green = Order Set")
		GUICtrlSetState(-1, BitOR($GUI_UNCHECKED, $GUI_DISABLE))
		_GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnTroopOrderSet")
	$ImgTroopOrderSet = GUICtrlCreateIcon ($pIconLib, $eIcnSilverStar, $x + 100, $y+2, 18, 18)
;Add custom dark troop train order soon
$x += 128
$y = $yStart + 45
	$chkDarkTroopOrder = GUICtrlCreateCheckbox(GetTranslated(641, 33, "Custom Dark Order"),$x - 5, $y, -1, -1)
		$txtTip = GetTranslated(641, 34, "Enable to select a custom dark troop training order") & @CRLF & _
		GetTranslated(641, 28, "Changing train order can be useful with CSV scripted attack armies!")
		GUICtrlSetState(-1, $GUI_UNCHECKED)
		_GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "chkDarkTroopOrder2")

	Local $sComboData = ""
	; Do Not Use translated names here or ChangeDarkTroopTrainOrder()code breaks
	Local $aDarkTroopOrderList[8] = [ "", "Minions", "Hog Riders", "Valkyries", "Golems", "Witches", "Lava Hounds", "Bowlers"]

	; Create translated list of Troops for combo box
	For $j = 0 To UBound($aDarkTroopOrderList) - 1
		$sComboData &= $aDarkTroopOrderList[$j] & "|"
	Next

	; Create ComboBox(es) for selection of dark troop training order
$y += 23
	For $z = 0 To UBound($aDarkTroopOrderList) - 2
		$cmbDarkTroopOrder[$z] = GUICtrlCreateCombo("", $x+4, $y, 92, 18, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetOnEvent(-1, "GUITrainDarkOrder")
		GUICtrlSetData(-1, $sComboData, "")
		_GUICtrlSetTip(-1, $txtTroopOrder & $z+1)
		GUICtrlSetState(-1, $GUI_DISABLE)
		$ImgDarkTroopOrder[$z] = GUICtrlCreateIcon ($pIconLib, $eIcnOptions, $x + 98, $y+1, 18, 18)
		$y += 22 ; move down to next combobox location
	Next

$y = $yStart + 45 + 184
	; Create push button to set training order once completed
	$btnDarkTroopOrderSet = GUICtrlCreateButton(GetTranslated(641, 30, "Apply New Order"),$x+2, $y, 92, 20)
		$txtTip = GetTranslated(641, 31, "Push button when finished selecting custom troop training order")& @CRLF & _
		GetTranslated(641, 32, "Icon changes color based on status: Red= Not Set, Green = Order Set")
		GUICtrlSetState(-1, BitOR($GUI_UNCHECKED, $GUI_DISABLE))
		_GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnDarkTroopOrderSet")
	$ImgDarkTroopOrderSet = GUICtrlCreateIcon ($pIconLib, $eIcnSilverStar, $x + 98, $y+1, 18, 18)

	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")