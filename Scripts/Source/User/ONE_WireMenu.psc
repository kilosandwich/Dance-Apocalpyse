Scriptname ONE_WireMenu extends ObjectReference

Int ButtonPressed01 = 0
Int ButtonPressed02 = 0

GlobalVariable Property PANELFIXED auto
;;PANEL FIXED GUIDE
;; 0 = not fixed
;;11 = the electrical system was petted and with good luck was fixed before it broke
;;12 = a screwdriver prevented the electrical system from failing
;;13 = the electrical system was sabotaged before it broke
;;14 = the electrical system was fixed before it broke so it never failed
;;21 = the player is too dumb to realize the system is broken
;;22 = the screwdriver has fixed the system, somehow.
;;23 = the system was smashed beyond repair
;;24 = the system is repaired so it will never breaks again. 

;;SHOWPROGRESS Guide
;;0 = show not startetd
;;10 = show in progress
;;11 = song 1 completed
;;16 = show sabotaged during act 1

;;20 = song 2 in progress
;;21 = song 2 completed
;;30 = song 3 in progress
;;31 = song 3 completed



GlobalVariable Property PANELBROKEN auto ;;the panel has been naturally broken by the show. 
GlobalVariable Property SHOWPROGRESS auto


MiscObject Property Screwdriver Auto Const
MiscObject Property Pencil Auto Const
ObjectReference Property ScrewDriverToEnable auto
ObjectReference Property SparksToEnable auto
ObjectReference Property ShowStopper auto
Sound Property PunchSound auto
Sound Property SparkySound auto
Quest Property pMyQuest  Auto
Message Property pMessageDisplay01  Auto
Message Property pMessageDisplay02 Auto
ActorValue Property StrengthAV Auto Const
ActorValue Property IntelligenceAV Auto Const
ActorValue Property LuckAV Auto Const
Perk Property PerkScience Auto Const


int choice11attempts = 0
int choice110attempts = 0
int choice12attempts = 0
int choice13attempts = 0
int choice14attempts = 0



int choice22attempts = 0
int choice23attempts = 0
Event OnActivate(ObjectReference akActionRef)

	If akActionRef == Game.GetPlayer()
