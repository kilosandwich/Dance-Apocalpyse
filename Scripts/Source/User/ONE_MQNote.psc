Scriptname ONE_MQNote extends ObjectReference

Quest Property QUESTTOSETSTAGE auto
Int Property STAGETOSETTO auto


Event OnActivate(ObjectReference akActionRef)
;;	debug.messagebox("I WAS ACTIVATED I SWEAR")
	if akActionRef == game.getplayer()
		QUESTTOSETSTAGE.Setstage(STAGETOSETTO)	
	Endif

EndEvent

Event OnRead()
		QUESTTOSETSTAGE.Setstage(STAGETOSETTO)	
EndEvent