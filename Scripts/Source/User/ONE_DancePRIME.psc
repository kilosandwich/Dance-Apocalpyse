Scriptname ONE_DancePRIME extends ObjectReference
;;This is the script for DancePRIME
;;Dance Prime functions by being activated by the Dance Stack
;;Dance Prime then activates the relevant lane controller, which then spawns in the arrow controller, which spawns in the arrow


GlobalVariable Property LaneToSpawn auto
ObjectReference Property LaneControllerLeft auto ;; One
ObjectReference Property LaneControllerDown auto ;;two
ObjectReference Property LaneControllerUp auto ;;three
ObjectReference Property LaneControllerRight auto ;;four
bool isWorking
Event OnActivate(ObjectReference akActionRef)
	if !IsWorking ;;preventing the spam repeat problem of OnActivate
		isWorking = True

	;;Debug.messagebox("Dance prime has been activated!")
	float Lane = LaneToSpawn.GetValue()
	LaneToSpawn.SetValue(0) ;;prevent repeat triggers
	;;Debug.messagebox("Lane To Spawn Value is:" + Lane)
	if Lane == 1
		LaneControllerLeft.Activate(Self)
		
	ElseIf Lane ==2
		LaneControllerDown.Activate(Self)

	ElseIf Lane == 3
		LaneControllerUp.Activate(Self)

	Elseif Lane == 4
		LaneControllerRight.Activate(Self)

	Endif

		isWorking = False
	Endif
EndEvent