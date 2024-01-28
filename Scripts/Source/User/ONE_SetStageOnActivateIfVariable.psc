Scriptname ONE_SetStageOnActivateIfVariable extends ObjectReference

Quest Property QUESTTOSETSTAGE auto
GlobalVariable Property GLOBALVARIABLE01 auto
float property VALUEMUSTBE01 auto
int property STAGENUMBER auto
Bool Property PlayerOnly auto


Event OnActivate(ObjectReference akActionRef)
;;	debug.messagebox("WAS ACTIVATED")
;;
;;      Debug.messagebox("This box activated dummy thicc")
	if PlayerOnly == True 
		if akActionRef == Game.Getplayer()
		;;	Debug.Messagebox("Ey I triggered lmao")
			if GLOBALVARIABLE01.Getvalue() == VALUEMUSTBE01
 				QUESTTOSETSTAGE.SetStage(STAGENUMBER)
			Endif
		Endif
	Endif

	if PlayerOnly == false 
	;;		Debug.Messagebox("Ey I triggered lmao")
			if GLOBALVARIABLE01.Getvalue() == VALUEMUSTBE01
 				QUESTTOSETSTAGE.SetStage(STAGENUMBER)
			Endif
	Endif
EndEvent
