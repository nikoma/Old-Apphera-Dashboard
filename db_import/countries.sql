--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;


CREATE TABLE countries (
    id integer NOT NULL,
    iso_code_two_letter character varying(255) NOT NULL,
    iso_code_three_letter character varying(255) NOT NULL,
    iso_number integer NOT NULL,
    name character varying(255) NOT NULL,
    capital character varying(255),
    area_in_square_km integer,
    population integer,
    continent character varying(255),
    currency_code character varying(255),
    currency_name character varying(255),
    phone character varying(255),
    languages character varying(255),
    geonames_id integer
);




CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE countries_id_seq OWNED BY countries.id;



ALTER TABLE ONLY countries ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);



INSERT INTO countries VALUES (1, 'AD', 'AND', 20, 'Andorra', 'Andorra la Vella', 468, 84000, 'EU', 'EUR', 'Euro', '376', 'ca', 3041565);
INSERT INTO countries VALUES (2, 'AE', 'ARE', 784, 'United Arab Emirates', 'Abu Dhabi', 82880, 4975593, 'AS', 'AED', 'Dirham', '971', 'ar-AE,fa,en,hi,ur', 290557);
INSERT INTO countries VALUES (3, 'AF', 'AFG', 4, 'Afghanistan', 'Kabul', 647500, 29121286, 'AS', 'AFN', 'Afghani', '93', 'fa-AF,ps,uz-AF,tk', 1149361);
INSERT INTO countries VALUES (4, 'AG', 'ATG', 28, 'Antigua and Barbuda', 'St. John''s', 443, 86754, 'NA', 'XCD', 'Dollar', '+1-268', 'en-AG', 3576396);
INSERT INTO countries VALUES (5, 'AI', 'AIA', 660, 'Anguilla', 'The Valley', 102, 13254, 'NA', 'XCD', 'Dollar', '+1-264', 'en-AI', 3573511);
INSERT INTO countries VALUES (6, 'AL', 'ALB', 8, 'Albania', 'Tirana', 28748, 2986952, 'EU', 'ALL', 'Lek', '355', 'sq,el', 783754);
INSERT INTO countries VALUES (7, 'AM', 'ARM', 51, 'Armenia', 'Yerevan', 29800, 2968000, 'AS', 'AMD', 'Dram', '374', 'hy', 174982);
INSERT INTO countries VALUES (8, 'AO', 'AGO', 24, 'Angola', 'Luanda', 1246700, 13068161, 'AF', 'AOA', 'Kwanza', '244', 'pt-AO', 3351879);
INSERT INTO countries VALUES (9, 'AQ', 'ATA', 10, 'Antarctica', '', 14000000, 0, 'AN', '', '', '', '', 6697173);
INSERT INTO countries VALUES (10, 'AR', 'ARG', 32, 'Argentina', 'Buenos Aires', 2766890, 41343201, 'SA', 'ARS', 'Peso', '54', 'es-AR,en,it,de,fr,gn', 3865483);
INSERT INTO countries VALUES (11, 'AS', 'ASM', 16, 'American Samoa', 'Pago Pago', 199, 57881, 'OC', 'USD', 'Dollar', '+1-684', 'en-AS,sm,to', 5880801);
INSERT INTO countries VALUES (12, 'AT', 'AUT', 40, 'Austria', 'Vienna', 83858, 8205000, 'EU', 'EUR', 'Euro', '43', 'de-AT,hr,hu,sl', 2782113);
INSERT INTO countries VALUES (13, 'AU', 'AUS', 36, 'Australia', 'Canberra', 7686850, 21515754, 'OC', 'AUD', 'Dollar', '61', 'en-AU', 2077456);
INSERT INTO countries VALUES (14, 'AW', 'ABW', 533, 'Aruba', 'Oranjestad', 193, 71566, 'NA', 'AWG', 'Guilder', '297', 'nl-AW,es,en', 3577279);
INSERT INTO countries VALUES (15, 'AX', 'ALA', 248, 'Aland Islands', 'Mariehamn', NULL, 26711, 'EU', 'EUR', 'Euro', '+358-18', 'sv-AX', 661882);
INSERT INTO countries VALUES (16, 'AZ', 'AZE', 31, 'Azerbaijan', 'Baku', 86600, 8303512, 'AS', 'AZN', 'Manat', '994', 'az,ru,hy', 587116);
INSERT INTO countries VALUES (17, 'BA', 'BIH', 70, 'Bosnia and Herzegovina', 'Sarajevo', 51129, 4590000, 'EU', 'BAM', 'Marka', '387', 'bs,hr-BA,sr-BA', 3277605);
INSERT INTO countries VALUES (18, 'BB', 'BRB', 52, 'Barbados', 'Bridgetown', 431, 285653, 'NA', 'BBD', 'Dollar', '+1-246', 'en-BB', 3374084);
INSERT INTO countries VALUES (19, 'BD', 'BGD', 50, 'Bangladesh', 'Dhaka', 144000, 156118464, 'AS', 'BDT', 'Taka', '880', 'bn-BD,en', 1210997);
INSERT INTO countries VALUES (20, 'BE', 'BEL', 56, 'Belgium', 'Brussels', 30510, 10403000, 'EU', 'EUR', 'Euro', '32', 'nl-BE,fr-BE,de-BE', 2802361);
INSERT INTO countries VALUES (21, 'BF', 'BFA', 854, 'Burkina Faso', 'Ouagadougou', 274200, 16241811, 'AF', 'XOF', 'Franc', '226', 'fr-BF', 2361809);
INSERT INTO countries VALUES (22, 'BG', 'BGR', 100, 'Bulgaria', 'Sofia', 110910, 7148785, 'EU', 'BGN', 'Lev', '359', 'bg,tr-BG', 732800);
INSERT INTO countries VALUES (23, 'BH', 'BHR', 48, 'Bahrain', 'Manama', 665, 738004, 'AS', 'BHD', 'Dinar', '973', 'ar-BH,en,fa,ur', 290291);
INSERT INTO countries VALUES (24, 'BI', 'BDI', 108, 'Burundi', 'Bujumbura', 27830, 9863117, 'AF', 'BIF', 'Franc', '257', 'fr-BI,rn', 433561);
INSERT INTO countries VALUES (25, 'BJ', 'BEN', 204, 'Benin', 'Porto-Novo', 112620, 9056010, 'AF', 'XOF', 'Franc', '229', 'fr-BJ', 2395170);
INSERT INTO countries VALUES (26, 'BL', 'BLM', 652, 'Saint Barthelemy', 'Gustavia', 21, 8450, 'NA', 'EUR', 'Euro', '590', 'fr', 3578476);
INSERT INTO countries VALUES (27, 'BM', 'BMU', 60, 'Bermuda', 'Hamilton', 53, 65365, 'NA', 'BMD', 'Dollar', '+1-441', 'en-BM,pt', 3573345);
INSERT INTO countries VALUES (28, 'BN', 'BRN', 96, 'Brunei', 'Bandar Seri Begawan', 5770, 395027, 'AS', 'BND', 'Dollar', '673', 'ms-BN,en-BN', 1820814);
INSERT INTO countries VALUES (29, 'BO', 'BOL', 68, 'Bolivia', 'Sucre', 1098580, 9947418, 'SA', 'BOB', 'Boliviano', '591', 'es-BO,qu,ay', 3923057);
INSERT INTO countries VALUES (30, 'BQ', 'BES', 535, 'Bonaire, Saint Eustatius and Saba ', '', NULL, 18012, 'NA', 'USD', 'Dollar', '599', 'nl,pap,en', 7626844);
INSERT INTO countries VALUES (31, 'BR', 'BRA', 76, 'Brazil', 'Brasilia', 8511965, 201103330, 'SA', 'BRL', 'Real', '55', 'pt-BR,es,en,fr', 3469034);
INSERT INTO countries VALUES (32, 'BS', 'BHS', 44, 'Bahamas', 'Nassau', 13940, 301790, 'NA', 'BSD', 'Dollar', '+1-242', 'en-BS', 3572887);
INSERT INTO countries VALUES (33, 'BT', 'BTN', 64, 'Bhutan', 'Thimphu', 47000, 699847, 'AS', 'BTN', 'Ngultrum', '975', 'dz', 1252634);
INSERT INTO countries VALUES (34, 'BV', 'BVT', 74, 'Bouvet Island', '', NULL, 0, 'AN', 'NOK', 'Krone', '', '', 3371123);
INSERT INTO countries VALUES (35, 'BW', 'BWA', 72, 'Botswana', 'Gaborone', 600370, 2029307, 'AF', 'BWP', 'Pula', '267', 'en-BW,tn-BW', 933860);
INSERT INTO countries VALUES (36, 'BY', 'BLR', 112, 'Belarus', 'Minsk', 207600, 9685000, 'EU', 'BYR', 'Ruble', '375', 'be,ru', 630336);
INSERT INTO countries VALUES (37, 'BZ', 'BLZ', 84, 'Belize', 'Belmopan', 22966, 314522, 'NA', 'BZD', 'Dollar', '501', 'en-BZ,es', 3582678);
INSERT INTO countries VALUES (38, 'CA', 'CAN', 124, 'Canada', 'Ottawa', 9984670, 33679000, 'NA', 'CAD', 'Dollar', '1', 'en-CA,fr-CA,iu', 6251999);
INSERT INTO countries VALUES (39, 'CC', 'CCK', 166, 'Cocos Islands', 'West Island', 14, 628, 'AS', 'AUD', 'Dollar', '61', 'ms-CC,en', 1547376);
INSERT INTO countries VALUES (40, 'CD', 'COD', 180, 'Democratic Republic of the Congo', 'Kinshasa', 2345410, 70916439, 'AF', 'CDF', 'Franc', '243', 'fr-CD,ln,kg', 203312);
INSERT INTO countries VALUES (41, 'CF', 'CAF', 140, 'Central African Republic', 'Bangui', 622984, 4844927, 'AF', 'XAF', 'Franc', '236', 'fr-CF,sg,ln,kg', 239880);
INSERT INTO countries VALUES (42, 'CG', 'COG', 178, 'Republic of the Congo', 'Brazzaville', 342000, 3039126, 'AF', 'XAF', 'Franc', '242', 'fr-CG,kg,ln-CG', 2260494);
INSERT INTO countries VALUES (43, 'CH', 'CHE', 756, 'Switzerland', 'Berne', 41290, 7581000, 'EU', 'CHF', 'Franc', '41', 'de-CH,fr-CH,it-CH,rm', 2658434);
INSERT INTO countries VALUES (44, 'CI', 'CIV', 384, 'Ivory Coast', 'Yamoussoukro', 322460, 21058798, 'AF', 'XOF', 'Franc', '225', 'fr-CI', 2287781);
INSERT INTO countries VALUES (45, 'CK', 'COK', 184, 'Cook Islands', 'Avarua', 240, 21388, 'OC', 'NZD', 'Dollar', '682', 'en-CK,mi', 1899402);
INSERT INTO countries VALUES (46, 'CL', 'CHL', 152, 'Chile', 'Santiago', 756950, 16746491, 'SA', 'CLP', 'Peso', '56', 'es-CL', 3895114);
INSERT INTO countries VALUES (47, 'CM', 'CMR', 120, 'Cameroon', 'Yaounde', 475440, 19294149, 'AF', 'XAF', 'Franc', '237', 'en-CM,fr-CM', 2233387);
INSERT INTO countries VALUES (48, 'CN', 'CHN', 156, 'China', 'Beijing', 9596960, 1330044000, 'AS', 'CNY', 'Yuan Renminbi', '86', 'zh-CN,yue,wuu,dta,ug,za', 1814991);
INSERT INTO countries VALUES (49, 'CO', 'COL', 170, 'Colombia', 'Bogota', 1138910, 44205293, 'SA', 'COP', 'Peso', '57', 'es-CO', 3686110);
INSERT INTO countries VALUES (50, 'CR', 'CRI', 188, 'Costa Rica', 'San Jose', 51100, 4516220, 'NA', 'CRC', 'Colon', '506', 'es-CR,en', 3624060);
INSERT INTO countries VALUES (51, 'CU', 'CUB', 192, 'Cuba', 'Havana', 110860, 11423000, 'NA', 'CUP', 'Peso', '53', 'es-CU', 3562981);
INSERT INTO countries VALUES (52, 'CV', 'CPV', 132, 'Cape Verde', 'Praia', 4033, 508659, 'AF', 'CVE', 'Escudo', '238', 'pt-CV', 3374766);
INSERT INTO countries VALUES (53, 'CW', 'CUW', 531, 'Curacao', ' Willemstad', NULL, 141766, 'NA', 'ANG', 'Guilder', '599', 'nl,pap', 7626836);
INSERT INTO countries VALUES (54, 'CX', 'CXR', 162, 'Christmas Island', 'Flying Fish Cove', 135, 1500, 'AS', 'AUD', 'Dollar', '61', 'en,zh,ms-CC', 2078138);
INSERT INTO countries VALUES (55, 'CY', 'CYP', 196, 'Cyprus', 'Nicosia', 9250, 1102677, 'EU', 'EUR', 'Euro', '357', 'el-CY,tr-CY,en', 146669);
INSERT INTO countries VALUES (56, 'CZ', 'CZE', 203, 'Czech Republic', 'Prague', 78866, 10476000, 'EU', 'CZK', 'Koruna', '420', 'cs,sk', 3077311);
INSERT INTO countries VALUES (57, 'DE', 'DEU', 276, 'Germany', 'Berlin', 357021, 81802257, 'EU', 'EUR', 'Euro', '49', 'de', 2921044);
INSERT INTO countries VALUES (58, 'DJ', 'DJI', 262, 'Djibouti', 'Djibouti', 23000, 740528, 'AF', 'DJF', 'Franc', '253', 'fr-DJ,ar,so-DJ,aa', 223816);
INSERT INTO countries VALUES (59, 'DK', 'DNK', 208, 'Denmark', 'Copenhagen', 43094, 5484000, 'EU', 'DKK', 'Krone', '45', 'da-DK,en,fo,de-DK', 2623032);
INSERT INTO countries VALUES (60, 'DM', 'DMA', 212, 'Dominica', 'Roseau', 754, 72813, 'NA', 'XCD', 'Dollar', '+1-767', 'en-DM', 3575830);
INSERT INTO countries VALUES (61, 'DO', 'DOM', 214, 'Dominican Republic', 'Santo Domingo', 48730, 9823821, 'NA', 'DOP', 'Peso', '+1-809 and 1-829', 'es-DO', 3508796);
INSERT INTO countries VALUES (62, 'DZ', 'DZA', 12, 'Algeria', 'Algiers', 2381740, 34586184, 'AF', 'DZD', 'Dinar', '213', 'ar-DZ', 2589581);
INSERT INTO countries VALUES (63, 'EC', 'ECU', 218, 'Ecuador', 'Quito', 283560, 14790608, 'SA', 'USD', 'Dollar', '593', 'es-EC', 3658394);
INSERT INTO countries VALUES (64, 'EE', 'EST', 233, 'Estonia', 'Tallinn', 45226, 1291170, 'EU', 'EUR', 'Euro', '372', 'et,ru', 453733);
INSERT INTO countries VALUES (65, 'EG', 'EGY', 818, 'Egypt', 'Cairo', 1001450, 80471869, 'AF', 'EGP', 'Pound', '20', 'ar-EG,en,fr', 357994);
INSERT INTO countries VALUES (66, 'EH', 'ESH', 732, 'Western Sahara', 'El-Aaiun', 266000, 273008, 'AF', 'MAD', 'Dirham', '212', 'ar,mey', 2461445);
INSERT INTO countries VALUES (67, 'ER', 'ERI', 232, 'Eritrea', 'Asmara', 121320, 5792984, 'AF', 'ERN', 'Nakfa', '291', 'aa-ER,ar,tig,kun,ti-ER', 338010);
INSERT INTO countries VALUES (68, 'ES', 'ESP', 724, 'Spain', 'Madrid', 504782, 46505963, 'EU', 'EUR', 'Euro', '34', 'es-ES,ca,gl,eu,oc', 2510769);
INSERT INTO countries VALUES (69, 'ET', 'ETH', 231, 'Ethiopia', 'Addis Ababa', 1127127, 88013491, 'AF', 'ETB', 'Birr', '251', 'am,en-ET,om-ET,ti-ET,so-ET,sid', 337996);
INSERT INTO countries VALUES (70, 'FI', 'FIN', 246, 'Finland', 'Helsinki', 337030, 5244000, 'EU', 'EUR', 'Euro', '358', 'fi-FI,sv-FI,smn', 660013);
INSERT INTO countries VALUES (71, 'FJ', 'FJI', 242, 'Fiji', 'Suva', 18270, 875983, 'OC', 'FJD', 'Dollar', '679', 'en-FJ,fj', 2205218);
INSERT INTO countries VALUES (72, 'FK', 'FLK', 238, 'Falkland Islands', 'Stanley', 12173, 2638, 'SA', 'FKP', 'Pound', '500', 'en-FK', 3474414);
INSERT INTO countries VALUES (73, 'FM', 'FSM', 583, 'Micronesia', 'Palikir', 702, 107708, 'OC', 'USD', 'Dollar', '691', 'en-FM,chk,pon,yap,kos,uli,woe,nkr,kpg', 2081918);
INSERT INTO countries VALUES (74, 'FO', 'FRO', 234, 'Faroe Islands', 'Torshavn', 1399, 48228, 'EU', 'DKK', 'Krone', '298', 'fo,da-FO', 2622320);
INSERT INTO countries VALUES (75, 'FR', 'FRA', 250, 'France', 'Paris', 547030, 64768389, 'EU', 'EUR', 'Euro', '33', 'fr-FR,frp,br,co,ca,eu,oc', 3017382);
INSERT INTO countries VALUES (76, 'GA', 'GAB', 266, 'Gabon', 'Libreville', 267667, 1545255, 'AF', 'XAF', 'Franc', '241', 'fr-GA', 2400553);
INSERT INTO countries VALUES (77, 'GB', 'GBR', 826, 'United Kingdom', 'London', 244820, 62348447, 'EU', 'GBP', 'Pound', '44', 'en-GB,cy-GB,gd', 2635167);
INSERT INTO countries VALUES (78, 'GD', 'GRD', 308, 'Grenada', 'St. George''s', 344, 107818, 'NA', 'XCD', 'Dollar', '+1-473', 'en-GD', 3580239);
INSERT INTO countries VALUES (79, 'GE', 'GEO', 268, 'Georgia', 'Tbilisi', 69700, 4630000, 'AS', 'GEL', 'Lari', '995', 'ka,ru,hy,az', 614540);
INSERT INTO countries VALUES (80, 'GF', 'GUF', 254, 'French Guiana', 'Cayenne', 91000, 195506, 'SA', 'EUR', 'Euro', '594', 'fr-GF', 3381670);
INSERT INTO countries VALUES (81, 'GG', 'GGY', 831, 'Guernsey', 'St Peter Port', 78, 65228, 'EU', 'GBP', 'Pound', '+44-1481', 'en,fr', 3042362);
INSERT INTO countries VALUES (82, 'GH', 'GHA', 288, 'Ghana', 'Accra', 239460, 24339838, 'AF', 'GHS', 'Cedi', '233', 'en-GH,ak,ee,tw', 2300660);
INSERT INTO countries VALUES (83, 'GI', 'GIB', 292, 'Gibraltar', 'Gibraltar', 6, 27884, 'EU', 'GIP', 'Pound', '350', 'en-GI,es,it,pt', 2411586);
INSERT INTO countries VALUES (84, 'GL', 'GRL', 304, 'Greenland', 'Nuuk', 2166086, 56375, 'NA', 'DKK', 'Krone', '299', 'kl,da-GL,en', 3425505);
INSERT INTO countries VALUES (85, 'GM', 'GMB', 270, 'Gambia', 'Banjul', 11300, 1593256, 'AF', 'GMD', 'Dalasi', '220', 'en-GM,mnk,wof,wo,ff', 2413451);
INSERT INTO countries VALUES (86, 'GN', 'GIN', 324, 'Guinea', 'Conakry', 245857, 10324025, 'AF', 'GNF', 'Franc', '224', 'fr-GN', 2420477);
INSERT INTO countries VALUES (87, 'GP', 'GLP', 312, 'Guadeloupe', 'Basse-Terre', 1780, 443000, 'NA', 'EUR', 'Euro', '590', 'fr-GP', 3579143);
INSERT INTO countries VALUES (88, 'GQ', 'GNQ', 226, 'Equatorial Guinea', 'Malabo', 28051, 1014999, 'AF', 'XAF', 'Franc', '240', 'es-GQ,fr', 2309096);
INSERT INTO countries VALUES (89, 'GR', 'GRC', 300, 'Greece', 'Athens', 131940, 11000000, 'EU', 'EUR', 'Euro', '30', 'el-GR,en,fr', 390903);
INSERT INTO countries VALUES (90, 'GS', 'SGS', 239, 'South Georgia and the South Sandwich Islands', 'Grytviken', 3903, 30, 'AN', 'GBP', 'Pound', '', 'en', 3474415);
INSERT INTO countries VALUES (91, 'GT', 'GTM', 320, 'Guatemala', 'Guatemala City', 108890, 13550440, 'NA', 'GTQ', 'Quetzal', '502', 'es-GT', 3595528);
INSERT INTO countries VALUES (92, 'GU', 'GUM', 316, 'Guam', 'Hagatna', 549, 159358, 'OC', 'USD', 'Dollar', '+1-671', 'en-GU,ch-GU', 4043988);
INSERT INTO countries VALUES (93, 'GW', 'GNB', 624, 'Guinea-Bissau', 'Bissau', 36120, 1565126, 'AF', 'XOF', 'Franc', '245', 'pt-GW,pov', 2372248);
INSERT INTO countries VALUES (94, 'GY', 'GUY', 328, 'Guyana', 'Georgetown', 214970, 748486, 'SA', 'GYD', 'Dollar', '592', 'en-GY', 3378535);
INSERT INTO countries VALUES (95, 'HK', 'HKG', 344, 'Hong Kong', 'Hong Kong', 1092, 6898686, 'AS', 'HKD', 'Dollar', '852', 'zh-HK,yue,zh,en', 1819730);
INSERT INTO countries VALUES (96, 'HM', 'HMD', 334, 'Heard Island and McDonald Islands', '', 412, 0, 'AN', 'AUD', 'Dollar', ' ', '', 1547314);
INSERT INTO countries VALUES (97, 'HN', 'HND', 340, 'Honduras', 'Tegucigalpa', 112090, 7989415, 'NA', 'HNL', 'Lempira', '504', 'es-HN', 3608932);
INSERT INTO countries VALUES (98, 'HR', 'HRV', 191, 'Croatia', 'Zagreb', 56542, 4491000, 'EU', 'HRK', 'Kuna', '385', 'hr-HR,sr', 3202326);
INSERT INTO countries VALUES (99, 'HT', 'HTI', 332, 'Haiti', 'Port-au-Prince', 27750, 9648924, 'NA', 'HTG', 'Gourde', '509', 'ht,fr-HT', 3723988);
INSERT INTO countries VALUES (100, 'HU', 'HUN', 348, 'Hungary', 'Budapest', 93030, 9930000, 'EU', 'HUF', 'Forint', '36', 'hu-HU', 719819);
INSERT INTO countries VALUES (101, 'ID', 'IDN', 360, 'Indonesia', 'Jakarta', 1919440, 242968342, 'AS', 'IDR', 'Rupiah', '62', 'id,en,nl,jv', 1643084);
INSERT INTO countries VALUES (102, 'IE', 'IRL', 372, 'Ireland', 'Dublin', 70280, 4622917, 'EU', 'EUR', 'Euro', '353', 'en-IE,ga-IE', 2963597);
INSERT INTO countries VALUES (103, 'IL', 'ISR', 376, 'Israel', 'Jerusalem', 20770, 7353985, 'AS', 'ILS', 'Shekel', '972', 'he,ar-IL,en-IL,', 294640);
INSERT INTO countries VALUES (104, 'IM', 'IMN', 833, 'Isle of Man', 'Douglas, Isle of Man', 572, 75049, 'EU', 'GBP', 'Pound', '+44-1624', 'en,gv', 3042225);
INSERT INTO countries VALUES (105, 'IN', 'IND', 356, 'India', 'New Delhi', 3287590, 1173108018, 'AS', 'INR', 'Rupee', '91', 'en-IN,hi,bn,te,mr,ta,ur,gu,kn,ml,or,pa,as,bh,sat,ks,ne,sd,kok,doi,mni,sit,sa,fr,lus,inc', 1269750);
INSERT INTO countries VALUES (106, 'IO', 'IOT', 86, 'British Indian Ocean Territory', 'Diego Garcia', 60, 4000, 'AS', 'USD', 'Dollar', '246', 'en-IO', 1282588);
INSERT INTO countries VALUES (107, 'IQ', 'IRQ', 368, 'Iraq', 'Baghdad', 437072, 29671605, 'AS', 'IQD', 'Dinar', '964', 'ar-IQ,ku,hy', 99237);
INSERT INTO countries VALUES (108, 'IR', 'IRN', 364, 'Iran', 'Tehran', 1648000, 76923300, 'AS', 'IRR', 'Rial', '98', 'fa-IR,ku', 130758);
INSERT INTO countries VALUES (109, 'IS', 'ISL', 352, 'Iceland', 'Reykjavik', 103000, 308910, 'EU', 'ISK', 'Krona', '354', 'is,en,de,da,sv,no', 2629691);
INSERT INTO countries VALUES (110, 'IT', 'ITA', 380, 'Italy', 'Rome', 301230, 60340328, 'EU', 'EUR', 'Euro', '39', 'it-IT,de-IT,fr-IT,sc,ca,co,sl', 3175395);
INSERT INTO countries VALUES (111, 'JE', 'JEY', 832, 'Jersey', 'Saint Helier', 116, 90812, 'EU', 'GBP', 'Pound', '+44-1534', 'en,pt', 3042142);
INSERT INTO countries VALUES (112, 'JM', 'JAM', 388, 'Jamaica', 'Kingston', 10991, 2847232, 'NA', 'JMD', 'Dollar', '+1-876', 'en-JM', 3489940);
INSERT INTO countries VALUES (113, 'JO', 'JOR', 400, 'Jordan', 'Amman', 92300, 6407085, 'AS', 'JOD', 'Dinar', '962', 'ar-JO,en', 248816);
INSERT INTO countries VALUES (114, 'JP', 'JPN', 392, 'Japan', 'Tokyo', 377835, 127288000, 'AS', 'JPY', 'Yen', '81', 'ja', 1861060);
INSERT INTO countries VALUES (115, 'KE', 'KEN', 404, 'Kenya', 'Nairobi', 582650, 40046566, 'AF', 'KES', 'Shilling', '254', 'en-KE,sw-KE', 192950);
INSERT INTO countries VALUES (116, 'KG', 'KGZ', 417, 'Kyrgyzstan', 'Bishkek', 198500, 5508626, 'AS', 'KGS', 'Som', '996', 'ky,uz,ru', 1527747);
INSERT INTO countries VALUES (117, 'KH', 'KHM', 116, 'Cambodia', 'Phnom Penh', 181040, 14453680, 'AS', 'KHR', 'Riels', '855', 'km,fr,en', 1831722);
INSERT INTO countries VALUES (118, 'KI', 'KIR', 296, 'Kiribati', 'Tarawa', 811, 92533, 'OC', 'AUD', 'Dollar', '686', 'en-KI,gil', 4030945);
INSERT INTO countries VALUES (119, 'KM', 'COM', 174, 'Comoros', 'Moroni', 2170, 773407, 'AF', 'KMF', 'Franc', '269', 'ar,fr-KM', 921929);
INSERT INTO countries VALUES (120, 'KN', 'KNA', 659, 'Saint Kitts and Nevis', 'Basseterre', 261, 49898, 'NA', 'XCD', 'Dollar', '+1-869', 'en-KN', 3575174);
INSERT INTO countries VALUES (121, 'KP', 'PRK', 408, 'North Korea', 'Pyongyang', 120540, 22912177, 'AS', 'KPW', 'Won', '850', 'ko-KP', 1873107);
INSERT INTO countries VALUES (122, 'KR', 'KOR', 410, 'South Korea', 'Seoul', 98480, 48422644, 'AS', 'KRW', 'Won', '82', 'ko-KR,en', 1835841);
INSERT INTO countries VALUES (123, 'XK', 'XKX', 0, 'Kosovo', 'Pristina', NULL, 1800000, 'EU', 'EUR', 'Euro', '', 'sq,sr', 831053);
INSERT INTO countries VALUES (124, 'KW', 'KWT', 414, 'Kuwait', 'Kuwait City', 17820, 2789132, 'AS', 'KWD', 'Dinar', '965', 'ar-KW,en', 285570);
INSERT INTO countries VALUES (125, 'KY', 'CYM', 136, 'Cayman Islands', 'George Town', 262, 44270, 'NA', 'KYD', 'Dollar', '+1-345', 'en-KY', 3580718);
INSERT INTO countries VALUES (126, 'KZ', 'KAZ', 398, 'Kazakhstan', 'Astana', 2717300, 15340000, 'AS', 'KZT', 'Tenge', '7', 'kk,ru', 1522867);
INSERT INTO countries VALUES (127, 'LA', 'LAO', 418, 'Laos', 'Vientiane', 236800, 6368162, 'AS', 'LAK', 'Kip', '856', 'lo,fr,en', 1655842);
INSERT INTO countries VALUES (128, 'LB', 'LBN', 422, 'Lebanon', 'Beirut', 10400, 4125247, 'AS', 'LBP', 'Pound', '961', 'ar-LB,fr-LB,en,hy', 272103);
INSERT INTO countries VALUES (129, 'LC', 'LCA', 662, 'Saint Lucia', 'Castries', 616, 160922, 'NA', 'XCD', 'Dollar', '+1-758', 'en-LC', 3576468);
INSERT INTO countries VALUES (130, 'LI', 'LIE', 438, 'Liechtenstein', 'Vaduz', 160, 35000, 'EU', 'CHF', 'Franc', '423', 'de-LI', 3042058);
INSERT INTO countries VALUES (131, 'LK', 'LKA', 144, 'Sri Lanka', 'Colombo', 65610, 21513990, 'AS', 'LKR', 'Rupee', '94', 'si,ta,en', 1227603);
INSERT INTO countries VALUES (132, 'LR', 'LBR', 430, 'Liberia', 'Monrovia', 111370, 3685076, 'AF', 'LRD', 'Dollar', '231', 'en-LR', 2275384);
INSERT INTO countries VALUES (133, 'LS', 'LSO', 426, 'Lesotho', 'Maseru', 30355, 1919552, 'AF', 'LSL', 'Loti', '266', 'en-LS,st,zu,xh', 932692);
INSERT INTO countries VALUES (134, 'LT', 'LTU', 440, 'Lithuania', 'Vilnius', 65200, 3565000, 'EU', 'LTL', 'Litas', '370', 'lt,ru,pl', 597427);
INSERT INTO countries VALUES (135, 'LU', 'LUX', 442, 'Luxembourg', 'Luxembourg', 2586, 497538, 'EU', 'EUR', 'Euro', '352', 'lb,de-LU,fr-LU', 2960313);
INSERT INTO countries VALUES (136, 'LV', 'LVA', 428, 'Latvia', 'Riga', 64589, 2217969, 'EU', 'LVL', 'Lat', '371', 'lv,ru,lt', 458258);
INSERT INTO countries VALUES (137, 'LY', 'LBY', 434, 'Libya', 'Tripolis', 1759540, 6461454, 'AF', 'LYD', 'Dinar', '218', 'ar-LY,it,en', 2215636);
INSERT INTO countries VALUES (138, 'MA', 'MAR', 504, 'Morocco', 'Rabat', 446550, 31627428, 'AF', 'MAD', 'Dirham', '212', 'ar-MA,fr', 2542007);
INSERT INTO countries VALUES (139, 'MC', 'MCO', 492, 'Monaco', 'Monaco', 1, 32965, 'EU', 'EUR', 'Euro', '377', 'fr-MC,en,it', 2993457);
INSERT INTO countries VALUES (140, 'MD', 'MDA', 498, 'Moldova', 'Chisinau', 33843, 4324000, 'EU', 'MDL', 'Leu', '373', 'ro,ru,gag,tr', 617790);
INSERT INTO countries VALUES (141, 'ME', 'MNE', 499, 'Montenegro', 'Podgorica', 14026, 666730, 'EU', 'EUR', 'Euro', '382', 'sr,hu,bs,sq,hr,rom', 3194884);
INSERT INTO countries VALUES (142, 'MF', 'MAF', 663, 'Saint Martin', 'Marigot', 53, 35925, 'NA', 'EUR', 'Euro', '590', 'fr', 3578421);
INSERT INTO countries VALUES (143, 'MG', 'MDG', 450, 'Madagascar', 'Antananarivo', 587040, 21281844, 'AF', 'MGA', 'Ariary', '261', 'fr-MG,mg', 1062947);
INSERT INTO countries VALUES (144, 'MH', 'MHL', 584, 'Marshall Islands', 'Majuro', 181, 65859, 'OC', 'USD', 'Dollar', '692', 'mh,en-MH', 2080185);
INSERT INTO countries VALUES (145, 'MK', 'MKD', 807, 'Macedonia', 'Skopje', 25333, 2061000, 'EU', 'MKD', 'Denar', '389', 'mk,sq,tr,rmm,sr', 718075);
INSERT INTO countries VALUES (146, 'ML', 'MLI', 466, 'Mali', 'Bamako', 1240000, 13796354, 'AF', 'XOF', 'Franc', '223', 'fr-ML,bm', 2453866);
INSERT INTO countries VALUES (147, 'MM', 'MMR', 104, 'Myanmar', 'Nay Pyi Taw', 678500, 53414374, 'AS', 'MMK', 'Kyat', '95', 'my', 1327865);
INSERT INTO countries VALUES (148, 'MN', 'MNG', 496, 'Mongolia', 'Ulan Bator', 1565000, 3086918, 'AS', 'MNT', 'Tugrik', '976', 'mn,ru', 2029969);
INSERT INTO countries VALUES (149, 'MO', 'MAC', 446, 'Macao', 'Macao', 254, 449198, 'AS', 'MOP', 'Pataca', '853', 'zh,zh-MO,pt', 1821275);
INSERT INTO countries VALUES (150, 'MP', 'MNP', 580, 'Northern Mariana Islands', 'Saipan', 477, 53883, 'OC', 'USD', 'Dollar', '+1-670', 'fil,tl,zh,ch-MP,en-MP', 4041468);
INSERT INTO countries VALUES (151, 'MQ', 'MTQ', 474, 'Martinique', 'Fort-de-France', 1100, 432900, 'NA', 'EUR', 'Euro', '596', 'fr-MQ', 3570311);
INSERT INTO countries VALUES (152, 'MR', 'MRT', 478, 'Mauritania', 'Nouakchott', 1030700, 3205060, 'AF', 'MRO', 'Ouguiya', '222', 'ar-MR,fuc,snk,fr,mey,wo', 2378080);
INSERT INTO countries VALUES (153, 'MS', 'MSR', 500, 'Montserrat', 'Plymouth', 102, 9341, 'NA', 'XCD', 'Dollar', '+1-664', 'en-MS', 3578097);
INSERT INTO countries VALUES (154, 'MT', 'MLT', 470, 'Malta', 'Valletta', 316, 403000, 'EU', 'EUR', 'Euro', '356', 'mt,en-MT', 2562770);
INSERT INTO countries VALUES (155, 'MU', 'MUS', 480, 'Mauritius', 'Port Louis', 2040, 1294104, 'AF', 'MUR', 'Rupee', '230', 'en-MU,bho,fr', 934292);
INSERT INTO countries VALUES (156, 'MV', 'MDV', 462, 'Maldives', 'Male', 300, 395650, 'AS', 'MVR', 'Rufiyaa', '960', 'dv,en', 1282028);
INSERT INTO countries VALUES (157, 'MW', 'MWI', 454, 'Malawi', 'Lilongwe', 118480, 15447500, 'AF', 'MWK', 'Kwacha', '265', 'ny,yao,tum,swk', 927384);
INSERT INTO countries VALUES (158, 'MX', 'MEX', 484, 'Mexico', 'Mexico City', 1972550, 112468855, 'NA', 'MXN', 'Peso', '52', 'es-MX', 3996063);
INSERT INTO countries VALUES (159, 'MY', 'MYS', 458, 'Malaysia', 'Kuala Lumpur', 329750, 28274729, 'AS', 'MYR', 'Ringgit', '60', 'ms-MY,en,zh,ta,te,ml,pa,th', 1733045);
INSERT INTO countries VALUES (160, 'MZ', 'MOZ', 508, 'Mozambique', 'Maputo', 801590, 22061451, 'AF', 'MZN', 'Metical', '258', 'pt-MZ,vmw', 1036973);
INSERT INTO countries VALUES (161, 'NA', 'NAM', 516, 'Namibia', 'Windhoek', 825418, 2128471, 'AF', 'NAD', 'Dollar', '264', 'en-NA,af,de,hz,naq', 3355338);
INSERT INTO countries VALUES (162, 'NC', 'NCL', 540, 'New Caledonia', 'Noumea', 19060, 216494, 'OC', 'XPF', 'Franc', '687', 'fr-NC', 2139685);
INSERT INTO countries VALUES (163, 'NE', 'NER', 562, 'Niger', 'Niamey', 1267000, 15878271, 'AF', 'XOF', 'Franc', '227', 'fr-NE,ha,kr,dje', 2440476);
INSERT INTO countries VALUES (164, 'NF', 'NFK', 574, 'Norfolk Island', 'Kingston', 34, 1828, 'OC', 'AUD', 'Dollar', '672', 'en-NF', 2155115);
INSERT INTO countries VALUES (165, 'NG', 'NGA', 566, 'Nigeria', 'Abuja', 923768, 154000000, 'AF', 'NGN', 'Naira', '234', 'en-NG,ha,yo,ig,ff', 2328926);
INSERT INTO countries VALUES (166, 'NI', 'NIC', 558, 'Nicaragua', 'Managua', 129494, 5995928, 'NA', 'NIO', 'Cordoba', '505', 'es-NI,en', 3617476);
INSERT INTO countries VALUES (167, 'NL', 'NLD', 528, 'Netherlands', 'Amsterdam', 41526, 16645000, 'EU', 'EUR', 'Euro', '31', 'nl-NL,fy-NL', 2750405);
INSERT INTO countries VALUES (168, 'NO', 'NOR', 578, 'Norway', 'Oslo', 324220, 5009150, 'EU', 'NOK', 'Krone', '47', 'no,nb,nn,se,fi', 3144096);
INSERT INTO countries VALUES (169, 'NP', 'NPL', 524, 'Nepal', 'Kathmandu', 140800, 28951852, 'AS', 'NPR', 'Rupee', '977', 'ne,en', 1282988);
INSERT INTO countries VALUES (170, 'NR', 'NRU', 520, 'Nauru', 'Yaren', 21, 10065, 'OC', 'AUD', 'Dollar', '674', 'na,en-NR', 2110425);
INSERT INTO countries VALUES (171, 'NU', 'NIU', 570, 'Niue', 'Alofi', 260, 2166, 'OC', 'NZD', 'Dollar', '683', 'niu,en-NU', 4036232);
INSERT INTO countries VALUES (172, 'NZ', 'NZL', 554, 'New Zealand', 'Wellington', 268680, 4252277, 'OC', 'NZD', 'Dollar', '64', 'en-NZ,mi', 2186224);
INSERT INTO countries VALUES (173, 'OM', 'OMN', 512, 'Oman', 'Muscat', 212460, 2967717, 'AS', 'OMR', 'Rial', '968', 'ar-OM,en,bal,ur', 286963);
INSERT INTO countries VALUES (174, 'PA', 'PAN', 591, 'Panama', 'Panama City', 78200, 3410676, 'NA', 'PAB', 'Balboa', '507', 'es-PA,en', 3703430);
INSERT INTO countries VALUES (175, 'PE', 'PER', 604, 'Peru', 'Lima', 1285220, 29907003, 'SA', 'PEN', 'Sol', '51', 'es-PE,qu,ay', 3932488);
INSERT INTO countries VALUES (176, 'PF', 'PYF', 258, 'French Polynesia', 'Papeete', 4167, 270485, 'OC', 'XPF', 'Franc', '689', 'fr-PF,ty', 4030656);
INSERT INTO countries VALUES (177, 'PG', 'PNG', 598, 'Papua New Guinea', 'Port Moresby', 462840, 6064515, 'OC', 'PGK', 'Kina', '675', 'en-PG,ho,meu,tpi', 2088628);
INSERT INTO countries VALUES (178, 'PH', 'PHL', 608, 'Philippines', 'Manila', 300000, 99900177, 'AS', 'PHP', 'Peso', '63', 'tl,en-PH,fil', 1694008);
INSERT INTO countries VALUES (179, 'PK', 'PAK', 586, 'Pakistan', 'Islamabad', 803940, 184404791, 'AS', 'PKR', 'Rupee', '92', 'ur-PK,en-PK,pa,sd,ps,brh', 1168579);
INSERT INTO countries VALUES (180, 'PL', 'POL', 616, 'Poland', 'Warsaw', 312685, 38500000, 'EU', 'PLN', 'Zloty', '48', 'pl', 798544);
INSERT INTO countries VALUES (181, 'PM', 'SPM', 666, 'Saint Pierre and Miquelon', 'Saint-Pierre', 242, 7012, 'NA', 'EUR', 'Euro', '508', 'fr-PM', 3424932);
INSERT INTO countries VALUES (182, 'PN', 'PCN', 612, 'Pitcairn', 'Adamstown', 47, 46, 'OC', 'NZD', 'Dollar', '870', 'en-PN', 4030699);
INSERT INTO countries VALUES (183, 'PR', 'PRI', 630, 'Puerto Rico', 'San Juan', 9104, 3916632, 'NA', 'USD', 'Dollar', '+1-787 and 1-939', 'en-PR,es-PR', 4566966);
INSERT INTO countries VALUES (184, 'PS', 'PSE', 275, 'Palestinian Territory', 'East Jerusalem', 5970, 3800000, 'AS', 'ILS', 'Shekel', '970', 'ar-PS', 6254930);
INSERT INTO countries VALUES (185, 'PT', 'PRT', 620, 'Portugal', 'Lisbon', 92391, 10676000, 'EU', 'EUR', 'Euro', '351', 'pt-PT,mwl', 2264397);
INSERT INTO countries VALUES (186, 'PW', 'PLW', 585, 'Palau', 'Melekeok', 458, 19907, 'OC', 'USD', 'Dollar', '680', 'pau,sov,en-PW,tox,ja,fil,zh', 1559582);
INSERT INTO countries VALUES (187, 'PY', 'PRY', 600, 'Paraguay', 'Asuncion', 406750, 6375830, 'SA', 'PYG', 'Guarani', '595', 'es-PY,gn', 3437598);
INSERT INTO countries VALUES (188, 'QA', 'QAT', 634, 'Qatar', 'Doha', 11437, 840926, 'AS', 'QAR', 'Rial', '974', 'ar-QA,es', 289688);
INSERT INTO countries VALUES (189, 'RE', 'REU', 638, 'Reunion', 'Saint-Denis', 2517, 776948, 'AF', 'EUR', 'Euro', '262', 'fr-RE', 935317);
INSERT INTO countries VALUES (190, 'RO', 'ROU', 642, 'Romania', 'Bucharest', 237500, 21959278, 'EU', 'RON', 'Leu', '40', 'ro,hu,rom', 798549);
INSERT INTO countries VALUES (191, 'RS', 'SRB', 688, 'Serbia', 'Belgrade', 88361, 7344847, 'EU', 'RSD', 'Dinar', '381', 'sr,hu,bs,rom', 6290252);
INSERT INTO countries VALUES (192, 'RU', 'RUS', 643, 'Russia', 'Moscow', 17100000, 140702000, 'EU', 'RUB', 'Ruble', '7', 'ru,tt,xal,cau,ady,kv,ce,tyv,cv,udm,tut,mns,bua,myv,mdf,chm,ba,inh,tut,kbd,krc,ava,sah,nog', 2017370);
INSERT INTO countries VALUES (193, 'RW', 'RWA', 646, 'Rwanda', 'Kigali', 26338, 11055976, 'AF', 'RWF', 'Franc', '250', 'rw,en-RW,fr-RW,sw', 49518);
INSERT INTO countries VALUES (194, 'SA', 'SAU', 682, 'Saudi Arabia', 'Riyadh', 1960582, 25731776, 'AS', 'SAR', 'Rial', '966', 'ar-SA', 102358);
INSERT INTO countries VALUES (195, 'SB', 'SLB', 90, 'Solomon Islands', 'Honiara', 28450, 559198, 'OC', 'SBD', 'Dollar', '677', 'en-SB,tpi', 2103350);
INSERT INTO countries VALUES (196, 'SC', 'SYC', 690, 'Seychelles', 'Victoria', 455, 88340, 'AF', 'SCR', 'Rupee', '248', 'en-SC,fr-SC', 241170);
INSERT INTO countries VALUES (197, 'SD', 'SDN', 729, 'Sudan', 'Khartoum', 1861484, 35000000, 'AF', 'SDG', 'Pound', '249', 'ar-SD,en,fia', 366755);
INSERT INTO countries VALUES (198, 'SS', 'SSD', 728, 'South Sudan', 'Juba', 644329, 8260490, 'AF', 'SSP', 'Pound', '211', 'en', 7909807);
INSERT INTO countries VALUES (199, 'SE', 'SWE', 752, 'Sweden', 'Stockholm', 449964, 9045000, 'EU', 'SEK', 'Krona', '46', 'sv-SE,se,sma,fi-SE', 2661886);
INSERT INTO countries VALUES (200, 'SG', 'SGP', 702, 'Singapore', 'Singapur', 692, 4701069, 'AS', 'SGD', 'Dollar', '65', 'cmn,en-SG,ms-SG,ta-SG,zh-SG', 1880251);
INSERT INTO countries VALUES (201, 'SH', 'SHN', 654, 'Saint Helena', 'Jamestown', 410, 7460, 'AF', 'SHP', 'Pound', '290', 'en-SH', 3370751);
INSERT INTO countries VALUES (202, 'SI', 'SVN', 705, 'Slovenia', 'Ljubljana', 20273, 2007000, 'EU', 'EUR', 'Euro', '386', 'sl,sh', 3190538);
INSERT INTO countries VALUES (203, 'SJ', 'SJM', 744, 'Svalbard and Jan Mayen', 'Longyearbyen', 62049, 2550, 'EU', 'NOK', 'Krone', '47', 'no,ru', 607072);
INSERT INTO countries VALUES (204, 'SK', 'SVK', 703, 'Slovakia', 'Bratislava', 48845, 5455000, 'EU', 'EUR', 'Euro', '421', 'sk,hu', 3057568);
INSERT INTO countries VALUES (205, 'SL', 'SLE', 694, 'Sierra Leone', 'Freetown', 71740, 5245695, 'AF', 'SLL', 'Leone', '232', 'en-SL,men,tem', 2403846);
INSERT INTO countries VALUES (206, 'SM', 'SMR', 674, 'San Marino', 'San Marino', 61, 31477, 'EU', 'EUR', 'Euro', '378', 'it-SM', 3168068);
INSERT INTO countries VALUES (207, 'SN', 'SEN', 686, 'Senegal', 'Dakar', 196190, 12323252, 'AF', 'XOF', 'Franc', '221', 'fr-SN,wo,fuc,mnk', 2245662);
INSERT INTO countries VALUES (208, 'SO', 'SOM', 706, 'Somalia', 'Mogadishu', 637657, 10112453, 'AF', 'SOS', 'Shilling', '252', 'so-SO,ar-SO,it,en-SO', 51537);
INSERT INTO countries VALUES (209, 'SR', 'SUR', 740, 'Suriname', 'Paramaribo', 163270, 492829, 'SA', 'SRD', 'Dollar', '597', 'nl-SR,en,srn,hns,jv', 3382998);
INSERT INTO countries VALUES (210, 'ST', 'STP', 678, 'Sao Tome and Principe', 'Sao Tome', 1001, 175808, 'AF', 'STD', 'Dobra', '239', 'pt-ST', 2410758);
INSERT INTO countries VALUES (211, 'SV', 'SLV', 222, 'El Salvador', 'San Salvador', 21040, 6052064, 'NA', 'USD', 'Dollar', '503', 'es-SV', 3585968);
INSERT INTO countries VALUES (212, 'SX', 'SXM', 534, 'Sint Maarten', 'Philipsburg', NULL, 37429, 'NA', 'ANG', 'Guilder', '599', 'nl,en', 7609695);
INSERT INTO countries VALUES (213, 'SY', 'SYR', 760, 'Syria', 'Damascus', 185180, 22198110, 'AS', 'SYP', 'Pound', '963', 'ar-SY,ku,hy,arc,fr,en', 163843);
INSERT INTO countries VALUES (214, 'SZ', 'SWZ', 748, 'Swaziland', 'Mbabane', 17363, 1354051, 'AF', 'SZL', 'Lilangeni', '268', 'en-SZ,ss-SZ', 934841);
INSERT INTO countries VALUES (215, 'TC', 'TCA', 796, 'Turks and Caicos Islands', 'Cockburn Town', 430, 20556, 'NA', 'USD', 'Dollar', '+1-649', 'en-TC', 3576916);
INSERT INTO countries VALUES (216, 'TD', 'TCD', 148, 'Chad', 'N''Djamena', 1284000, 10543464, 'AF', 'XAF', 'Franc', '235', 'fr-TD,ar-TD,sre', 2434508);
INSERT INTO countries VALUES (217, 'TF', 'ATF', 260, 'French Southern Territories', 'Port-aux-Francais', 7829, 140, 'AN', 'EUR', 'Euro  ', '', 'fr', 1546748);
INSERT INTO countries VALUES (218, 'TG', 'TGO', 768, 'Togo', 'Lome', 56785, 6587239, 'AF', 'XOF', 'Franc', '228', 'fr-TG,ee,hna,kbp,dag,ha', 2363686);
INSERT INTO countries VALUES (219, 'TH', 'THA', 764, 'Thailand', 'Bangkok', 514000, 67089500, 'AS', 'THB', 'Baht', '66', 'th,en', 1605651);
INSERT INTO countries VALUES (220, 'TJ', 'TJK', 762, 'Tajikistan', 'Dushanbe', 143100, 7487489, 'AS', 'TJS', 'Somoni', '992', 'tg,ru', 1220409);
INSERT INTO countries VALUES (221, 'TK', 'TKL', 772, 'Tokelau', '', 10, 1466, 'OC', 'NZD', 'Dollar', '690', 'tkl,en-TK', 4031074);
INSERT INTO countries VALUES (222, 'TL', 'TLS', 626, 'East Timor', 'Dili', 15007, 1154625, 'OC', 'USD', 'Dollar', '670', 'tet,pt-TL,id,en', 1966436);
INSERT INTO countries VALUES (223, 'TM', 'TKM', 795, 'Turkmenistan', 'Ashgabat', 488100, 4940916, 'AS', 'TMT', 'Manat', '993', 'tk,ru,uz', 1218197);
INSERT INTO countries VALUES (224, 'TN', 'TUN', 788, 'Tunisia', 'Tunis', 163610, 10589025, 'AF', 'TND', 'Dinar', '216', 'ar-TN,fr', 2464461);
INSERT INTO countries VALUES (225, 'TO', 'TON', 776, 'Tonga', 'Nuku''alofa', 748, 122580, 'OC', 'TOP', 'Pa''anga', '676', 'to,en-TO', 4032283);
INSERT INTO countries VALUES (226, 'TR', 'TUR', 792, 'Turkey', 'Ankara', 780580, 77804122, 'AS', 'TRY', 'Lira', '90', 'tr-TR,ku,diq,az,av', 298795);
INSERT INTO countries VALUES (227, 'TT', 'TTO', 780, 'Trinidad and Tobago', 'Port of Spain', 5128, 1228691, 'NA', 'TTD', 'Dollar', '+1-868', 'en-TT,hns,fr,es,zh', 3573591);
INSERT INTO countries VALUES (228, 'TV', 'TUV', 798, 'Tuvalu', 'Funafuti', 26, 10472, 'OC', 'AUD', 'Dollar', '688', 'tvl,en,sm,gil', 2110297);
INSERT INTO countries VALUES (229, 'TW', 'TWN', 158, 'Taiwan', 'Taipei', 35980, 22894384, 'AS', 'TWD', 'Dollar', '886', 'zh-TW,zh,nan,hak', 1668284);
INSERT INTO countries VALUES (230, 'TZ', 'TZA', 834, 'Tanzania', 'Dodoma', 945087, 41892895, 'AF', 'TZS', 'Shilling', '255', 'sw-TZ,en,ar', 149590);
INSERT INTO countries VALUES (231, 'UA', 'UKR', 804, 'Ukraine', 'Kiev', 603700, 45415596, 'EU', 'UAH', 'Hryvnia', '380', 'uk,ru-UA,rom,pl,hu', 690791);
INSERT INTO countries VALUES (232, 'UG', 'UGA', 800, 'Uganda', 'Kampala', 236040, 33398682, 'AF', 'UGX', 'Shilling', '256', 'en-UG,lg,sw,ar', 226074);
INSERT INTO countries VALUES (233, 'UM', 'UMI', 581, 'United States Minor Outlying Islands', '', 0, 0, 'OC', 'USD', 'Dollar ', '1', 'en-UM', 5854968);
INSERT INTO countries VALUES (234, 'US', 'USA', 840, 'United States', 'Washington', 9629091, 310232863, 'NA', 'USD', 'Dollar', '1', 'en-US,es-US,haw,fr', 6252001);
INSERT INTO countries VALUES (235, 'UY', 'URY', 858, 'Uruguay', 'Montevideo', 176220, 3477000, 'SA', 'UYU', 'Peso', '598', 'es-UY', 3439705);
INSERT INTO countries VALUES (236, 'UZ', 'UZB', 860, 'Uzbekistan', 'Tashkent', 447400, 27865738, 'AS', 'UZS', 'Som', '998', 'uz,ru,tg', 1512440);
INSERT INTO countries VALUES (237, 'VA', 'VAT', 336, 'Vatican', 'Vatican City', 0, 921, 'EU', 'EUR', 'Euro', '379', 'la,it,fr', 3164670);
INSERT INTO countries VALUES (238, 'VC', 'VCT', 670, 'Saint Vincent and the Grenadines', 'Kingstown', 389, 104217, 'NA', 'XCD', 'Dollar', '+1-784', 'en-VC,fr', 3577815);
INSERT INTO countries VALUES (239, 'VE', 'VEN', 862, 'Venezuela', 'Caracas', 912050, 27223228, 'SA', 'VEF', 'Bolivar', '58', 'es-VE', 3625428);
INSERT INTO countries VALUES (240, 'VG', 'VGB', 92, 'British Virgin Islands', 'Road Town', 153, 21730, 'NA', 'USD', 'Dollar', '+1-284', 'en-VG', 3577718);
INSERT INTO countries VALUES (241, 'VI', 'VIR', 850, 'U.S. Virgin Islands', 'Charlotte Amalie', 352, 108708, 'NA', 'USD', 'Dollar', '+1-340', 'en-VI', 4796775);
INSERT INTO countries VALUES (242, 'VN', 'VNM', 704, 'Vietnam', 'Hanoi', 329560, 89571130, 'AS', 'VND', 'Dong', '84', 'vi,en,fr,zh,km', 1562822);
INSERT INTO countries VALUES (243, 'VU', 'VUT', 548, 'Vanuatu', 'Port Vila', 12200, 221552, 'OC', 'VUV', 'Vatu', '678', 'bi,en-VU,fr-VU', 2134431);
INSERT INTO countries VALUES (244, 'WF', 'WLF', 876, 'Wallis and Futuna', 'Mata Utu', 274, 16025, 'OC', 'XPF', 'Franc', '681', 'wls,fud,fr-WF', 4034749);
INSERT INTO countries VALUES (245, 'WS', 'WSM', 882, 'Samoa', 'Apia', 2944, 192001, 'OC', 'WST', 'Tala', '685', 'sm,en-WS', 4034894);
INSERT INTO countries VALUES (246, 'YE', 'YEM', 887, 'Yemen', 'Sanaa', 527970, 23495361, 'AS', 'YER', 'Rial', '967', 'ar-YE', 69543);
INSERT INTO countries VALUES (247, 'YT', 'MYT', 175, 'Mayotte', 'Mamoudzou', 374, 159042, 'AF', 'EUR', 'Euro', '262', 'fr-YT', 1024031);
INSERT INTO countries VALUES (248, 'ZA', 'ZAF', 710, 'South Africa', 'Pretoria', 1219912, 49000000, 'AF', 'ZAR', 'Rand', '27', 'zu,xh,af,nso,en-ZA,tn,st,ts,ss,ve,nr', 953987);
INSERT INTO countries VALUES (249, 'ZM', 'ZMB', 894, 'Zambia', 'Lusaka', 752614, 13460305, 'AF', 'ZMK', 'Kwacha', '260', 'en-ZM,bem,loz,lun,lue,ny,toi', 895949);
INSERT INTO countries VALUES (250, 'ZW', 'ZWE', 716, 'Zimbabwe', 'Harare', 390580, 11651858, 'AF', 'ZWL', 'Dollar', '263', 'en-ZW,sn,nr,nd', 878675);
INSERT INTO countries VALUES (251, 'CS', 'SCG', 891, 'Serbia and Montenegro', 'Belgrade', 102350, 10829175, 'EU', 'RSD', 'Dinar', '381', 'cu,hu,sq,sr', NULL);
INSERT INTO countries VALUES (252, 'AN', 'ANT', 530, 'Netherlands Antilles', 'Willemstad', 960, 136197, 'NA', 'ANG', 'Guilder', '599', 'nl-AN,en,es', NULL);



SELECT pg_catalog.setval('countries_id_seq', 252, true);



ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);



CREATE INDEX index_countries_on_geonames_id ON countries USING btree (geonames_id);




CREATE UNIQUE INDEX index_countries_on_iso_code_two_letter ON countries USING btree (iso_code_two_letter);


--
-- PostgreSQL database dump complete
--

