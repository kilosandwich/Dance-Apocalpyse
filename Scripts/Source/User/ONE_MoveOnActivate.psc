Scriptname ONE_MoveOnActivate extends ObjectReference
;;The purpose of this script is that on the activation of this activator an object is moved a certain
;;distance, the point of this being that the script is able to create small movements on objects
;;that allow choreographing.




;;Step 1: Create variables

ObjectReference Property ObjectToMove auto ;;this is the object that will be moved
;;GlobalVariable Property IsStuffMovingGlobalVariable auto;; this variable will prevent movement of an object being moved.

float Property XPositionChange auto
float Property YPositionChange auto
float Property ZPositionChange auto
float Property XAngleChange auto
float Property YAngleChange auto
float Property ZAngleChange auto

float Property SplineCurveOfMovement auto
float Property MovementSpeed auto
float Property MaxRotationSpeed auto
Sound Property SoundToPlay auto
Bool Property RegularTranslate auto
Bool Property WorkMoreThanOnce auto 
Bool WorkOnce

;;Step 2: Get the initial coordinates so that the object can be moved with programmable
;;relative movement coordinates.



Event OnInit()
;;NOTE - Coordinates and positions are not gathered on intialization as objects 
;;may be moved more than once, thus making original coordinates obsolete. 

EndEvent


Event OnActivate(ObjectReference akActionRef)


if !WorkOnce
	if !WorkMoreThanOnce
		WorkOnce = True
	Endif


		SoundToPlay.Play(ObjectToMove)
		;;moves the object
	if !RegularTranslate
		ObjectToMove.SplineTranslateTo(\
			ObjectToMove.GetPositionX() + XPositionChange,\
	      		 ObjectToMove.GetPositionY()+ YPositionChange,\
			ObjectToMove.GetPositionZ() + ZPositionChange,\
			ObjectToMove.GetAngleX() + XAngleChange,\
			ObjectToMove.GetAngleY()       + YAngleChange,\
			ObjectToMove.GetAngleZ()      + ZAngleChange,\
			SplineCurveOfMovement,\
			MovementSpeed,\
			MaxRotationSpeed)
	ElseIf RegularTranslate
		ObjectToMove.SplineTranslateTo(\
			ObjectToMove.GetPositionX() + XPositionChange,\
	      		 ObjectToMove.GetPositionY() + YPositionChange,\
			ObjectToMove.GetPositionZ() + ZPositionChange,\
			ObjectToMove.GetAngleX() + XAngleChange,\
			ObjectToMove.GetAngleY() + YAngleChange,\
			ObjectToMove.GetAngleZ() + ZAngleChange,\
			MovementSpeed,\
			MaxRotationSpeed)

	Endif

Endif


EndEvent