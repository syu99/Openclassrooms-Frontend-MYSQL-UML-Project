-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 16 oct. 2019 à 17:38
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
CREATE DATABASE IF NOT EXISTS `expressfood` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `expressfood`;

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
  `utilisateur_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_adresse`),
  KEY `utilisateur_fk` (`utilisateur_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id_commande` int(11) NOT NULL AUTO_INCREMENT,
  `date` int(11) NOT NULL,
  `facture` decimal(10,0) NOT NULL,
  `quantite_plat` int(11) NOT NULL,
  `quantite_dessert` int(11) NOT NULL,
  `utilisateur_fk` int(11) NOT NULL,
  `adresse_fk` int(11) NOT NULL,
  `ligne_de_commande_fk` int(11) NOT NULL,
  `statut_livraison_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_commande`),
  KEY `utilisateur_fk` (`utilisateur_fk`),
  KEY `adresse_fk` (`adresse_fk`),
  KEY `ligne_de_commande_fk` (`ligne_de_commande_fk`),
  KEY `statut_livraison_fk` (`statut_livraison_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ligne_de_commande`
--

DROP TABLE IF EXISTS `ligne_de_commande`;
CREATE TABLE IF NOT EXISTS `ligne_de_commande` (
  `id_ligne_de_commande` int(11) NOT NULL AUTO_INCREMENT,
  `quantite_plat` int(11) NOT NULL,
  `quantite_dessert` int(11) NOT NULL,
  `prix_unitaire` double NOT NULL,
  `total_commande` double NOT NULL,
  PRIMARY KEY (`id_ligne_de_commande`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `utilisateur_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_plat`),
  KEY `utilisateur_fk` (`utilisateur_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `statut_livraison`
--

DROP TABLE IF EXISTS `statut_livraison`;
CREATE TABLE IF NOT EXISTS `statut_livraison` (
  `id_statut_livraison` int(11) NOT NULL AUTO_INCREMENT,
  `latitude_position` decimal(10,0) NOT NULL,
  `longetude_position` decimal(10,0) NOT NULL,
  `commande_paye` tinyint(1) NOT NULL,
  `utilisateur_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_statut_livraison`),
  KEY `utilisateur_fk` (`utilisateur_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  KEY `adresse_fr` (`adresse_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `adresse`
--
ALTER TABLE `adresse`
  ADD CONSTRAINT `adresse_ibfk_1` FOREIGN KEY (`utilisateur_fk`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `commande_ibfk_1` FOREIGN KEY (`utilisateur_fk`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE,
  ADD CONSTRAINT `commande_ibfk_2` FOREIGN KEY (`adresse_fk`) REFERENCES `adresse` (`id_adresse`) ON DELETE CASCADE,
  ADD CONSTRAINT `commande_ibfk_3` FOREIGN KEY (`ligne_de_commande_fk`) REFERENCES `ligne_de_commande` (`id_ligne_de_commande`) ON DELETE CASCADE,
  ADD CONSTRAINT `commande_ibfk_4` FOREIGN KEY (`statut_livraison_fk`) REFERENCES `statut_livraison` (`id_statut_livraison`);

--
-- Contraintes pour la table `plat`
--
ALTER TABLE `plat`
  ADD CONSTRAINT `plat_ibfk_1` FOREIGN KEY (`utilisateur_fk`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `statut_livraison`
--
ALTER TABLE `statut_livraison`
  ADD CONSTRAINT `statut_livraison_ibfk_1` FOREIGN KEY (`utilisateur_fk`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`adresse_fk`) REFERENCES `adresse` (`id_adresse`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
