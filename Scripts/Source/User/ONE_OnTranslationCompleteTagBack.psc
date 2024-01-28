Scriptname ONE_OnTranslationCompleteTagBack extends ObjectReference

;;This script tags bag whatever object activated it after the translation is complete
ObjectReference ObjectThatActivatedMe


Event OnActivate(ObjectReference akActionRef)
	ObjectThatActivatedMe = akActionRef
	;;debug.messagebox("I was activated")
EndEvent

Event OnTranslationComplete()
	;;debug.messagebox("Object translation complete, activating parent activator")
 	 ObjectThatActivatedMe.Activate(self)
EndEvent