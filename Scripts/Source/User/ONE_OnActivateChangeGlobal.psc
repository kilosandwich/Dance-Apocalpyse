Scriptname ONE_OnActivateChangeGlobal extends ObjectReference

;This script changes a global variable on activate, then activates a specified object


GlobalVariable Property GlobalToChange Auto
Float Property ValueToChangeTo Auto
ObjectReference Property DancePRIME Auto


Event OnActivate(ObjectReference akActionRef)
    ;Change the value of the global variable when the object is activated.
    GlobalToChange.setValue(ValueToChangeTo)
	DancePRIME.activate(self)
   
EndEvent