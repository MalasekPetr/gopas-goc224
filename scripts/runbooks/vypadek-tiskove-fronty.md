# Runbook · Výpadek tiskové fronty na pobočce

**Kategorie:** Incident · **Demo data — fiktivní**

## Příznak
Tisková fronta na pobočce nereaguje, úlohy zůstávají ve stavu „Pending" a netisknou se.

## Rychlá diagnostika
1. Ověř, že **tiskový server / spooler služba** běží (`Print Spooler`).
2. Ověř síťovou dostupnost tiskárny (ping, web rozhraní tiskárny).
3. Zkontroluj, zda fronta není zaseknutá na jedné vadné úloze.

## Řešení
1. Restartuj službu **Print Spooler** na tiskovém serveru.
2. Pokud fronta drží na jedné úloze, **smaž zaseknutou úlohu** a nech ostatní proběhnout.
3. Když tiskárna není dostupná po síti, ověř napájení a síťový kabel/switch port na pobočce.

## Kdy založit tiket
Pokud výpadek trvá > 30 min nebo se opakuje → tiket, priorita **P2**, útvar **IT / pobočka**.
