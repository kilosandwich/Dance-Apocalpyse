Scriptname ONE_OnActivateEnableThenDisable extends ObjectReference

Float Property TimeUntilDisabled Auto Const


Event OnActivate(ObjectReference akActionRef)
	Self.EnableNoWait()
	utility.wait(TimeUntilDisabled)
	Self.DisableNoWait()
EndEvent