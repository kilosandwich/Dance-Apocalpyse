Scriptname ONE_TVScript extends ObjectReference

ObjectReference property SomePowerNeedingWorkshopObjectRef auto

bool WorkOnce
bool property SetOpenFalse auto

Event OnActivate(ObjectReference akActionRef)

	if !Workonce
		WorkOnce = True
		SomePowerNeedingWorkshopObjectRef.PlayAnimation("Reset") ; Reset animation to unpowered state
		SomePowerNeedingWorkshopObjectRef.PlayAnimation("Powered")
		SomePowerNeedingWorkshopObjectRef.OnPowerOn(Self)
		SomePowerNeedingWorkshopObjectRef.Activate(Self)

		if SetOpenFalse == True
			SomePowerNeedingWorkshopObjectRef.SetOpen(False)
		Endif
	Endif


EndEvent