Scriptname One_SetStageOnActivate extends ObjectReference



Quest Property QUESTTOSETSTAGE auto
Int Property STAGETOSETTO auto

bool WorkOnce

Event Onactivate(ObjectReference akObjectReference)
	if !WorkOnce
		WorkOnce = True
		QUESTTOSETSTAGE.SetStage(STAGETOSETTO)
	Endif



EndEvent