Scriptname ONE_ActivateOnPlayerEnter extends ObjectReference


;This script activates an objectReference when the triggerbox is entered by the player
;in the scheme of the dance machine, this should link to the changeGlobalVariableOnActivate


ObjectReference Property  activateThis auto
ObjectReference Property EnableThis auto

Event OnTriggerEnter(ObjectReference akActionRef)
	if akActionRef == Game.Getplayer()
		activateThis.Activate(Self)
		EnableThis.EnableNoWait()
	Endif
EndEvent

EVent OnTriggerLeave(ObjectReference akActionRef)
	if akActionRef == Game.Getplayer()
		EnableThis.DisableNoWait()
	Endif
EndEvent
	

