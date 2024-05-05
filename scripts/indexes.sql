-- Indexes for the City table
CREATE INDEX idx_namearea ON City(NameArea);

-- Indexes for the Restaurant table
CREATE INDEX idx_namecity ON Restaurant(NameCity);
CREATE INDEX idx_typecooking ON Restaurant(TypeCooking);

-- Indexes for the Area table
CREATE INDEX idx_description ON Area(Description);

-- Indexes for the Offer table
CREATE INDEX idx_idrest ON Offer(IdRest);
CREATE INDEX idx_timezone ON Offer(Time_Zone);
CREATE INDEX idx_date ON Offer(Date);

-- Indexes for the Evaluation table
CREATE INDEX idx_idoffer ON Evaluation(IdOffer);
CREATE INDEX idx_score ON Evaluation(Score);

-- Indexes for the Menu table
CREATE INDEX idx_namedish1 ON Menu(NameDish1);
CREATE INDEX idx_namedish2 ON Menu(NameDish2);
CREATE INDEX idx_dessert ON Menu(Dessert);
CREATE INDEX idx_namedish ON Menu(NameDish1, NameDish2, Dessert);

-- Indexes for the DishDay table
CREATE INDEX idx_name_dish ON DishDay(NameDish);
CREATE INDEX idx_idpdd ON DishDay(IdPdd);

-- Indexes for the Person table
CREATE INDEX idx_idrestaurant ON Person(IdRestaurant);


