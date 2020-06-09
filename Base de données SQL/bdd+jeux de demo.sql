-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  jeu. 17 oct. 2019 à 11:24
-- Version du serveur :  5.7.26
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `expressfood`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `id_adresse` int(11) NOT NULL AUTO_INCREMENT,
  `adresse_livraison` varchar(255) NOT NULL,
  `adresse_facturation` varchar(255) DEFAULT NULL,
  `supplement_adresse` varchar(255) DEFAULT NULL,
  `digicode` int(11) DEFAULT NULL,
  `etage` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_adresse`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`id_adresse`, `adresse_livraison`, `adresse_facturation`, `supplement_adresse`, `digicode`, `etage`) VALUES
(7, '47 les mimosas', 'identique à l\'adresse de l\'ivraison', '	', NULL, NULL),
(8, '12 boulevard carnot', '66 avenue pierre de coubertin', 'résidence des tournesols', 1218, 9);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id_commande` int(11) NOT NULL AUTO_INCREMENT,
  `date` int(11) NOT NULL,
  `facture` decimal(10,0) NOT NULL,
  `utilisateur_fk` int(11) NOT NULL,
  `adresse_fk` int(11) NOT NULL,
  `statut_commande_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_commande`),
  KEY `utilisateur_fk` (`utilisateur_fk`),
  KEY `adresse_fk` (`adresse_fk`),
  KEY `statut_livraison_fk` (`statut_commande_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id_commande`, `date`, `facture`, `utilisateur_fk`, `adresse_fk`, `statut_commande_fk`) VALUES
(1, 19102019, '1', 6, 7, 1);

-- --------------------------------------------------------

--
-- Structure de la table `ligne_de_commande`
--

DROP TABLE IF EXISTS `ligne_de_commande`;
CREATE TABLE IF NOT EXISTS `ligne_de_commande` (
  `id_ligne_de_commande` int(11) NOT NULL AUTO_INCREMENT,
  `quantite_plat` int(11) NOT NULL,
  `quantite_dessert` int(11) NOT NULL,
  `montant_commande` double NOT NULL,
  `plat_fk` int(11) NOT NULL,
  `commande_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_ligne_de_commande`),
  KEY `plat_fk` (`plat_fk`),
  KEY `commande_fk` (`commande_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `ligne_de_commande`
--

INSERT INTO `ligne_de_commande` (`id_ligne_de_commande`, `quantite_plat`, `quantite_dessert`, `montant_commande`, `plat_fk`, `commande_fk`) VALUES
(1, 1, 0, 12, 8, 1);

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

DROP TABLE IF EXISTS `plat`;
CREATE TABLE IF NOT EXISTS `plat` (
  `id_plat` int(11) NOT NULL AUTO_INCREMENT,
  `plat` varchar(255) NOT NULL,
  `dessert` varchar(255) DEFAULT NULL,
  `stock_plat` int(11) NOT NULL,
  `prix_unitaire` double NOT NULL,
  PRIMARY KEY (`id_plat`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`id_plat`, `plat`, `dessert`, `stock_plat`, `prix_unitaire`) VALUES
(8, 'poulet tikka massala', NULL, 22, 12),
(10, 'poulet curry madras', NULL, 22, 14),
(11, '', 'cheesecake passion', 12, 6),
(12, '', 'carrot cake', 12, 5);

-- --------------------------------------------------------

--
-- Structure de la table `statut_commande`
--

DROP TABLE IF EXISTS `statut_commande`;
CREATE TABLE IF NOT EXISTS `statut_commande` (
  `id_statut_livraison` int(11) NOT NULL AUTO_INCREMENT,
  `latitude_position` decimal(10,0) NOT NULL,
  `longetude_position` decimal(10,0) NOT NULL,
  `etat_commande` varchar(11) NOT NULL,
  `utilisateur_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_statut_livraison`),
  KEY `utilisateur_fk` (`utilisateur_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `statut_commande`
--

INSERT INTO `statut_commande` (`id_statut_livraison`, `latitude_position`, `longetude_position`, `etat_commande`, `utilisateur_fk`) VALUES
(1, '49', '2', 'reglee', 6);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `mot_de_passe` int(11) NOT NULL,
  `telephone` int(11) NOT NULL,
  `role` varchar(255) NOT NULL,
  `adresse_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `mail` (`mail`),
  KEY `adresse_fk` (`adresse_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `nom`, `prenom`, `mail`, `mot_de_passe`, `telephone`, `role`, `adresse_fk`) VALUES
(6, 'dupont', 'jean', 'jean@mail.fr', 123, 603775898, 'client', 7),
(7, 'mike', 'william', 'mike@mail.fr', 121212, 603778566, 'livreur', 8);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `commande_ibfk_1` FOREIGN KEY (`utilisateur_fk`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commande_ibfk_2` FOREIGN KEY (`adresse_fk`) REFERENCES `adresse` (`id_adresse`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commande_ibfk_4` FOREIGN KEY (`statut_commande_fk`) REFERENCES `statut_commande` (`id_statut_livraison`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ligne_de_commande`
--
ALTER TABLE `ligne_de_commande`
  ADD CONSTRAINT `ligne_de_commande_ibfk_1` FOREIGN KEY (`plat_fk`) REFERENCES `plat` (`id_plat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ligne_de_commande_ibfk_2` FOREIGN KEY (`commande_fk`) REFERENCES `commande` (`id_commande`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `statut_commande`
--
ALTER TABLE `statut_commande`
  ADD CONSTRAINT `statut_commande_ibfk_1` FOREIGN KEY (`utilisateur_fk`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`adresse_fk`) REFERENCES `adresse` (`id_adresse`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
