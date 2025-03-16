1. Napisanie scenariuszy przypadków użycia wybranego przez nas systemu (na podstawie specyfikacji
wymagań z poprzedniego ćwiczenia). Każdy scenariusz przypadku użycia musi zawierać co najmniej
następujące elementy:
- Nazwę
- Warunki początkowe
- Warunki końcowe
- Scenariusz
Co jeszcze może zawierać scenariusz?
- opis "aktorów"
- scenariusz (przepływ / ścieżkę) alternatywny
- odnośnik(i) do konkretnego wymagania
- odnośnik(i) do innego scenariusza
- itd.

Przypadek użycia:
Opis:
Aktorzy:
Warunki wstępne:
Tabelka:
Wyjątki i scenariusze alternatywne:

Przypadek użycia: Rozpoczęcie nowej gry
Opis: Gracz powinien móc rozpocząć nową grę według własnej woli. Powinien mieć do wyboru co najmniej 3 save-y.
Aktorzy: Gracz
Warunki wstępne: Gracz jest w menu głównym
    1. Gracz klika "Nowa gra" 
    2. System wyświetla menu wyboru save slot-a 
    3. Gracz wybiera pusty save slot 
    4. System inicjalizuje save-a 
    5. System uruchamia grę na nowym save file-u 
Scenariusze alternatywne:
Gracz wybiera niepusty save slot. System wyświetla okienko z pytaniem, czy gracz jest pewien o usunięciu wybranego save-a. Jeśli gracz wybiera opcję "tak", system usuwa save-a, inicjalizuje nową grę na wybranym slocie i uruchamia grę. Jeśli gracz wybiera opcję "nie", system przechodzi do wyboru save slot-a.

Przypadek użycia: Zbieranie grzyba
Opis: Gracz powinien móc zbierać grzyby podczas eksploracji świata gry.
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w pobliżu grzyba
    1. Gracz podchodzi do grzyba 
    2. System wyświetla mechanizm informujący o możliwości zebrania grzyba 
    3. Gracz naciska przycisk interakcji 
    4. System dodaje grzyba do ekwipunku gracza 
    5. System usuwa grzyba z otoczenia 
Scenariusze alternatywne:
Gracz próbuje zebrać grzyba, ale ekwipunek jest pełny. System wyświetla komunikat „Brak miejsca w ekwipunku” i nie dodaje grzyba.

Przypadek użycia: Warzenie mikstury
Opis: Gracz powinien móc warzyć mikstury z zebranych grzybów.
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w chatce
    1. Gracz otwiera menu craftowania
    2. System wyświetla menu wyboru grzybów 
    3. Gracz wybiera składniki
    4. System warzy miksturę i dodaje ją do ekwipunku 
    5. System usuwa użyte składniki z ekwipunku gracza 
Scenariusze alternatywne:
Gracz próbuje stworzyć miksturę, ale jego ekwipunek jest pusty. System wyświetla komunikat „Brak składników” i nie warzy mikstury.

Przypadek użycia: Spożycie mikstury lub grzyba
Opis: Gracz powinien móc konsumować grzyby i mikstury, które znajdują się w jego ekwipunku.
Aktorzy: Gracz
Warunki wstępne: Gracz posiada co najmniej jedną miksturę lub grzyba w ekwipunku
    1. Gracz otwiera ekwipunek 
    2. System wyświetla listę posiadanych mikstur i grzybów 
    3. Gracz wybiera przedmiot i potwierdza użycie 
    4. System aktywuje efekt przedmiotu 
    5. System usuwa zużytą miksturę lub grzyba z ekwipunku 
Scenariusze alternatywne:
Brak

Przypadek użycia: Wczytanie stanu ostatniej rozgrywki
Opis: Gracz powinien móc wrócić do gry po przerwie.
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w menu głównym i ma zapisany stan gry
    1. Gracz klika "Continue”
    2. System uruchamia rozgrywkę od miejsca zapisu 
Scenariusze alternatywne:
Save jest zepsuty. System wyświetla wtedy informację o błędzie.

Przypadek użycia: Wczytanie stanu save-a
Opis: Gracz powinien móc kontynuować grę z dowolnego save-a.
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w menu głównym i ma zapisany stan gry
    1. Gracz klika przycisk "Wczytaj grę"
    2. System wczytuje save-a od miejsca zapisu 
Scenariusze alternatywne:
Save jest zepsuty. System wyświetla wtedy informację o błędzie.

