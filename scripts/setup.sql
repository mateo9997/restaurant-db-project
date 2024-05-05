CREATE TABLE Area(
                     NameArea char(20) PRIMARY KEY,
                     Description char(150)
);
CREATE TABLE City(
                     NameCity char(15) PRIMARY KEY,
                     NameArea char(20) NOT NULL,
                     FOREIGN KEY (NameArea) REFERENCES Area(NameArea)
);
CREATE TABLE KitchenStyle(
                             TypeCooking char(15) PRIMARY KEY,
                             SubtypeC  char(15),
                             FOREIGN KEY (SubtypeC) REFERENCES KitchenStyle(TypeCooking)
);


CREATE TABLE Restaurant(
                           IdRestaurant int PRIMARY KEY,
                           NameRest char(15),
                           Telephone int,
                           Address char(30),
                           Forks int,
                           NameCity char(15) NOT NULL,
                           TypeCooking char(15) NOT NULL,
                           FOREIGN KEY (TypeCooking) REFERENCES KitchenStyle(TypeCooking),
                           FOREIGN KEY (NameCity) REFERENCES City(NameCity)
);
CREATE TABLE TimeZone(
                         Time_Zone char(15) PRIMARY KEY
);
CREATE TABLE Offer(
                      IdOffer int PRIMARY KEY,
                      Coffee boolean,
                      Drink boolean,
                      Date Date,
                      Price float,
                      IdRest int NOT NULL,
                      Time_Zone char(15) NOT NULL,
                      FOREIGN KEY (IdRest) REFERENCES Restaurant(IdRestaurant),
                      FOREIGN KEY (Time_Zone) REFERENCES TimeZone(Time_Zone));
CREATE TABLE Evaluation(
                           IdEvaluation int PRIMARY KEY,
                           Date Date,
                           Score int,
                           IdOffer int NOT NULL,
                           FOREIGN KEY (IdOffer) REFERENCES Offer(IdOffer)
);

CREATE TABLE Dish(
                     NameDish char(50) PRIMARY KEY,
                     Description char(150)
);

CREATE TABLE Menu(
                     IdMenu int PRIMARY KEY,
                     NameDish1 char(50) NOT NULL,
                     NameDish2 char(50) NOT NULL,
                     Dessert char(50) NOT NULL,
                     FOREIGN KEY (NameDish1) REFERENCES Dish(NameDish),
                     FOREIGN KEY (NameDish2) REFERENCES Dish(NameDish),
                     FOREIGN KEY (Dessert) REFERENCES Dish(NameDish),
                     FOREIGN KEY (IdMenu) REFERENCES Offer(IdOffer)
);

CREATE TABLE DishDay(
                        IdPdd int PRIMARY KEY,
                        NameDish char(50) NOT NULL,
                        FOREIGN KEY (IdPdd) REFERENCES Offer(IdOffer),
                        FOREIGN Key (NameDish) REFERENCES Dish(NameDish)
);


CREATE TABLE DishPhoto(
                          IdRest int,
                          NameDish char(50),
                          Photo blob,
                          PRIMARY KEY(IdRest,NameDish),
                          FOREIGN KEY (IdRest) REFERENCES Restaurant(IdRestaurant),
                          FOREIGN KEY (NameDish) REFERENCES Dish(NameDish)
);


CREATE TABLE Person(
                       IdPerson int,
                       NamePerson char(50),
                       Surname char(50),
                       IdRestaurant int,
                       PRIMARY KEY(IdPerson),
                       FOREIGN KEY (IdRestaurant) REFERENCES Restaurant(IdRestaurant)
);
CREATE TABLE Service(
                        IdService int,
                        Date Date,
                        Mark int,
                        IdPerson int,
                        PRIMARY KEY(IdService),
                        FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson)
);
CREATE TABLE Owner(
                      IdPerson int,
                      PRIMARY KEY(IdPerson),
                      FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson)
);
CREATE TABLE Manager(
                        IdPerson int,
                        PRIMARY KEY(IdPerson),
                        FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson)
);
CREATE TABLE Waiter(
                       IdPerson int,
                       PRIMARY KEY(IdPerson),
                       FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson)
);
CREATE TABLE Chef(
                     IdPerson int,
                     PRIMARY KEY(IdPerson),
                     FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson)
);
CREATE TABLE Cook(
                     IdPerson int,
                     PRIMARY KEY(IdPerson),
                     FOREIGN KEY (IdPerson) REFERENCES Person(IdPerson)
);
