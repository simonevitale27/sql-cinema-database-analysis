Raccolta di 36 query SQL progettate per estrarre insight da un database relazionale composto da 5 tabelle (Attori, Recita, Film, Proiezioni, Sale, Registi). Il focus è sulla risoluzione di problemi logici complessi e sull'ottimizzazione dell'estrazione dati.

Schema E/R
- ATTORI (CodAttore, Nome, AnnoNascita, Nazionalità)
- RECITA (CodAttore, IdFilm)
- FILM (CodFilm, Titolo, AnnoProduzione, Nazionalità, Regista, Genere)
- PROIEZIONI (CodProiezione, IdFilm, CodSala, Incasso, DataProiezione)
- SALE (CodSala, Posti, Nome, Città)
- REGISTI (CodRegista, Nome)

Competenze Tecniche Dimostrate
Join Complesse: Utilizzo di INNER, LEFT e FULL JOIN per collegare fino a 4 tabelle simultaneamente.
Subquery: Implementazione di subquery correlate e annidate con operatori IN, NOT IN, EXISTS.
Logica Condizionale: Filtraggio avanzato tramite clausole WHERE e operatori di confronto.
Insiemistica: Gestione di esclusioni totali e intersezioni di dati.
Aggregazioni: Analisi di incassi e performance.
Organizzazione dei File
/scripts: Contiene i file .sql con le query commentate.
/database: Contiene il file dump_cinema.sql per la replica dell'ambiente.

Requisiti
Server SQL (MySQL, PostgreSQL o SQL Server).
Database client (DBeaver, MySQL Workbench).
