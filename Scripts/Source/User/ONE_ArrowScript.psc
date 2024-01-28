Scriptname ONE_ArrowScript extends ObjectReference

;;This represents the type of object to be spawned in.
Form Property ArrowToMove Auto

GlobalVariable Property SpeedGlobal auto

;;This represents the input for the direction
ObjectReference Property InputController auto

;;This represents the lane controller
ObjectReference Property LaneController auto
GlobalVariable Property InitialPriority auto ;;this represents the initial created priority of the Arrow script when it is created. 
float priority;; this represents the priority of the arrowscript it currently possesses. 

;;this represents the score controller
ObjectReference Property ScoreController auto ;;this is the score controller, it will handle the scoring so that the arrow script doesn't have to.
GlobalVariable Property ScoreToSend auto ;;this is the global variable to be sent to the score controller, the score controller will set this to zero after it has processed it


;This represents the 9 points the arrow will be moved to.
ObjectReference Property zMarker01 auto
ObjectReference Property zMarker02 auto
ObjectReference Property zMarker03 auto
ObjectReference Property zMarker04 auto
ObjectReference Property zMarker05 auto
ObjectReference Property zMarker06 auto
ObjectReference Property zMarker07 auto
ObjectReference Property zMarker08 auto
ObjectReference Property zMarker09 auto

float SpeedMove  ;;the speed the object is moving at.
float Property SpeedRotate auto ;;the speed the object is rotating at.

;These might not be relevant
Explosion Property ExplosionToPlace auto
GlobalVariable Property GoodGuysShot auto
GlobalVariable Property BadGuysShot auto
GlobalVariable Property BadGuysNOTshot auto

;This probably also isn't relevant
Sound Property zSoundGood auto
Sound Property zSoundBad auto


float Progress ;;this represents the progress that has been made by the object being moved. 

;;0 = Object moving from initially spawned position to position 01 MISS
;;1 = Object moving from position 01 to position 02 - this represents the OK target
;;2 = this represents the GOOD target range
;;3 = this represents the GREAT target range
;;4 = This represents the PERFECT target range
;;5+ = MISS!!!!

float xpos 
float ypos
float zpos
float xang
float yang
float zang

bool Property GoodGuy auto
bool WasShot


;The controllerobject for the arrow has activated, ideally it should then spawn in a new object and use it as the reference.

;;have to define the variable so it can be used
ObjectReference ObjectToMove 


Function SplineTranslate(ObjectReference ObjectToMoveAround, ObjectReference MoveHere)
	ObjectToMoveAround.SplineTranslateTo(\
		ObjectToMoveAround.GetPositionX(),\
		ObjectToMoveAround.GetPositionY(),\
		MoveHere.GetPositionZ(),\
		ObjectToMoveAround.GetAngleX(),\
		ObjectToMoveAround.GetAngleY(),\
		ObjectToMoveAround.GetAngleZ(),\
		0.00,\
		SpeedMove,\
		SpeedRotate)
		
EndFunction

