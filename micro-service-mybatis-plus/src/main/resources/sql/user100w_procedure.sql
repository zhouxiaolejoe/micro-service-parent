DROP PROCEDURE IF EXISTS add_user;
DELIMITER //
    create PROCEDURE add_user(in num INT)
    BEGIN
        DECLARE rowid INT DEFAULT 0;
        DECLARE firstname CHAR(1);
        DECLARE name1 CHAR(1);
        DECLARE name2 CHAR(1);
        DECLARE lastname VARCHAR(3) DEFAULT '';
        DECLARE sex CHAR(1);
        DECLARE score CHAR(2);
        SET @exedata = "";
        WHILE rowid < num DO
            SET firstname = SUBSTRING('赵钱孙李周吴郑王林杨柳刘孙陈江阮侯邹高彭徐',FLOOR(1+21*RAND()),1);
            SET name1 = SUBSTRING('一二三四五六七八九十甲乙丙丁静景京晶名明铭敏闵民军君俊骏天田甜兲恬益依成城诚立莉力黎励',ROUND(1+43*RAND()),1);
            SET name2 = SUBSTRING('一二三四五六七八九十甲乙丙丁静景京晶名明铭敏闵民军君俊骏天田甜兲恬益依成城诚立莉力黎励',ROUND(1+43*RAND()),1);
            SET sex=FLOOR(0 + (RAND() * 2));
            SET score= FLOOR(40 + (RAND() *60));
            SET rowid = rowid + 1;
            IF ROUND(RAND())=0 THEN
            SET lastname =name1;
            END IF;
            IF ROUND(RAND())=1 THEN
            SET lastname = CONCAT(name1,name2);
            END IF;
            IF length(@exedata)>0 THEN
            SET @exedata = CONCAT(@exedata,',');
            END IF;
            SET @exedata=concat(@exedata,"('",firstname,"','",lastname,"','",sex,"','",score,"','",rowid,"')");
            IF rowid%1000=0
            THEN
                SET @exesql =concat("insert into user100w(first_name,last_name,sex,score,copy_id) values ", @exedata);
                prepare stmt from @exesql;
                execute stmt;
                DEALLOCATE prepare stmt;
                SET @exedata = "";
            END IF;
        END WHILE;
        IF length(@exedata)>0
        THEN
            SET @exesql =concat("insert into user100w(first_name,last_name,sex,score,copy_id) values ", @exedata);
            prepare stmt from @exesql;
            execute stmt;
            DEALLOCATE prepare stmt;
        END IF;
    END //
DELIMITER ;