Scriptname ONE_PlaySoundOnActivate extends ObjectReference


ObjectReference Property SoundKiller auto
ObjectReference Property SourceToPlayFrom auto
Sound Property SoundToPlay

Int SoundInt 
Bool WorkOnce = False

Event OnActivate( Objectreference akActionRef)

	if !WorkOnce
		WorkOnce = True
		SoundInt = SoundToPlay.Play(SourceToPlayFrom)
	Endif
	
	If akActionRef == SoundKiller
		Sound.StopInstance(SoundInt)
	EndIf


EndEvent