Scriptname ONE_DanceStack extends ObjectReference

;;this is the DanceStack, it iterates through a list of numbers which represent the lane spawner to use
;;
ObjectReference Property SpeakerToActivate auto



GlobalVariable Property LaneToSpawn auto
ObjectReference Property DancePRIME auto


;;keep in mind a string can only be 512 characters long
;;String KEY:
;;DiRECTIONAL KEY
;; Jump = 0
;;U = Up 1
;;D = Down 2
;;L = Left 3
;;R = Right 4
;;SPACING KEY
;;5 spacing type two will be that of all following int values (the next number being 5 terminates the spacing)
;;6 = Spaceing Type One 6
;;7 = Spacing Type Two 7
;;TERMINATION KEY
;;8 = Load the next specified string (unlikely to be use, but nice to have 
;; 9 END OF PROGRAM


;;remember, you only get 128 items
Int[] DanceStack
int[] DanceStack02
int[] DanceStack03
int[] DanceStack04
int[] DanceStack05
int[] DanceStack06
int[] DanceStack07
int[] DanceStack08
int[]DanceStack09


;;spacing values
float Property SpaceTypeOne = 2.0 auto
float SpaceTypeTwo = 6.0

;;DDR songwriting
;;For some reason my compiler cannot handle more than 40 digits for a float, likely due to the stupid math I am trying to make it do.
float line1 = 7114142314231122334411442233414324318.00
float line2 = 14342424621321363223266663213663266.00
float line3 = 43312332423124231241423543243231148.00
float line4 = 44232134243134421432236662422666613.00
float line5 = 77444772227711177444773337722277111.00
float line6 = 14231421413241732411234321132413466.00
float line7 = 14141313443214321243211436622661713.00
float line8 = 14231111324142314773221321732137662.00
float line9 = 12343212343212341727374737271711234.00
float line10 = 1424323421322314231434121661323121.00
float line11 = 1321323121313233211321133231322662.00
float line12 = 1432323423432123141266144661222663.00
float line13 = 4132112343243123121134131221661226.00
float line14 = 1441441442332331332442446622113213.00
float line15 = 2223224332332414213412124321432121.00
float line16 = 1144211443322224433322211144433322.00
float line17 = 4434424414434424414434424414434421.00
float line18 = 1131141131413121234321662266223321.00
float line19 = 6611662266336632126621326626621321.00

;;626636626636626646626616626646612343214243414423124310.00


int Iterator = 0 ;;this is the iterator used for iterating through the string that is being used as a list
bool InProgress = false
 




Function IterateThroughFloatAddToArray(int[] ArrayToAddTo,float IterateThroughThisFloat)
	;;Debug.messagebox("I am attempting to compile the array!")
	float GetTheFirstDigitOfThis = IterateThroughThisFloat
	;;debug.messagebox("The float to be compiled is:" + (GetTheFirstDigitOfThis as string))
	While  Math.floor(GetTheFirstDigitOfThis / 10) != 0
		int magnitude = -1
		float temp = GetTheFirstDigitOfThis

		While temp >= 1
			temp = temp / 10
			magnitude = magnitude + 1
		EndWhile
		;;debug.messagebox("Magniture is: " + (magnitude as string))

		;;GetTheFirstDigit
		float FirstDigitFloat= (GetTheFirstDigitOfThis / (Math.pow(10,magnitude )) )
		int FirstDigitInt = FirstDigitFloat as int
		;;debug.messagebox("The first digit of the float is:" + (FirstDigitInt as string))

		;;add to the first digit of the float to the array
		DanceStack.Add(FirstDigitInt,1)
		;;Debug.messagebox("Digit attempting to be added: "+ FirstDigitInt)

		;;remove the first digit. 
		;;Debug.messagebox("Math pow: " + (Math.pow(10,magnitude) as string) )
		;;Debug.messagebox("Math pow to subtract is: " + ((FirstDigitInt* Math.pow(10,magnitude)) as string))
		GetTheFirstDigitOfThis = GetTheFirstDigitOfThis - (FirstDigitInt*(Math.pow(10,magnitude)))
		;;Debug.messagebox("The float is now: " + (GetTheFirstDigitOfThis as string))

	EndWhile
EndFunction

;;converts an array of integers into a float
float Function ConvertIntArrayToFloat(int[] ArrayToConvert)
	int tempIterator = 0
	float tempFloat = 0.00
	While(tempIterator < ArrayToConvert.Length)
		tempFloat = tempFloat + ArrayToConvert[tempIterator]*math.pow(10, (ArrayToConvert.Length -1) - tempIterator)
		tempIterator = tempIterator +1
	EndWhile
	
	return tempFloat
EndFunction



;;the dance stack is designed so that if the next value is an input, then the default waiting type is spaceTypeOne
;;otherwise, the dance stack defers to the next specified wait time in the dance stack
Bool Function IsNextOneTwoThreeFour(int[] ArrayToCheck, int IteratorToUse)
	int tempInt = ArrayToCheck[Iterator +1]
	if(tempInt < 5)
		return True
	Else
		return False
	EndIf
EndFunction

Function Dancer(int[] ArrayToIterateThrough)
		 ;;reset the iterator to zero so it can be iterated through
		;;Debug.messagebox("The length of the array to Iterate through is:" + (ArrayToIterateThrough.Length))
		Iterator = 0

		;;the first values of the array are zero, we can skip through these
		While (ArrayToIterateThrough[Iterator] == 0)
			Iterator = Iterator + 1		
		EndWhile

		
		While Iterator < (ArrayToIterateThrough.Length +1)
			;;Debug.messagebox("I am attempting to iterate through the dance stack!")	
			;;Debug.messagebox("The current iterator value is: " + Iterator)
			;;Debug.messagebox("The array value I am at is: " + (ArrayToIterateThrough[Iterator] ))

			if ArrayToIterateThrough[Iterator] == 5
				;;the number 5 indicates that spaceTypeTwo will be of custom length until 5 is encountered again

				SpaceTypeTwo = 0
				int magnitude = 0
				int[] tempArray
				Iterator = Iterator +1
				;;assemble a temporary array to later be turned into a float
				While(ArrayToIterateThrough[Iterator] != 5)
					tempArray.add(ArrayToIterateThrough[Iterator])
					Iterator = Iterator +1
				EndWhile

				;;turn the array into a float
				float tempFloat5 = ConvertIntArrayToFloat(tempArray)
				tempFloat5 = tempFloat5 / 10
				SpaceTypeTwo = tempFloat5

				Iterator = Iterator +1 ;;go get the next number for the next section
			ElseIf ArrayToIterateThrough[Iterator] == 6
				Utility.Wait(SpaceTypeOne)
			Elseif ArrayToIterateThrough[Iterator] == 7
				Utility.Wait(SpaceTypeTwo)

			;;ElseIf ArrayToIterateThrough[Iterator] == 0
				;;if IsNextOneTwoThreeFour(ArrayToIterateThrough, Iterator)
					;;LaneToSpawn.SetValue(0)
					;;DancePRIME.Activate(self)
					;;Utility.wait(SpaceTypeOne)
				;;Else
					;;LaneToSpawn.SetValue(0)
					;;DancePRIME.Activate(self)
				;;Endif

			ElseIf ArrayToIterateThrough[Iterator] == 1
				if IsNextOneTwoThreeFour(ArrayToIterateThrough, Iterator)
					LaneToSpawn.SetValue(1)
					DancePRIME.Activate(self)
					Utility.wait(SpaceTypeOne)
				Else
					LaneToSpawn.SetValue(1)
					DancePRIME.Activate(self)
				Endif

			ElseIf ArrayToIterateThrough[Iterator] == 2
				if IsNextOneTwoThreeFour(ArrayToIterateThrough, Iterator)
					LaneToSpawn.SetValue(2)
					DancePRIME.Activate(self)
					Utility.wait(SpaceTypeOne)
				Else
					LaneToSpawn.SetValue(2)
					DancePRIME.Activate(self)
				Endif

			ElseIf ArrayToIterateThrough[Iterator] == 3
				;;Debug.messagebox("Dance stack is changing value to 3! Activating Dance PRIME!")
				if IsNextOneTwoThreeFour(ArrayToIterateThrough, Iterator)
					LaneToSpawn.SetValue(3)
					DancePRIME.Activate(self)
					Utility.wait(SpaceTypeOne)
				Else
					LaneToSpawn.SetValue(3)
					DancePRIME.Activate(self)
				Endif

			ElseIf ArrayToIterateThrough[Iterator] == 4
				if IsNextOneTwoThreeFour(ArrayToIterateThrough, Iterator)
					LaneToSpawn.SetValue(4)
					DancePRIME.Activate(self)
					Utility.wait(SpaceTypeOne)
				Else
					LaneToSpawn.SetValue(4)
					DancePRIME.Activate(self)
				Endif



			Endif
			
			;;if statements completed, advance the iterator
			Iterator = Iterator + 1
		EndWhile
EndFunction

Event OnActivate(ObjectReference akActionRef)



	if !InProgress
		InProgress = True ;;this prevents it from being activated while it is active.
		int WhichStack = 1 
		;;Debug.messagebox("I have been activating, attempting to compile!")
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line1)



		;;Debug.messagebox("I finished compiling, I am attempting to start the Dance stack!")
		;;Debug.messagebox("Dance stack started!")
		;;Debug.Messagebox("Activateing Speaker")
		SpeakerToActivate.Activate(Self)

		Dancer(DanceStack)
		Debug.messagebox("Loading line2")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line2)
		Dancer(DanceStack)
		Debug.messagebox("Loading line3")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line3)
		Dancer(DanceStack)
		
		Debug.messagebox("Loading line4")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line4)
		Dancer(DanceStack)

		Debug.messagebox("Loading line5")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line5)
		Dancer(DanceStack)

		Debug.messagebox("Loading line6")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line6)
		Dancer(DanceStack)

		Debug.messagebox("Loading line7")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line7)
		Dancer(DanceStack)

		Debug.messagebox("Loading line8")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line8)
		Dancer(DanceStack)

		Debug.messagebox("Loading line9")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line9)
		Dancer(DanceStack)

		Debug.messagebox("Loading line10")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line10)
		Dancer(DanceStack)

		Debug.messagebox("Loading line11")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line11)
		Dancer(DanceStack)

		Debug.messagebox("Loading line12")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line12)
		Dancer(DanceStack)

		Debug.messagebox("Loading line13")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line13)
		Dancer(DanceStack)

		Debug.messagebox("Loading line14")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line14)
		Dancer(DanceStack)

		Debug.messagebox("Loading line15")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line15)
		Dancer(DanceStack)

		Debug.messagebox("Loading line16")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line16)
		Dancer(DanceStack)

		Debug.messagebox("Loading line17")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line17)
		Dancer(DanceStack)

		Debug.messagebox("Loading line18")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line18)
		Dancer(DanceStack)

		Debug.messagebox("Loading line19")
		DanceStack.Clear()
		DanceStack = new int[40]
		IterateThroughFloatAddToArray(DanceStack,line19)
		Dancer(DanceStack)


		InProgress = False

		
	Endif
EndEvent




;/
			ElseIf ArrayToIterateThrough[Iterator] == 8

				Iterator =-1 ;;reset the iterator to count through the next array(it will be zero once one is added)
				WhichStack = WhichStack +1 ;;load the next stack

				debug.messagebox("8 reached, loading next stack: " + WhichStack)
				if WhichStack == 2
					ArrayToIterateThrough = DanceStack02
					Debug.Messagebox("The new array has loaded, the length is:" + ArrayToIterateThrough.Length)
				Elseif WhichStack == 3
					ArrayToIterateThrough = DanceStack03
				Elseif WhichStack == 4
					ArrayToIterateThrough = DanceStack04
				Elseif WhichStack == 5
					ArrayToIterateThrough = DanceStack05
				Elseif WhichStack == 6
					ArrayToIterateThrough = DanceStack06
				Elseif WhichStack == 7
					ArrayToIterateThrough = DanceStack07
				Elseif WhichStack == 8
					ArrayToIterateThrough = DanceStack08
				Elseif WhichStack == 9
					ArrayToIterateThrough = DanceStack09

				Endif






/;