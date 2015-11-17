--
-- Base de données: `php_abac_test`
--

-- --------------------------------------------------------

DROP TABLE IF EXISTS `abac_policy_rules_attributes`;
DROP TABLE IF EXISTS `abac_policy_rules`;
DROP TABLE IF EXISTS `abac_environment_attributes`;
DROP TABLE IF EXISTS `abac_attributes`;
DROP TABLE IF EXISTS `abac_attributes_data`;
DROP TABLE IF EXISTS `abac_test_vehicle`;
DROP TABLE IF EXISTS `abac_test_user`;
--
-- Structure de la table `abac_policy_rules`
--
CREATE TABLE IF NOT EXISTS `abac_policy_rules` (
  `id` integer PRIMARY KEY AUTOINCREMENT,
  `name` varchar(45) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
);
--
-- --
-- -- Contenu de la table `abac_policy_rules`
-- --
--
INSERT INTO `abac_policy_rules` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'nationality-access', '2015-08-14 13:51:06', '2015-08-14 13:51:06');
INSERT INTO `abac_policy_rules` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'vehicle-homologation', '2015-07-27 05:45:00', '2015-07-27 05:45:00');
INSERT INTO `abac_policy_rules` (`id`, `name`, `created_at`, `updated_at`) VALUES
(3, 'gunlaw', '2015-08-16 16:21:10', '2015-08-16 16:21:10');
--
-- -- --------------------------------------------------------
--
-- --
-- -- Structure de la table `abac_attributes`
-- --
--
CREATE TABLE IF NOT EXISTS `abac_attributes_data` (
  `id` integer PRIMARY KEY AUTOINCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL
);
--
-- --
-- -- Contenu de la table `abac_attributes`
-- --
--
INSERT INTO `abac_attributes_data` (`id`, `created_at`, `updated_at`, `name`, `slug`) VALUES
(1, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'Age', 'age'),
(2, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'Nationalité des Parents', 'nationalite-des-parents'),
(3, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'JAPD', 'japd'),
(4, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'Permis de Conduire', 'permis-de-conduire'),
(5, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'Dernier Contrôle Technique', 'dernier-controle-technique'),
(6, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'Date de sortie usine', 'date-de-sortie-d-usine'),
(7, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'Origine', 'origine'),
(8, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'Propriétaire', 'proprietaire'),
(9, '2015-08-19 11:03:38', '2015-08-19 11:03:38', 'Statut du service', 'statut-du-service');
-- -- --------------------------------------------------------
--
-- --
-- -- Structure de la table `abac_attributes`
-- --
--
CREATE TABLE IF NOT EXISTS `abac_attributes` (
  `id` integer PRIMARY KEY AUTOINCREMENT,
  `table_name` varchar(65) NOT NULL,
  `column_name` varchar(40) NOT NULL,
  `criteria_column` varchar(40) NOT NULL,
  FOREIGN KEY(id) REFERENCES abac_attributes_data(id)
);

-- --
-- -- Contenu de la table `abac_attributes`
-- --
--
INSERT INTO `abac_attributes` (`id`, `table_name`, `column_name`, `criteria_column`) VALUES
(1, 'abac_test_user', 'age', 'id'),
(2, 'abac_test_user', 'parent_nationality', 'id'),
(3, 'abac_test_user', 'has_done_japd', 'id'),
(4, 'abac_test_user', 'has_driving_license', 'id'),
(5, 'abac_test_vehicle', 'technical_review_date', 'id'),
(6, 'abac_test_vehicle', 'manufacture_date', 'id'),
(7, 'abac_test_vehicle', 'origin', 'id'),
(8, 'abac_test_vehicle', 'user_id', 'id');
-- -- --------------------------------------------------------
--
-- --
-- -- Structure de la table `abac_attributes`
-- --
--
CREATE TABLE IF NOT EXISTS `abac_environment_attributes` (
  `id` integer PRIMARY KEY AUTOINCREMENT,
  `variable_name` varchar(65) NOT NULL,
  FOREIGN KEY(id) REFERENCES abac_attributes_data(id)
);

