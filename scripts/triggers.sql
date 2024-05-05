-- Trigger 1: Check Evaluation Date
DELIMITER $$
CREATE TRIGGER CheckEvaluationDate
    BEFORE INSERT ON Evaluation
    FOR EACH ROW
BEGIN
    DECLARE v_offer_date DATE;
    SELECT Date INTO v_offer_date FROM Offer WHERE IdOffer = NEW.IdOffer;
    IF NEW.Date < v_offer_date THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Evaluation date must be on or after the offer date';
    END IF;
END$$
DELIMITER ;

-- Trigger 2: Validate Forks Rating for Restaurant
DELIMITER $$
CREATE TRIGGER ValidateForksRating
    BEFORE INSERT OR UPDATE ON Restaurant
    FOR EACH ROW
BEGIN
    IF NEW.Forks < 1 OR NEW.Forks > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Forks rating must be between 1 and 5';
END IF;
END$$
DELIMITER ;

-- Trigger 3: Validate Score of Evaluation
DELIMITER $$
CREATE TRIGGER ValidateEvaluationScore
    BEFORE INSERT OR UPDATE ON Evaluation
    FOR EACH ROW
BEGIN
    IF NEW.Score < 1 OR NEW.Score > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Evaluation score must be between 1 and 5';
END IF;
END$$
DELIMITER ;

-- Trigger 4: Validate Offer Date
DELIMITER $$
CREATE TRIGGER ValidateOfferDate
    BEFORE INSERT OR UPDATE ON Offer
    FOR EACH ROW
BEGIN
    IF NEW.Date < (CURDATE() + INTERVAL 2 WEEK) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Offer date must be at least two weeks from today';
END IF;
END$$
DELIMITER ;