Przypadek użycia: Otworzenie menu pauzy w trakcie rozgrywki
Opis: Gracz powinien móc otworzyć menu, aby uzyskać dostęp do różnych opcji.
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w trakcie rozgrywki
    1. Gracz naciska przycisk menu 
    2. System wyświetla menu pauzy 
Scenariusze alternatywne:
Brak

Przypadek użycia: Opuszczenie menu pauzy
Opis: Gracz powinien móc opuścić menu, aby wrócić do gry.
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w menu pauzy
    3. Gracz naciska przycisk menu 
    4. System zamyka menu pauzy
Scenariusze alternatywne:
Brak

Przypadek użycia: Wejście do chatki
Opis: Gracz powinien móc wejść do chatki, jeśli znajduje się w pobliżu.
Aktorzy: Gracz
Warunki wstępne: Gracz stoi przy wejściu do chatki
    1. Gracz naciska przycisk interakcji 
    2. System przełącza widok na wnętrze chatki 
Scenariusze alternatywne:
brak

Przypadek użycia: Wyjście z chatki - nowy dzień
Opis: Gracz powinien móc wyjść z chatki do świata gry każdego dnia gry
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w chatce
    1. Gracz naciska przycisk wyjścia 
    2. System generuje nowy świat gry
    3. System przełącza widok na świat zewnętrzny który się zmienił w stosunku do dnia poprzedniego
    ...(wiele różnych przypadków użycia może się odbyć w międzyczasie)
    n. gracz wraca do chatki
Scenariusze alternatywne:
n.a jeżeli gracz nie wróci do domu zanim zrobi się odpowiednio późno zabije go jakiś straszny potwór

Przypadek użycia: Przemieszczanie się po mapie
Opis: Gracz powinien móc swobodnie poruszać się po mapie gry.
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w świecie gry
    1. Gracz używa klawiszy ruchu lub kontrolera 
    2. System zwiększa szybkość postaci zgodnie z funkcją przyspiesznia względem szybkości
Scenariusze alternatywne:

Przypadek użycia: Atakowanie
Opis: Gracz powinien móc wykonać atak
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w świecie gry, gra nie jest zapałzowana, poza chatką
    1. Gracz naciska przycisk ataku 
    2. System odtwarza animację ataku 
    3. System sprawdza czy atak trafia
    4. Jeśli atak trafił, system wydaje sygnał do zaatakowanego obiektu z informacją o sile ataku i jego typie (być może) 
Scenariusze alternatywne:
Brak

Przypadek użycia: Bycie zaatakowanym
Opis: Każdy obiekt który może zostać zaatakowany powinien móc obsługiwać sygnał zostania zaatakowanym
Aktorzy: Obiek który może zostać zaatakowany (np. przeciwnik, gracz, pudełko, drzwi)
Warunki wstępne: Gra nie jest zapałzowana, obiekt który można zaatakować odbiera sygnał o ataku.
    1. System oblicza ilość rzeczywistych obrażeń otrzymanych przez obiekt
    2. System nakłada na obiekt odpowiednie efekty w zależności od tego, czy mogą zostać nałożone (drzwi nie mogą zostać otrute, tak samo jak szkielet nie może krwawić)
    3. System sprawdza obecny poziom życia obiektu, jeżeli jest mniejszy od zera, system zabija przeciwnika
Scenariusze alternatywne:
Jeżeli zaatakowanym obiektem jest gracz, to system wykonuje animację otrzymania obrażeń - ekran się trzęsie, maluje na czerwono, czy coś

Przypadek użycia: Pokonanie przeciwnika
Opis: Po pokonaniu przeciwnika gracz otrzymuje nagrody.
Aktorzy: Gracz, Przeciwnik
Warunki wstępne: Przeciwnik ma 0 punktów życia
    1. Przeciwnik odtwarza animację śmierci 
    2. System dodaje nagrody do ekwipunku gracza 
    3. System usuwa przeciwnika z otoczenia 
Scenariusze alternatywne:
Brak

Przypadek użycia: Postać gracza umiera
Opis: Po otrzymaniu zbyt wielu obrażeń postać gracza może umrzeć
Aktorzy: Gracz
Warunki wstępne: Postać gracza otrzymała zbyt dużo obrażeń
    1. System wyświetla na ekranie menu, z informacją o długości gry, pokonanych przeciwnikach, zbadanych grzybach etc.
    2. System wyświetla na ekranie guziki: nowa gra, powrót do menu głównego, podziel się ze znajomymi
    3. System obsługuje odpowiednie guziki
Scenariusze alternatywne:
Brak

