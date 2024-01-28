Scriptname ONE_OpenDoorOnActivate extends ObjectReference



ObjectReference Property Door01 auto
Sound Property SoundToPlay auto

Bool Workonce


Event Onactivate( ObjectReference AkObjectReference)
	if !WorkOnce
	;;	SoundToPlay.Play(Door01)
		Workonce = True
		Door01.Lock(false)
		Door01.SetOpen()


	Endif
EndEvent