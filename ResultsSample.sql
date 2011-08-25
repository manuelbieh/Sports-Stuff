-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 14. Dezember 2010 um 17:07
-- Server Version: 5.1.41
-- PHP-Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `matches`
--

CREATE TABLE IF NOT EXISTS `matches` (
  `match_id` int(11) NOT NULL AUTO_INCREMENT,
  `home_team_id` int(11) NOT NULL,
  `away_team_id` int(11) NOT NULL,
  `home_team_goals` int(11) NOT NULL,
  `away_team_goals` int(11) NOT NULL,
  `matchday` int(11) NOT NULL,
  PRIMARY KEY (`match_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Daten für Tabelle `matches`
--

-- Results of the first matchday of the german soccer bundesliga 2010/2011

INSERT INTO `matches` (`match_id`, `home_team_id`, `away_team_id`, `home_team_goals`, `away_team_goals`, `matchday`) VALUES
(1, 5, 14, 2, 1, 1),
(2, 16, 13, 1, 3, 1),
(3, 4, 8, 2, 1, 1),
(4, 18, 11, 1, 1, 1),
(5, 7, 12, 4, 1, 1),
(6, 6, 15, 1, 3, 1),
(7, 9, 10, 2, 1, 1),
(8, 3, 17, 2, 0, 1),
(9, 1, 2, 0, 2, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `teams`
--

CREATE TABLE IF NOT EXISTS `teams` (
  `team_id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(32) NOT NULL,
  PRIMARY KEY (`team_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Daten für Tabelle `teams`
--

INSERT INTO `teams` (`team_id`, `team_name`) VALUES
(1, 'Borussia Dortmund'),
(2, 'Bayer 04 Leverkusen'),
(3, 'FSV Mainz 05'),
(4, 'Hannover 96'),
(5, 'FC Bayern München'),
(6, 'SC Freiburg'),
(7, 'TSG 1899 Hoffenheim'),
(8, 'Eintracht Frankfurt'),
(9, 'Hamburger SV'),
(10, 'FC Schalke 04'),
(11, '1. FC Nürnberg'),
(12, 'SV Werder Bremen'),
(13, '1. FC Kaiserslautern'),
(14, 'VfL Wolfsburg'),
(15, 'FC St. Pauli'),
(16, '1. FC Köln'),
(17, 'VFB Stuttgart'),
(18, 'Borussia Mönchengladbach');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