Przypadek użycia: Przeglądanie katalogu grzybów
Opis: Gracz powinien móc sprawdzić informacje o znalezionych grzybach.
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w chatce, albo świecie gry
    1. Gracz kilka przycisk do otwierania katalogu
    2. System wyświetla listę napotkanych grzybów i efektów mikstur, które zostały z nich utworzone
Scenariusze alternatywne:
Brak

Przypadek użycia: określanie gatunków grzybów przez gracza
Opis: Gracz powinien móc na podstawie swoich obserwacji określać gatunki grzybów i zapisywać swoje spostrzeżenia w katalogu
Aktorzy: Gracz
Warunki wstępne: Gracz znajduje się w menu katalogu
    1. Gracz wybiera interesującego go grzyba
    2. Gracz klika na guzik "określ gatunek"
    3. System wyświetla menu określenia gatunku
    4. Gracz wybiera gatunek z listy lub dodaje nową nazwę
    5. System przypisuje gatunek grzybowi
Scenariusze alternatywne:
Gracz dodał nazwę, która już istnieje, wtedy system wyświetla informację o błędzie i pozwala graczowi jeszcze raz wybrać nazwę


      
2. Wykonanie diagramu (diagramów) przypadków użycia (reprezentującego specyfikację wymagań
funkcjonalnych sporządzoną w poprzednim ćwiczeniu) na podstawie scenariuszy z punktu pierwszego.
Do tego celu należy użyć języka UML. Może być jeden ogromniasty diagram dla wszystkich przypadków
lub też osobne diagramy dla każdego przypadku. Czasami lepiej jest wybrać pierwszą opcję, czasami
drugą, w zależności, jakie wymagania odnośnie systemu macie.

@startuml
left to right direction
actor Gracz
rectangle system{
    usecase "Rozpoczęcie nowej gry" as UC1
    usecase "Otwarcie menu pauzy" as UC2
    usecase "Zamknięcie menu pauzy" as UC3
    usecase "Wczytanie rozgrywki" as UC4
    usecase "Zmiana Ustawień" as UC5
}
rectangle aktywna_rozgrywka{
    usecase "Zbieranie grzyba" as UC6
    usecase "Użycie mikstury/grzyba" as UC7
    usecase "Wejście do chatki" as UC8
    usecase "Wyjście z chatki" as UC9
    usecase "poruszanie się po mapie" as UC15
}
rectangle alchemia{
    usecase "Przeglądanie katalogu grzybów" as UC10
    usecase "Określanie gatunków grzybów" as UC13
    usecase "Warzenie mikstury" as UC14
}

rectangle walka{
    usecase "Atakowanie przeciwnika" as UC11
    usecase "Pokonanie przeciwnika" as UC12
}


Gracz --> UC1
Gracz --> UC2
Gracz --> UC3
Gracz --> UC4
Gracz --> UC5
Gracz --> UC6
Gracz --> UC7
Gracz --> UC8
Gracz --> UC9
Gracz --> UC10
Gracz --> UC11
Gracz --> UC12
Gracz --> UC13
Gracz --> UC14
Gracz --> UC15
@enduml


@startuml
left to right direction
actor Gracz

usecase "Menu" as M
    usecase "Rozpoczęcie nowej gry" as UC1
    usecase "Otwarcie menu pauzy" as UC2
    usecase "Zamknięcie menu pauzy" as UC3
    usecase "Wznowienie rozgrywki" as UC4
    usecase "Zmiana ustawień" as UC14
usecase "eksploracja" as E
    usecase "Zbieranie grzyba" as UC5
    usecase "Użycie mikstury/grzyba" as UC7
    usecase "Wejście do chatki" as UC8
    usecase "Wyjście z chatki" as UC9
    usecase "przemieszczanie się po mapie" as UC13
usecase "alchemia" as A
    usecase "Przeglądanie katalogu grzybów" as UC10
    usecase "Warzenie mikstury" as UC6
    usecase "określanie gatunków grzybów" as UC15    
usecase "walka" as W
    usecase "Atakowanie przeciwnika" as UC11
    usecase "Pokonanie przeciwnika" as UC12


Gracz --> M
M --> UC1
M --> UC4
UC4 --> E
M --> UC14
UC1 --> E
E --> UC5
E --> UC7
E --> UC8
E --> W
E --> UC2
E --> UC13
UC2 --> UC3
UC3 --> E
UC2 --> M
UC8 --> A 
A --> UC9
A --> UC10
A --> UC6
A--> UC15

W --> UC11
UC11 --> UC12
@enduml


