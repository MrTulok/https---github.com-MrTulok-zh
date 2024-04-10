select round(avg(CSILLAGOK_SZAMA) over(PARTITION by TIPUS, HELY),2), SZALLAS_NEV
FROM Szallashely
where SZALLAS_NEV not like '%-%'

select szoba_fk,
    FELNOTT_SZAM + GYERMEK_SZAM as 'férőhely', 
    dense_RANK() over(order by count(*) desc, (FELNOTT_SZAM + GYERMEK_SZAM),szoba_fk) as 'rangsor'
from Foglalas
GROUP BY SZOBA_FK, FELNOTT_SZAM + GYERMEK_SZAM

select f.*,
    v.NEV,
    AVG(f.FELNOTT_SZAM+f.GYERMEK_SZAM) over(partition by f.ugyfel_fk order by f.UGYFEL_FK rows between 3 preceding and 1 preceding)
from Foglalas f join Vendeg v on f.UGYFEL_FK = v.USERNEV
where f.FELNOTT_SZAM + f.GYERMEK_SZAM <
(
    select AVG(f2.FELNOTT_SZAM+f2.GYERMEK_SZAM)
    from Foglalas f2
)