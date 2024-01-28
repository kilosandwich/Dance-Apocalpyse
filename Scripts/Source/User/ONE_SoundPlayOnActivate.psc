Scriptname ONE_SoundPlayOnActivate extends ObjectReference

Sound Property SoundToPlay Auto
ObjectReference Property ObjectToPlaySoundFrom Auto
ObjectReference Property ObjectToPlaySoundFrom02 Auto
ObjectReference Property ObjectToPlaySoundFrom03 Auto
ObjectReference Property SoundKiller auto
ObjectReference Property DoNotDoYourJobActivator auto
Int SoundInt
Int SoundInt02
Int SoundInt03

Bool WorkOnce 
Bool DontWork = False

Event OnActivate(ObjectReference akActionRef)

if akActionRef == DoNotDoYourJobActivator
	DontWork = True
Endif

if  !DontWork
	if !WorkOnce
		SoundInt = SoundToPlay.Play(ObjectToPlaySoundFrom)
		SoundInt02 = SoundToPlay.Play(ObjectToPlaySoundFrom02)
		SoundInt03 = SoundToPlay.Play(ObjectToPlaySoundFrom03)
	Endif
Endif

if akActionRef == SoundKiller
	Sound.StopInstance(SoundInt) 
	Sound.StopInstance(SoundInt02) 
	Sound.StopInstance(SoundInt03) 
Endif

EndEvent


