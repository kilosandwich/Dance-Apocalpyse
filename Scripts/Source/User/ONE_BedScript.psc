Scriptname ONE_BedScript extends ObjectReference


ObjectReference Property SceneActivator01 auto
ObjectReference Property SceneActivator02 auto
ObjectReference Property SceneActivator03 auto

GlobalVariable Property TimesSlept auto
Int NumberOfTimesSleptInThisBed = 0 
Bool DoNotRunWhileRunning

Event OnInit()
RegisterForPlayerSleep()
EndEvent

Event OnPlayerSleepStart(float afSleepStartTime, float afDesiredSleepEndTime, ObjectReference akBed)

if (akBed == Self) && (!DoNotRunWhileRunning)
	DoNotRunWhileRunning = True ;;ensures that the player does not somehow miraculously go to sleep again while the code is running and acitvates it a second time. 

	NumberOfTimesSleptInThisBed += 1	

	If (NumberOfTimesSleptInThisBed == 1) ;;the player has never slept in this bed, and this is the first time
		;;Debug.Messagebox("You have slept in this bed" + NumberOfTimesSleptInThisBed + "times")
		 SceneActivator01.Activate(Game.GetPlayer())
		TimesSlept.SetValue(1)

	Elseif  (NumberOfTimesSleptInThisBed == 2) ;;the player has slept in this bed once, and this is the second time
		;;Debug.Messagebox("You have slept in this bed" + NumberOfTimesSleptInThisBed + "times")
		SceneActivator02.Activate(Game.GetPlayer())
		TimesSlept.SetValue(2)


	Elseif  (NumberOfTimesSleptInThisBed == 3) ;;indicates that this is the third time the player has slept in this bed
		;;Debug.Messagebox("You have slept in this bed" + NumberOfTimesSleptInThisBed + "times")
		SceneActivator03.Activate(Game.GetPlayer())
		TimesSlept.SetValue(3)
		UnRegisterForPlayerSleep()

	Endif
	

	DoNotRunWhileRunning = False	
Endif

EndEvent