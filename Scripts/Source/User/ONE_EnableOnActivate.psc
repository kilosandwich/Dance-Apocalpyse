Scriptname ONE_EnableOnActivate extends ObjectReference

ObjectReference Property ObjectToEnable auto
ObjectReference Property ObjectToEnable02 auto
ObjectReference Property ObjectToEnable03 auto
ObjectReference Property ObjectToEnable04 auto
ObjectReference Property ObjectToEnable05 auto
ObjectReference Property ObjectToEnable06 auto
ObjectReference Property ObjectToEnable07 auto
ObjectReference Property ObjectToEnable08 auto
ObjectReference Property ObjectToEnable09 auto

ObjectReference Property DoNotDoYourJobActivator auto

Bool Property FadeIn auto
Bool Property Disable auto
Bool StopWorking = False

Event OnActivate(ObjectReference akObjectReference)

if AkObjectReference == DoNotDoYourJobActivator
	;;Debug.Messagebox("Do NOT do your job!")
	StopWorking = True
Endif



if !StopWorking
	if !Disable
		Disable = False
		ObjectToEnable.Enable(FadeIn)
		ObjectToEnable02.Enable(FadeIn)
		ObjectToEnable03.Enable(FadeIn)
		ObjectToEnable04.Enable(FadeIn)
		ObjectToEnable05.Enable(FadeIn)
		ObjectToEnable06.Enable(FadeIn)
		ObjectToEnable07.Enable(FadeIn)
		ObjectToEnable08.Enable(FadeIn)
		ObjectToEnable09.Enable(FadeIn)

	Endif

	if Disable 
		Disable = True
		ObjectToEnable.Disable(FadeIn)
		ObjectToEnable02.Disable(FadeIn)
		ObjectToEnable03.Disable(FadeIn)
		ObjectToEnable04.Disable(FadeIn)
		ObjectToEnable05.Disable(FadeIn)
		ObjectToEnable06.Disable(FadeIn)
		ObjectToEnable07.Disable(FadeIn)
		ObjectToEnable08.Disable(FadeIn)
		ObjectToEnable09.Disable(FadeIn)
	Endif
Endif

EndEvent