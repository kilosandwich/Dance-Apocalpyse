Scriptname ONE_ActivateOnActivate extends ObjectReference


ObjectReference property ObjectToActivate01 auto
ObjectReference property ObjectToActivate02 auto
GlobalVariable Property GlobalValueToCheck auto
Int Property GlobalValueMustBe auto


Event OnActivate(ObjectReference akActionRef)


	If GlobalValueToCheck.GetValueInt() == GlobalValueMustBe 
		ObjectToActivate01.Activate(ObjectToActivate01)
		ObjectToActivate02.Activate(ObjectToActivate02)
	Endif

EndEvent