;; The panel has been fixed, display a message telling the player it has been fixed. 
		
		if PANELFIXED.GetValue() > 0 
			SparksToEnable.DisableNoWait()		
			if PANELFIXED.GetValue() == 11
				debug.messagebox("The electrical system was somehow fixed by you petting it")
			Elseif PANELFIXED.GetValue() == 12	
				debug.messagebox("This screwdriver seems to be holding this electrical system together somehow")
			Elseif PANELFIXED.GetValue() == 13	
				debug.messagebox("This electrical panel has been pummeled beyond repair")
			Elseif PANELFIXED.GetValue() == 14	
				debug.messagebox("The electrical panel has been fixed")
			Elseif PANELFIXED.GetValue() == 21	
				debug.messagebox("You've concluded that the electrical panel is not broken, despite it being broken")
			Elseif PANELFIXED.GetValue() == 22	
				debug.messagebox("You've repaired the electrical panel with a screwdriver. It works somehow.")
			Elseif PANELFIXED.GetValue() == 23	
				debug.messagebox("The electrical panel can no longer be repaired because you have broken it.")
			Elseif PANELFIXED.GetValue() == 24	
				debug.messagebox("The electrical panel has been repaired, and is not likely to break in the future")
			Endif

		Endif



		;;The player fixes the panel BEFORE it breaks AND the panel has not been fixed

		If (PANELBROKEN.GetValue() == 0) && (PANELFIXED.GetValue() == 0 ) && ( SHOWPROGRESS.Getvalue() != 11)

				ButtonPressed01 = pMessageDisplay01.Show()
				If ButtonPressed01 == 0
					;;debug.messagebox("Option zero picked, panel NOT broken")
				ElseIf ButtonPressed01 == 1
					if ( Game.GetPlayer().GetValue(LuckAV)  >= 6)
						 if( Game.GetPlayer().GetValue(IntelligenceAV)  <= 2) 
							PANELFIXED.SetValue(11)
							debug.messagebox( "You pet the electrical panel, soothing its spirit. It is fixed.")
						Elseif ( Game.GetPlayer().GetValue(IntelligenceAV)  > 2) 
							PANELFIXED.SetValue(11)
							debug.messagebox( "Against your better judgement you pet the electrical panel. However, that seems to have fixed it.")
						Endif
					Endif
					
					if  Game.GetPlayer().GetValue(LuckAV)  < 6 &&   Game.GetPlayer().GetValue(IntelligenceAV)  <= 2
						if choice11attempts == 0
							debug.messagebox( "You pet the electrical panel. It feels like the right thing to do. It is still not fixed however")
						elseif choice11attempts == 1
							debug.messagebox( "You pet the electrical panel. It feels tingly. It still looks as if it could fail at any moment.")
						elseif choice11attempts == 2
							debug.messagebox( "You pet the electrical panel. You wonder if it has a name. It is not yet fixed.")
						elseif choice11attempts == 3
							debug.messagebox( "You pet the electrical panel. You decide to call the electrical panel Daniel. Daniel still remains unfixed.")
						elseif choice11attempts == 4
							debug.messagebox( "You pet Daniel. He does not respond, perhaps he does not like being pet. Daniel still remains unfixed.")
						elseif choice11attempts == 5
							debug.messagebox( "You pet Daniel. Perhaps he is hungry. Daniel still remains unfixed.")
						elseif choice11attempts == 6
							debug.messagebox( "You pet Daniel. Perhaps he is lonely. Daniel still remains unfixed.")
						elseif choice11attempts == 7
							debug.messagebox( "You pet Daniel. You know that petting him is the right thing to do. Daniel still remains unfixed.")
						elseif choice11attempts == 8
							debug.messagebox( "You pet Daniel. You wonder what his parents are like. Daniel still remains unfixed.")
						elseif choice11attempts == 9
							debug.messagebox( "You pet Daniel. Your arm feels tired. Daniel still remains unfixed.")
						elseif choice11attempts == 10
							debug.messagebox( "You pet Daniel. You remember that Daniel is an electrical panel, but that does not affect your oppinion of him. Daniel still remains unfixed.")
						elseif choice11attempts >= 11
							debug.messagebox( "You pet Daniel. Daniel still remains unfixed.")
						Endif
						choice11attempts = choice11attempts + 1
					Endif

					if  Game.GetPlayer().GetValue(LuckAV)  < 6 &&   Game.GetPlayer().GetValue(IntelligenceAV)  > 2
						if choice110attempts == 0
							debug.messagebox( "Against your better judgement, you pet the electrical panel. Nothing happens. The panel remains broken.")
						Elseif choice110attempts == 1
							debug.messagebox( "Against your better judgement, you pet the electrical panel again. The panel remains broken.")
						Elseif choice110attempts == 2
							debug.messagebox( "You pet the electrical panel. You hope that you might get lucky and it will fix itself. The panel remains broken.")
						Elseif choice110attempts == 3
							debug.messagebox( "You pet the electrical panel. The metal feels warm to the touch. The panel remains broken.")
						Elseif choice110attempts == 4
							debug.messagebox( "You pet the electrical panel. Nothing changes. You know you are smarter than this.")
						Elseif choice110attempts >= 5
							debug.messagebox( "Despite being smarter than this, you pet the electrical panel again anyway. Nothing changes.")
						Endif
						choice110attempts = choice110attempts + 1
					Endif

					
				ElseIf ButtonPressed01 == 2
					;;check if the player has a screwdriver
					if (Game.GetPlayer().GetItemCount(Screwdriver) > 0)
						PANELFIXED.SetValue(12)
						Debug.messagebox("You cleverly wedge the screwdriver in the electrical panel, fixing it.")
						Game.GetPlayer().RemoveItem(Screwdriver, 1)
						ScrewDriverToEnable.Enable()

					Elseif (Game.GetPlayer().GetItemCount(Screwdriver) == 0)
						;; mock the player for repeating bad decisions.
						if choice12attempts == 0
							debug.messagebox( "You do not have a screwdriver in your inventory.")
						Elseif choice12attempts == 1
							debug.messagebox("You still do not have a screwdriver in your inventory.")
						Elseif choice12attempts == 2
							debug.messagebox("You continue to not have a screwdriver in your inventory.")
						Elseif choice12attempts == 3
							debug.messagebox("After much soul searching you realize you still do not have a screwdriver in your inventory.")
						Elseif choice12attempts == 4
							debug.messagebox("You think you have a screwdriver in your inventory, but you realize it is actually just a pencil.")
							Game.GetPlayer().AddItem(Pencil, 1)
						Elseif choice12attempts >= 5
							debug.messagebox("You do not have a screwdriver in your inventory.")
						Endif
						choice12attempts = choice12attempts + 1
					endIf

				ElseIf ButtonPressed01 == 3
					if Game.GetPlayer().GetValue(StrengthAV)  >= 7 
						PANELFIXED.SetValue(13)
						Debug.messagebox("You pummel the electrical panel beyond repair.")
						SparksToEnable.EnableNoWait()
						PunchSound.Play(Self)
						SparkySound.Play(self)
						
						If ShowProgress.GetValue() == 10
							ShowProgress.SetValue(16)
							ShowStopper.Activate(Game.Getplayer())
						Endif

						utility.wait(1.5)
						SparksToEnable.DisableNoWait()	

					Elseif Game.GetPlayer().GetValue(StrengthAV)  < 7 
						if choice13attempts == 0
							debug.messagebox( "You hit the electical panel, but you are not strong enough to break it permanently.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 1 || choice23attempts == 1
							debug.messagebox("You hit the electrical panel again. It still looks somewhat functional though.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 2 || choice23attempts == 2
							debug.messagebox("You hit the electrical panel again. Nothing seems to have changed")
							PunchSound.Play(Self)
						Elseif choice13attempts == 3 || choice23attempts == 3
							debug.messagebox("You hit the electrical panel again. Despite being fragile it sure is durable.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 4 || choice23attempts == 4
							debug.messagebox("You hit the electrical panel again ,but you are still not strong enough.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 5 || choice23attempts == 5
							debug.messagebox("You hit the electrical panel again. You're still not strong enough, but you remember that strength isn't everything.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 6 || choice23attempts == 6
							debug.messagebox("You hit the electrical panel again. You feel something crunch, but the panel still looks functional.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 7 || choice23attempts == 7
							debug.messagebox("You hit the electrical panel again.This time you're sure that hit did something.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 8 || choice23attempts == 8
							debug.messagebox("You hit the electrical panel again. That hit definitely did something.")
							PunchSound.Play(Self) 
						Elseif choice13attempts == 9 || choice23attempts == 9
							debug.messagebox("You hit the electrical panel again. The panel looks close to breaking outright.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 10 || choice23attempts == 10
							PANELFIXED.SetValue(13)
							debug.messagebox("You hit the panel again. Your repeated smashing has destroyed it beyond repair.")
							SparksToEnable.EnableNoWait()
							PunchSound.Play(Self)
							SparkySound.Play(self)

							If ShowProgress.GetValue() == 10
								ShowProgress.SetValue(16)
								ShowStopper.Activate(Game.Getplayer())
							Endif
							utility.wait(1.5)
							SparksToEnable.DisableNoWait()		


						Endif
						choice13attempts = choice13attempts + 1
					Endif
						
					

			
				ElseIf ButtonPressed01 == 4
					if Game.Getplayer().HasPerk(PerkScience) == true
						PANELFIXED.SetValue(14)
						debug.messagebox("You repair the panel successfully")
					Elseif Game.Getplayer().HasPerk(PerkScience) == false
						Debug.messagebox("You do not have the Science! perk")			
					Endif

				EndIf
		Endif

		;;The player fixes the panel AFTER it breaks AND the panel has not yet been fixed












		;;THERE IS A BIG SPACE HERE TO MAKE YOU REALIZE THIS IS THE SECOND BIT
		If (PANELBROKEN.GetValue() == 1) && (PANELFIXED.GetValue() == 0 )

				ButtonPressed02 = pMessageDisplay02.Show()
				If ButtonPressed02 == 0
					;;debug.messagebox("Option zero picked, panel IS broken")

				ElseIf ButtonPressed02 == 1
					if Game.GetPlayer().GetValue(IntelligenceAV)  <= 2
						PANELFIXED.SetValue(21)
						Debug.messagebox("After much staring, you conclude that the panel is not broken, but was always meant to be this way, despite this not being true.")
					Endif
					
					if Game.GetPlayer().GetValue(IntelligenceAV)  > 2
						debug.messagebox("You are not stupid enough to conclude that this is not broken, it very clearly is.")
					Endif

				ElseIf ButtonPressed02 == 2
					;;check if the player has a screwdriver
					if (Game.GetPlayer().GetItemCount(Screwdriver) > 0)
						PANELFIXED.SetValue(22)
						Debug.messagebox("You cleverly wedge the screwdriver in the electrical panel, fixing it.")
						Game.GetPlayer().RemoveItem(Screwdriver, 1)
						ScrewDriverToEnable.Enable()

					Elseif (Game.GetPlayer().GetItemCount(Screwdriver) == 0)
						;; mock the player for repeating bad decisions.
						if choice22attempts == 0
							debug.messagebox( "You do not have a screwdriver in your inventory.")
						Elseif choice22attempts == 1
							debug.messagebox("You still do not have a screwdriver in your inventory.")
						Elseif choice22attempts == 2
							debug.messagebox("You continue to not have a screwdriver in your inventory.")
						Elseif choice22attempts == 3
							debug.messagebox("After much soul searching you realize you still do not have a screwdriver in your inventory.")
						Elseif choice22attempts == 4
							debug.messagebox("You think you have a screwdriver in your inventory, but you realize it is actually just a pencil.")
							Game.GetPlayer().AddItem(Pencil, 1, true)
						Elseif choice22attempts >= 5
							debug.messagebox("You do not have a screwdriver in your inventory.")
						Endif
						choice22attempts = choice22attempts + 1
					endIf

				ElseIf ButtonPressed02 == 3
					if Game.GetPlayer().GetValue(StrengthAV)  >= 7 
						PANELFIXED.SetValue(23)
						Debug.messagebox("You pummel the electrical panel beyond repair.")
						SparksToEnable.EnableNoWait()
						PunchSound.Play(Self)
						SparkySound.Play(self)
					Elseif Game.GetPlayer().GetValue(StrengthAV)  < 7 
						if choice23attempts == 0
							debug.messagebox( "You hit the electical panel, but you are not strong enough to break it permanently.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 1 || choice23attempts == 1
							debug.messagebox("You hit the electrical panel again. It still looks somewhat functional though.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 2 || choice23attempts == 2
							debug.messagebox("You hit the electrical panel again. Nothing seems to have changed")
							PunchSound.Play(Self)
						Elseif choice13attempts == 3 || choice23attempts == 3
							debug.messagebox("You hit the electrical panel again. Despite being fragile it sure is durable.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 4 || choice23attempts == 4
							debug.messagebox("You hit the electrical panel again ,but you are still not strong enough.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 5 || choice23attempts == 5
							debug.messagebox("You hit the electrical panel again. You're still not strong enough, but you remember that strength isn't everything.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 6 || choice23attempts == 6
							debug.messagebox("You hit the electrical panel again. You feel something crunch, but the panel still looks functional.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 7 || choice23attempts == 7
							debug.messagebox("You hit the electrical panel again.This time you're sure that hit did something.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 8 || choice23attempts == 8
							debug.messagebox("You hit the electrical panel again. That hit definitely did something.")
							PunchSound.Play(Self) 
						Elseif choice13attempts == 9 || choice23attempts == 9
							debug.messagebox("You hit the electrical panel again. The panel looks close to breaking outright.")
							PunchSound.Play(Self)
						Elseif choice13attempts == 10 || choice23attempts == 10
							PANELFIXED.SetValue(23)
							debug.messagebox("You hit the panel again. Your repeated smashing has destroyed it beyond repair.")
							SparksToEnable.EnableNoWait()
							PunchSound.Play(Self)
							SparkySound.Play(self)
							utility.wait(1.5)
							SparksToEnable.DisableNoWait()		
						Endif

						if choice13attempts >= 1
						choice13attempts = choice13attempts + 1		
						elseif choice13attempts == 0
						choice23attempts = choice23attempts + 1		
						endif
					Endif


	
				ElseIf ButtonPressed02 == 4
					if Game.Getplayer().HasPerk(PerkScience) == true
						PANELFIXED.SetValue(24)
						debug.messagebox("You repair the panel successfully")
					Elseif Game.Getplayer().HasPerk(PerkScience) == false
						Debug.messagebox("You do not have the Science! perk")			
					Endif
				EndIf
		Endif

		
	EndIf	
EndEvent