--
-- --
-- -- Contenu de la table `abac_attributes`
-- --
--
INSERT INTO `abac_environment_attributes` (`id`, `variable_name`) VALUES
(9, 'SERVICE_STATE');
--
-- -- --------------------------------------------------------
--
-- --
-- -- Structure de la table `abac_policy_rules_attributes`
-- --
--
CREATE TABLE IF NOT EXISTS `abac_policy_rules_attributes` (
  `policy_rule_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `type` VARCHAR(15) NOT NULL,
  `comparison_type` varchar(10) NOT NULL,
  `comparison` varchar(60) NOT NULL,
  `value` varchar(255) NOT NULL,
  FOREIGN KEY(policy_rule_id) REFERENCES abac_policy_rules(id)
  FOREIGN KEY(attribute_id) REFERENCES abac_attributes_data(id)
);

--
-- --
-- -- Contenu de la table `abac_policy_rules_attributes`
-- --
--
INSERT INTO `abac_policy_rules_attributes` (`policy_rule_id`, `attribute_id`, `type`, `comparison_type`, `comparison`, `value`) VALUES
(1, 1, 'user', 'Numeric', 'isGreaterThan', '18'),
(1, 2, 'user', 'String', 'isEqual', 'FR'),
(1, 3, 'user', 'Numeric', 'isEqual', '1'),
(2, 4, 'user', 'Boolean', 'boolAnd', '1'),
(2, 5, 'object', 'Date', 'isMoreRecentThan', '2Y'),
(2, 6, 'object', 'Date', 'isMoreRecentThan', '25Y'),
(2, 7, 'object', 'Array', 'isIn', 'a:5:{i:0;s:2:"FR";i:1;s:2:"DE";i:2;s:2:"IT";i:3;s:1:"L";i:4;s:2:"GB";}'),
(2, 8, 'object', 'Numeric', 'isEqual', 'dynamic'),
(2, 9, 'environment', 'String', 'isEqual', 'OPEN');
--
-- /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
-- /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
-- /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
--
-- -- --------------------------------------------------------
-- --
-- -- Structure de la table `abac_test_user`
-- --
--
CREATE TABLE IF NOT EXISTS `abac_test_user` (
  `id` integer PRIMARY KEY AUTOINCREMENT,
  `name` varchar(60) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `parent_nationality` varchar(50) NOT NULL,
  `has_done_japd` tinyint(1) NOT NULL,
  `has_driving_license` tinyint(1) NOT NULL
);
--
-- --
-- -- Contenu de la table `abac_test_user`
-- --
--
INSERT INTO `abac_test_user` (`id`, `name`, `age`, `parent_nationality`, `has_done_japd`, `has_driving_license`) VALUES
(1, 'John Doe', 36, 'FR', 1, 1),
(2, 'Thierry', 24, 'FR', 0, 0),
(3, 'Jason', 17, 'FR', 1, 1),
(4, 'Bouddha', 556, 'FR', 1, 0);
--
-- -- --------------------------------------------------------
-- --
-- -- Structure de la table `abac_test_vehicle`
-- --
--
CREATE TABLE IF NOT EXISTS `abac_test_vehicle` (
  `id` integer PRIMARY KEY AUTOINCREMENT,
  `user_id` int(11) NOT NULL,
  `brand` varchar(40) NOT NULL,
  `model` varchar(60) NOT NULL,
  `technical_review_date` datetime NOT NULL,
  `manufacture_date` datetime NOT NULL,
  `origin` varchar(50) NOT NULL,
  `engine_type` varchar(15) NOT NULL,
  `eco_class` varchar(1) NOT NULL
) ;
--
-- --
-- -- Contenu de la table `abac_test_vehicle`
-- --
INSERT INTO `abac_test_vehicle` (`id`, `user_id`, `brand`, `model`, `technical_review_date`, `manufacture_date`, `origin`, `engine_type`, `eco_class`) VALUES
(1, 1, 'Renault', 'Mégane', '2014-08-19 11:03:38', '2015-08-19 11:03:38', 'FR', 'diesel', 'C'),
(2, 3, 'Fiat', 'Stilo', '2008-08-19 11:03:38', '2004-08-19 11:03:38', 'IT', 'diesel', 'C'),
(3, 1, 'Alpha Roméo', 'Mito', '2014-08-19 11:03:38', '2013-08-19 11:03:38', 'FR', 'gasoline', 'D'),
(4, 4, 'Fiat', 'Punto', '2015-08-19 11:03:38', '2010-08-19 11:03:38', 'FR', 'diesel', 'B');