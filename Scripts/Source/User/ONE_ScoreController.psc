Scriptname ONE_ScoreController extends ObjectReference


GlobalVariable Property ScoreTotal auto
GlobalVariable Property Combo auto
GlobalVariable Property LaneScore auto ;;this is the message recieved by the Score Controller then converted into action
;;this will later display the messages on screen when I get around to doing the art
ObjectReference Property SignGood auto
ObjectReference Property SignGreat auto
ObjectReference Property SignOK auto
ObjectReference Property SignPerfect auto
ObjectReference Property SignMiss auto

Bool IsWorking

Event OnActivate(ObjectReference akActioonRef)

if! IsWorking
IsWorking = True
float score = LaneScore.GetValue() as int
LaneScore.SetValue(0)

if Score == 0
;;0 means a miss
SignMiss.Activate(Self)
Debug.trace("MISS!")

Elseif Score ==1
;; 1 meansOK
Debug.trace("OK!")
SignOK.Activate(Self)


Elseif Score == 2
;; 2 means Good
Debug.trace("GOOD")
SignGood.Activate(Self)

Elseif Score == 3
;;3 means Great
Debug.trace("GREAT!")
SignGreat.Activate(Self)

Elseif Score == 4
;;4 means Perfect
Debug.trace("PERFECT!")
SignPerfect.Activate(Self)

EndIf

IsWorking = False
Endif
EndEvent

