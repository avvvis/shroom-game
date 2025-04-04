@startuml
actor Gracz
participant "MainMenu" as MM
participant "Global Options" as OP
participant "GameState" as GS
participant "Hut" as HT
participant "Hut.IV" as HIV
participant "Item" as I
participant "World" as W
participant "Board" as B
participant "PlayerCharacter" as PC
participant "BoardCell" as BC
participant "Potion" as POT
participant "Enemy" as E

Activate Gracz
opt Menu główe
 Gracz -> MM: Wybór "Options"
 Activate MM
 MM -> MM: swapowanie paneli menu i opcje
 MM -> OP: Zapisz zmiany w opcjach
 Deactivate MM
end
 
Gracz -> MM: Wybór "Start"
Activate MM
MM->MM: swapowanie paneli menu i saveselector
MM -> MM: Wybór save
MM -> GS : wczytaj dane z $save 
MM -> HT: Załaduj chatkę
deactivate MM


loop Chatki
 Opt warzenie mikstur
  Gracz -> HT: wybór "uwarz miksture"
  activate HT
  HT->HT: swapowanie paneli
  HT->HIV: wyswietl ekwipunek  
  deactivate HT
  Gracz->HIV: wybiera składniki
  Gracz->HT: wybiera "uwuarz"
  activate HT
  HT->POT: "uwarz mikture"
  POT-->HT: zwraca miksturę
  HT->GS: zastąp składniki miskturą
  deactivate HT
 end 
 opt rozpocznij nowy dzien
   Gracz -> HT: wybiera "nowy dzień"
   activate HT
   HT -> GS: wywołanie next_day
   HT -> W: załaduj world
   deactivate HT
   activate W
   W -> B: Generowanie planszy (Board)
   deactivate W
   activate B
   B -> BC: Tworzenie pól planszy (BoardCell)
   deactivate B
 end
end

loop Świata
 alt Interakcje ze światem
  Gracz->PC: Naciska klawisz
  activate PC
  PC->W: chodzi
  deactivate PC
 else
  Gracz->PC: Naciska klawisz
  activate PC
  PC->E: walczy
  deactivate PC
 else
  Gracz->PC: Naciska klawisz
  activate PC
  PC -> W: Podniesienie przedmiotu
  deactivate PC
  activate W
  W -> GS: Dodanie przedmiotu do ekwipunku
  deactivate W
 else
  Gracz->PC: Naciska klawisz
  activate PC
  PC -> I: Użycie przedmiotu
  activate I
  I --> PC: efekt przedmiotu
  deactivate I
  deactivate PC
 else
  Gracz->PC: Naciska klawisz
  activate PC
  Gracz->W: Wejdź do chatki
  deactivate PC
  activate W
  opt Chatka w zasięgu
   W->GS: Koniec dnia
   W->H: Załaduj chatkę
  end
  deactivate W
 end
end
@enduml
