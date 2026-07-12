# Lab · eSignature schvalovací flow

> Modul: eSignature · Odhad: 25 min · Režim: simulace (zapnutí služby = admin operace)

## Cíl

Navrhnout kompletní podpisový proces pro konkrétní scénář — od požadavku po archivaci — a rozhodnout Microsoft vs. partner provider.

## Zadání

Scénář: **dodavatelská smlouva** — interní schvalovatel (vedoucí nákupu) + externí podepisující (jednatel dodavatele, mimo tenant).

## Kroky

1. Rozepiš flow do fází: příprava dokumentu → interní schválení → podpisový request → podpis → uložení → audit. U každé fáze urči nástroj (Approvals vs. eSignature) a aktéra.
2. Rozhodni provider: Microsoft eSignature vs. Adobe/Docusign. Zapiš 2 argumenty pro svou volbu (nápověda: externí strana, existující licence, PAYG náklady).
3. Vyřeš externí podepisující: co musí být v tenantu povoleno? (Entra B2B pro SharePoint/OneDrive.)
4. Urči, kde skončí podepsaný dokument a jak dlouho se drží pracovní kopie (retence vs. výchozích 5 let).
5. Napiš, jak podpis dohledáš za půl roku (Purview Audit, `eSignature*`).

## Ověření

- [ ] Flow má všech 6 fází s aktéry a nástroji.
- [ ] Volba providera má 2 věcné argumenty.
- [ ] B2B předpoklad je identifikovaný.
- [ ] Auditní dohledání je konkrétní (kde a co hledat).

## Fallback

- Když je v tenantu eSignature zapnuté a zbývá čas: instruktor předvede živý request na testovacím PDF; studenti sledují notifikaci a audit trail.
