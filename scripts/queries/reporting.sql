-- Query for Japanese Restaurants by Area
SELECT COUNT(Restaurant.IdRestaurant) AS RestaurantsJapanese
FROM Restaurant
         JOIN City ON Restaurant.TypeCooking = 'Japanese'
    AND City.NameCity = Restaurant.NameCity
         JOIN Area ON Area.Description = 'Llevant is a Mallorcan region that includes the east of the
island of Mallorca'
    AND Area.NameArea = City.NameArea;

-- Query for Restaurants with Specific Menu on a Given Date
SELECT Restaurant.NameRest, Restaurant.Telephone, Restaurant.Address
FROM menu
         JOIN Offer ON Offer.Date = '2024-03-02'
    AND menu.NameDish1 = 'Arros Brut'
    AND menu.NameDish2 = 'Porcella'
    AND menu.Dessert = 'Pijama'
    AND Offer.IdOffer = menu.IdMenu
         JOIN Restaurant ON Restaurant.IdRestaurant = Offer.IdRest;

-- Show list of the Restaurants that don’t offer Paella as a first dish
SELECT DISTINCT Restaurant.IdRestaurant, Restaurant.NameRest, Restaurant.Telephone,
                Restaurant.Address, Restaurant.NameCity, Restaurant.Forks FROM
    Restaurant
        LEFT JOIN (
        SELECT Offer.IdOffer, Offer.IdRest FROM
            menu
                JOIN Offer ON menu.NameDish1 = 'Paella'
                AND Offer.IdOffer = menu.IdMenu
    ) AS OfertesPrPaella
                  ON Restaurant.IdRestaurant = OfertesPrPaella.IdRest
WHERE OfertesPrPaella.IdOffer IS NULL

-- Query to Find Restaurants Not Offering Paella
SELECT DISTINCT Restaurant.IdRestaurant, Restaurant.NameRest, Restaurant.Telephone,
                Restaurant.Address, Restaurant.NameCity, Restaurant.Forks
FROM Restaurant
         LEFT JOIN(
    (
        SELECT Offer.IdOffer, Offer.IdRest, menu.IdMenu FROM
            menu
                JOIN Offer ON (
                                  menu.NameDish1 = 'Paella'
                                      OR menu.NameDish2 = 'Paella'
                                      OR menu.Dessert = 'Paella'
                                  )
                AND Offer.IdOffer = menu.IdMenu
    ) UNION (
        SELECT Offer.IdOffer, Offer.IdRest, DishDay.IdPdd FROM
            DishDay
                JOIN Offer ON DishDay.NameDish = 'Paella'
                AND Offer.IdOffer = DishDay.IdPdd
    )
)AS OffersWithPaella
                  ON Restaurant.IdRestaurant = OffersWithPaella.IdRest
WHERE OffersWithPaella.IdOffer IS NULL
ORDER BY (Restaurant.NameCity);

-- Show restaurants, and kitchen style that an a specific date, they offer the same dish in menu and dish of the day
SELECT Restaurant.NameRest, Restaurant.TypeCooking
FROM(
        (
            SELECT Offer.*, menu.NameDish1, menu.NameDish2, menu.Dessert FROM menu
                                                                                  JOIN Offer ON Offer.IdOffer = menu.IdMenu
            WHERE Offer.Date = '2024-03-02'
        ) AS OfertesMenu
            JOIN(
            48
SELECT Offer.*,DishDay.NameDish from DishDay
JOIN Offer ON Offer.IdOffer = DishDay.IdPdd
WHERE Offer.Date = '2024-03-02'
) AS OfertesPdd
            ON (
                   OfertesMenu.NameDish1 = OfertesPdd.NameDish
                       OR OfertesMenu.NameDish2 = OfertesPdd.NameDish
                       OR OfertesMenu.Dessert = OfertesPdd.NameDish
                   )
                AND OfertesMenu.IdRest = OfertesPdd.IdRest
            JOIN Restaurant ON Restaurant.IdRestaurant = OfertesMenu.IdRest
        )

-- Best afgan restaurant in Palma by the evaluations.
SELECT Rest_Afgan_Palma.NameRest, Scorens_Restaurants
FROM (
         SELECT Restaurant.NameRest, Restaurant.IdRestaurant
         FROM Restaurant
         WHERE Restaurant.TypeCooking = 'Afgan' AND Restaurant.NameCity = 'Palma'
     ) AS Rest_Afgan_Palma
         JOIN (
    SELECT Offer_Amb_Score.IdRest, AVG(Score) AS Scorens_Restaurants
    FROM
        (
            SELECT Offer.IdRest, AVG(Evaluation.Score) AS Score
            FROM Evaluation
                     JOIN Offer ON Offer.IdOffer = Evaluation.IdOffer
            GROUP BY (Evaluation.IdOffer)
        ) AS Offer_Amb_Score
    GROUP By (Offer_Amb_Score.IdRest)
) AS AVG_Offer_Amb_Score
              ON Rest_Afgan_Palma.IdRestaurant = AVG_Offer_Amb_Score.IdRest
ORDER BY (Scorens_Restaurants) DESC
LIMIT 1

-- For night time zone, and a specific date, show all the restaurants of Mallorcan style with 3 forks from Binissalem, with their dish day menu and the menu.
SELECT Restaurant.IdRestaurant, Restaurant.NameRest,
       Restaurant.NameCity,Restaurant.Forks,Restaurant.TypeCooking, menu.*,DishDay.*
FROM Restaurant
         JOIN Offer ON Restaurant.Forks > 3
    AND Restaurant.NameCity = 'Binissalem'
    AND Offer.Time_Zone = 'Night'
    AND Restaurant.TypeCooking = 'Mallorquina'
    AND Offer.Date = '2024-10-08'
    AND Restaurant.IdRestaurant = Offer.IdRest
         LEFT JOIN DishDay ON DishDay.IdPdd = Offer.IdOffer
         LEFT JOIN menu ON menu.IdMenu = Offer.IdOffer

-- Restaurants that only have five score in their offers.
SELECT NameRest
FROM restaurant
WHERE (EXISTS (SELECT *
               FROM offer
               WHERE (offer.IdOffer = ANY (SELECT evaluation.IdOffer
                                           FROM evaluation
                                           WHERE Score = 5)
                   ) AND (offer.IdRest = restaurant.IdRestaurant)
)
          );