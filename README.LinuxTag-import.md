Um LinuxTag vCC Daten zu importieren erwartet dieser branch von frab folgenden Eintrag in der Datei `config/database.yml` :

    lt13_development:
      adapter: postgresql
      database: lt13

Es wird also eine Postgres Datenbank mit dem Namen lt13 erwartet, die die vCC Daten des Jahres 2013 enthält.

Es wird also eine Postgres Datenbank mit dem Namen lt13 erwartet, die die vCC Daten des Jahres 2013 enthält.

Den Import kann man dann mit folgendem Befehlt starten:

    rake vcc:lt13:import

Zur Zeit ist das nur ein proof-of-concept. 

