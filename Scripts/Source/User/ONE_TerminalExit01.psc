Scriptname ONE_TerminalExit01 extends ObjectReference

;;this script is meant to be attached to a terminal, and activate an object on activate, it should only work once since it immediately unregisters.

ObjectReference Property ObjectToActivateOnExit auto

Event OnInit()

RegisterForRemoteEvent(Game.GetPlayer(), "OnSit")
RegisterForRemoteEvent(Game.GetPlayer(), "OnGetUp")

EndEvent


Event Actor.OnGetUp(Actor akSender, ObjectReference akFurniture)

if akFurniture == self 
	ObjectToActivateOnExit.Activate(Game.Getplayer())
	UnRegisterForRemoteEvent(Game.GetPlayer(), "OnSit")
	UnRegisterForRemoteEvent(Game.GetPlayer(), "OnGetUp")
Endif

EndEvent