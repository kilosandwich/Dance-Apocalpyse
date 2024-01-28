Scriptname ONE_ChairScript extends ObjectReference

;;this script is meant to be attached to a chair, and activated when the player sits down, at which point it will activate an activator because 
;;I believe in compartmentalized programming

ObjectReference Property ObjectToActivateOnSit auto
GlobalVariable Property PresentationProgress auto
GlobalVariable Property PresentationGotUp auto


Event OnInit()

RegisterForRemoteEvent(Game.GetPlayer(), "OnSit")
RegisterForRemoteEvent(Game.GetPlayer(), "OnGetUp")

EndEvent


Event Actor.OnSit(Actor akSender, ObjectReference akFurniture)

if akFurniture == self 
;;debug.messagebox("Howdy partner")
	ObjectToActivateOnSit.Activate(Game.Getplayer())
	UnRegisterForRemoteEvent(Game.GetPlayer(), "OnSit")
Endif

EndEvent

Event Actor.OnGetUp(Actor akSender, ObjectReference akFurniture)

if akFurniture == self &&  PresentationProgress.GetValue() == 1
	PresentationGotUp.SetValue(1)
	UnRegisterForRemoteEvent(Game.GetPlayer(), "OnGetUp")
Endif

if  PresentationProgress.GetValue() == 2
	UnRegisterForRemoteEvent(Game.GetPlayer(), "OnGetUp")
Endif


EndEvent