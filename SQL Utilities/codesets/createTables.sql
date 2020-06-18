use jack;

drop table if exists code_set_codes;
drop table if exists code_set;

CREATE TABLE `code_set` (
   `id` int(11) NOT NULL,
   `name` varchar(255) NOT NULL,
   PRIMARY KEY (`id`),
   UNIQUE KEY `name_unique` (`name`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE code_set_codes (
  code_set_id int(11) NOT NULL,
  read2_code varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NULL,
  ctv3_code varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NULL,
  description varchar(255) NULL,
  CONSTRAINT `code_set_id_fk` FOREIGN KEY (`code_set_id`) REFERENCES `code_set` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
