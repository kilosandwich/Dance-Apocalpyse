Scriptname ONE_TranslateOnActivateThenTag extends ObjectReference

;;The purpose of this script is that on the activation of this activator an object is moved 
;;this will allow objects to be moved to invisible objects/activators that will function as points on the stage
;;that allow choreographing.


;;CHAINING NOTE:
;;This script relies on a companion script CROWD_OnTranslationCompleteTagActivator
;;That script will tag back whichever object tagged it to let it know that it has finished moving. 

;;Step 1: Create variables

ObjectReference Property ObjectToMove auto ;;this is the object that will be moved
ObjectReference Property ObjectToMoveTo auto ;; this is where the object will go
ObjectReference Property ActivateThisObjectWhenCompleted auto ;; activates this object when the specified movement has been completed, allowing chains of movement.
ObjectReference Property DONOTDOYOURJOBACTIVATOR auto 


;;GlobalVariable Property IsStuffMovingGlobalVariable auto;; this variable will prevent movement of an object being moved.

float Property TangentMagnitude auto
float Property MovementSpeed auto
float Property MaxRotationSpeed auto

Bool StopWorking = False

Event OnActivate(ObjectReference akActionRef)
	
If akActionRef == DONOTDOYOURJOBACTIVATOR
	Stopworking = True
Endif


if !StopWorking
	if akActionRef != ObjectToMove
		;;debug.messagebox("Object Will Move")
		ObjectToMove.Activate(self) ;; pings the object, which allows the object to know who to ping back
		ObjectToMove.SplineTranslateToRef(ObjectToMoveTo, TangentMagnitude, MovementSpeed ,MaxRotationSpeed )


	elseif akActionRef == ObjectToMove
		;;Debug.messagebox("Translation Done!")
		ActivateThisObjectWhenCompleted.Activate(self)	
	endif
Endif

EndEvent