Event OnActivate(ObjectReference akActionRef)
		SpeedMove = SpeedGlobal.GetValue()
		if akActionRef == InputController
			;;Debug.messagebox("Checking to see if input controller matches!")
			doesInputMatch()
		Else
			priority = InitialPriority.GetValue()
			InitialPriority.SetValue(InitialPriority.GetValue() +1) ;indicate that the lane is occupied by increasing the priority. 
			;;Debug.messagebox("Arrow controller is attempting to spawn arrow!")
			ObjectToMove = PlaceAtMe(ArrowToMove, 1,false, false)	;;create the object we are trying to use
			RegisterForRemoteEvent(ObjectToMove, "OnTranslationComplete") ;;this registers us for all remote events for the object we are moving.
			RegisterForRemoteEvent(LaneController, "OnActivate") ;;register for the lane controller getting activated
			RegisterForRemoteEvent(InputController,"OnActivate")
			Progress = 0
			ObjectToMove.EnableNoWait()
			ObjectToMove.MoveTo(Self)
			Progress = 1
			;;ObjectToMove.SetPosition(xpos, ypos, zpos)
			;;ObjectToMove.SetAngle(xang, yang, zang)
			;;Debug.messagebox("Arrow controller is attempting to move arrow to the first point!")



			;ObjectToMove.SplineTranslateTo(zMarker01.GetPositionX(),
	
			SplineTranslate(ObjectToMove,zMarker06)




		Endif

		
		
EndEvent

;;when the lane controller is activated, decrease local priority
Event ObjectReference.OnActivate(ObjectReference akSender,ObjectReference akActionRef)
	if akSender == LaneController
		;;Debug.messagebox("Decreasing priority because signal recieved")
		priority = priority -1
	Elseif akSender == InputController
		;;Debug.messagebox("Checking to see if input controller matches!")
		doesInputMatch()
	Endif
		
EndEvent



Bool OneAtATime 

Bool Function IsBetweenZ(ObjectReference z1, ObjectReference z2, ObjectReference z3)
	if ((z1.GetPositionZ() < z2.GetPositionZ()) && (z2.GetPositionZ() <z3.GetPositionZ()))
		return True
	Else
		return False
	Endif
EndFunction



Function doesInputMatch()
;;the purpose of this function is to check if the declared input for the lane matches the location of an object within the lane.
	;;Debug.messagebox("Does input Match Function running")
	;;Debug.messagebox("Priority is "+priority)
	if priority < 1 ;;only run the function if the priority matches
		;;Debug.messagebox("attempting to send score")

		if( IsBetweenZ(Self,ObjectToMove,zMarker01) )
 			ScoreToSend.SetValue(0) ;;trigger the score controller with 0 MISS
			ScoreController.Activate(self)
		Elseif( IsBetweenZ(zMarker01,ObjectToMove,zMarker02) )
 			ScoreToSend.SetValue(1) ;;trigger the score controller with 1 OK
			ScoreController.Activate(self)
			UsedUp()
		Elseif( IsBetweenZ(zMarker02,ObjectToMove,zMarker03) )
			 ScoreToSend.SetValue(2) ;;trigger the score controller with 2 GOOD
			ScoreController.Activate(self)
			UsedUp()
		Elseif( IsBetweenZ(zMarker03,ObjectToMove,zMarker04) )
			 ScoreToSend.SetValue(3) ;;trigger the score controller with 3 GREAT
			ScoreController.Activate(self)
			UsedUp()
		Elseif( IsBetweenZ(zMarker04,ObjectToMove,zMarker05) )
			 ScoreToSend.SetValue(4) ;;trigger the score controller with 4 IS PERFECT
			ScoreController.Activate(self)
			UsedUp()
		Elseif( IsBetweenZ(zMarker05,ObjectToMove,zMarker06) )
			 ScoreToSend.SetValue(0) ;;trigger the score controller with 4 IS PERFECT
			ScoreController.Activate(self)
			UsedUp()


		Endif
	Endif


EndFunction


Function UsedUp()
	Priority = 999
	InitialPriority.SetValue(InitialPriority.GetValue() -1) ;;tell the lane there is one less object in the lane. 
	LaneController.activate(Game.Getplayer()) ;;this tags the lane controller, which the object being registered to detect this event, decrements internal priority, which tells every object in the lane to decrease its priority.
	UnregisterForRemoteEvent(ObjectToMove, "OnTranslationComplete") ;;this unregisters us for all remote events for the object we are moving.
	UnRegisterForRemoteEvent(LaneController, "OnActivate") ;;register for the lane controller getting activated
	UnRegisterForRemoteEvent(InputController,"OnActivate")
EndFunction


Event ObjectReference.OnTranslationComplete(ObjectReference akSource)

if akSource == ObjectToMove
	;;if Progress == 1 && !OneAtATime
		;;Debug.messagebox("Moved to first point successfully, moving to second point!")
		;;OneAtATime = True
		;;Progress = 2
		;;ObjectToMove.SplineTranslateToRef(zMarker02,0, SpeedMove, SpeedRotate)
		;;SplineTranslate(ObjectToMove,zMarker02)
	;;Elseif Progress == 2 && !OneAtATime
		;;Debug.messagebox("Moved to second point successfully, moving to third point!")
		;;OneAtATime = True
		;;Progress = 3
		;;SplineTranslate(ObjectToMove,zMarker02)
		;;ObjectToMove.SplineTranslateToRef(zMarker03,0, SpeedMove, SpeedRotate)
	;;Elseif Progress == 3 && !OneAtATime
		;;Debug.messagebox("Moved to third point successfully, moving to fourth point!")
		;;OneAtATime = True
		;;Progress = 4
		;;SplineTranslate(ObjectToMove,zMarker04)
		;;ObjectToMove.SplineTranslateToRef(zMarker04, 0,SpeedMove, SpeedRotate)

		;;debug.messagebox("I'm at point 3")
	;;Elseif Progress == 4 && !OneAtATime
		;;OneAtATime = True
		;;Progress = 5
		;;ObjectToMove.SplineTranslateToRef(zMarker05,0, SpeedMove, SpeedRotate)
	;;Elseif Progress == 5 && !OneAtATime
		;;OneAtATime = True
		;;Progress = 6
		;;ObjectToMove.TranslateToRef(zMarker06, SpeedMove, SpeedRotate)
	;;Elseif Progress == 6 && !OneAtATime
		;;OneAtATime = True
		;;Progress = 7
		;;ObjectToMove.TranslateToRef(zMarker07, SpeedMove, SpeedRotate)
	;;Elseif Progress == 7 && !OneAtATime
		;;OneAtATime = True
		;;Progress = 8
		;;ObjectToMove.TranslateToRef(zMarker08, SpeedMove, SpeedRotate)
	;;Elseif Progress == 8 && !OneAtATime
		;;OneAtATime = True
		;;Progress = 9 
		;;ObjectToMove.TranslateToRef(zMarker09, SpeedMove, SpeedRotate)
	;;Elseif Progress == 4 ;;completion of the circuit
		;;OneAtATime = True
		;;Progress = 0 

		if !GoodGuy && !WasShot ;;bad guy not shot
			;;zSoundBad.Play(ObjectToMove)
			BadGuysNotShot.Setvalue(BadGuysNotShot.GetValue() +1)
		elseif Goodguy == True && !WasShot ;;goodguy not shot
			;;zSoundGood.Play(ObjectToMove)
		Endif



		if( IsBetweenZ(zMarker04,ObjectToMove,zMarker06) )
			;;object is between 4 and 6, which means its translation has just completed to 5
			;;unmark the marker so that the player can no longer hit it.
			UsedUp()
			;;move to 06
			SplineTranslate(ObjectToMove,zMarker06)
		Else
			;;object has translated to position 6, it is DEAD, kill it off
			ObjectToMove.DisableNoWait()
			ObjectToMove.SetPosition(xpos, ypos, zpos)
			ObjectToMove.SetAngle(xang, yang, zang)

		
			;;cleanup! unregister, delete instance, delete self, tell Lanecontrol to kill itself.
			ObjectToMove.Delete()
			UsedUp()
			Self.Delete()
			Endif


	Endif
	OneAtATime = False

;;Endif
EndEvent




