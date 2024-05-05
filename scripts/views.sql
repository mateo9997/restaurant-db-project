-- View for Best Restaurants by User Opinion
CREATE VIEW Best_Rest_UserOpinion AS
SELECT Restaurant.NameRest, Restaurant.Telephone, Restaurant.Address,
       Restaurant.NameCity, AVG(Evaluation.Score) AS AVGScore
FROM Evaluation
         JOIN Offer ON Offer.IdOffer = Evaluation.IdOffer
         JOIN Restaurant ON Restaurant.IdRestaurant = Offer.IdRest
GROUP BY Restaurant.NameRest
ORDER BY AVGScore DESC;

-- View for Quantity of Restaurants by Area and Forks
CREATE VIEW Q_Rest_byArea AS
SELECT COUNT(Restaurant.IdRestaurant) AS Quantity, Restaurant.Forks, City.NameArea
FROM Restaurant
         JOIN City ON Restaurant.NameCity = City.NameCity
         JOIN KitchenStyle ON (KitchenStyle.TypeCooking = 'Asian' OR KitchenStyle.SubtypeC = 'Asian')
    AND Restaurant.TypeCooking = KitchenStyle.TypeCooking
GROUP BY Restaurant.Forks, City.NameArea
ORDER BY City.NameArea, Restaurant.Forks;

-- Asiatic restaurants by area
CREATE VIEW Q_Rest_byArea AS
SELECT COUNT(Restaurant.IdRestaurant) AS Quantitity,Restaurant.Forks,City.NameArea
FROM Restaurant
         JOIN City ON Restaurant.NameCity=City.NameCity
         JOIN KitchenStyle ON (KitchenStyle.TypeCooking='Asian' OR KitchenStyle.SubtypeC='Asian')
    AND Restaurant.TypeCooking=KitchenStyle.TypeCooking
GROUP BY Restaurant.Forks,City.NameArea
ORDER BY City.NameArea, Restaurant.Forks


