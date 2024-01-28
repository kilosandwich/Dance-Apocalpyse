Scriptname ONE_CloseDoorOnActivate extends ObjectReference

ObjectReference Property Door01 auto
Sound Property SoundToPlay auto
Bool Property DoorOpen auto
Bool Workonce


Event Onactivate( ObjectReference AkObjectReference)
	if !WorkOnce
	;;	SoundToPlay.Play(Door01)
		Workonce = True
		if !DoorOpen
			Door01.SetLockLevel(254) ;;the level of an inaccessible lock
			Door01.SetOpen(DoorOpen)
			Door01.Lock() ;
		Elseif DoorOpen
			Door01.Lock(False) 
			Door01.SetLockLevel(0) 
			Door01.SetOpen(DoorOpen)

		Endif

	Endif
EndEvent