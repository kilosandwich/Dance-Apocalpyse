Scriptname ONE_LaneController extends ObjectReference

;;this is the lane controller script, the lane controller is triggered by DANCE PRIME, the lane controller then spawns in an arrow controller for its lane type, and activates it
;;activating a spawned arrow controller triggers it to start, whereupon it manages to move the arrow from reference to reference while awaiting inputs from the input controller

Form Property SpawnThis Auto Const

ObjectReference Property DancePRIME Auto Const
ObjectReference spawnHere

Event OnActivate(ObjectReference akActionRef)
	;;Debug.messagebox("Lane Controller 3 Has Been Activated!")
	if akActionRef == DancePRIME
		;;Debug.messagebox("Lane Controller 3 is spawning an arrow controller!")
		spawnHere = PlaceAtMe(SpawnThis, 1, true, false, false) ;;DancePrime has activated the designated lane controller
		;;Debug.messagebox("Lane Controller 3 is activating the spawned arrow controller!")
		spawnHere.Activate(Game.getplayer()) ;;due to the way it is coded, if the Lane Controller activates the spawned object, it decrements the global priority. 
	Endif
EndEvent


