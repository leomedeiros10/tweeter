-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 21-Out-2014 às 19:05
-- Versão do servidor: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tweeter`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `favoritos`
--

CREATE TABLE IF NOT EXISTS `favoritos` (
  `codigo_tweet` int(11) NOT NULL,
  `codigo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_tweet`,`codigo_usuario`),
  KEY `fk_favoritos_tweets1_idx` (`codigo_tweet`),
  KEY `fk_favoritos_usuarios1` (`codigo_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mensagens`
--

CREATE TABLE IF NOT EXISTS `mensagens` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `texto` text,
  `imagem` varchar(50) DEFAULT NULL,
  `data_hora_envio` timestamp NULL DEFAULT NULL,
  `remetente` int(11) NOT NULL,
  `destinatario` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_mensagens_usuarios1_idx` (`remetente`),
  KEY `fk_mensagens_usuarios2_idx` (`destinatario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `respostas`
--

CREATE TABLE IF NOT EXISTS `respostas` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `texto` varchar(140) DEFAULT NULL,
  `imagem` varchar(50) DEFAULT NULL,
  `data_hora_postagem` timestamp NULL DEFAULT NULL,
  `codigo_tweet` int(11) NOT NULL,
  `codigo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_respostas_tweets1_idx` (`codigo_tweet`),
  KEY `fk_respostas_usuarios1_idx` (`codigo_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `retweets`
--

CREATE TABLE IF NOT EXISTS `retweets` (
  `data_hora_postagem` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `codigo_tweet` int(11) NOT NULL,
  `codigo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo_tweet`,`codigo_usuario`),
  KEY `fk_retweets_usuarios1_idx` (`codigo_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `seguidores`
--

CREATE TABLE IF NOT EXISTS `seguidores` (
  `codigo_seguidor` int(11) NOT NULL,
  `codigo_seguido` int(11) NOT NULL,
  PRIMARY KEY (`codigo_seguidor`,`codigo_seguido`),
  KEY `codigo_seguido` (`codigo_seguido`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `seguidores`
--

INSERT INTO `seguidores` (`codigo_seguidor`, `codigo_seguido`) VALUES
(7, 6),
(8, 6),
(6, 8);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tweets`
--

CREATE TABLE IF NOT EXISTS `tweets` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `texto` varchar(140) DEFAULT NULL,
  `data_hora_postagem` timestamp NULL DEFAULT NULL,
  `imagem` varchar(50) DEFAULT NULL,
  `codigo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_tweets_usuarios_idx` (`codigo_usuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `tweets`
--

INSERT INTO `tweets` (`codigo`, `texto`, `data_hora_postagem`, `imagem`, `codigo_usuario`) VALUES
(2, 'teste', '2014-10-21 09:05:07', NULL, 6),
(3, 'teste 123', '2014-10-21 09:05:10', NULL, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) DEFAULT NULL,
  `login` varchar(20) DEFAULT NULL,
  `senha` varchar(60) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `data_cadastro` date DEFAULT NULL,
  `foto` varchar(50) DEFAULT NULL,
  `descricao` text,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`codigo`, `nome`, `login`, `senha`, `email`, `data_cadastro`, `foto`, `descricao`) VALUES
(6, 'thiago augusto pereira', 'thiagotpk', '123456', 'thiago250694@gmail.com', NULL, NULL, 'lalala'),
(7, 'Samir Abrao', 'samir', '123456', 'samir@samir.com', NULL, NULL, 'samir'),
(8, 'leonardo a medeiros', 'leonardo', '123456', 'leonardo13@gmail.com', NULL, NULL, 'teste');

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `fk_favoritos_tweets1` FOREIGN KEY (`codigo_tweet`) REFERENCES `tweets` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_favoritos_usuarios1` FOREIGN KEY (`codigo_usuario`) REFERENCES `usuarios` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `mensagens`
--
ALTER TABLE `mensagens`
  ADD CONSTRAINT `fk_mensagens_usuarios1` FOREIGN KEY (`remetente`) REFERENCES `usuarios` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_mensagens_usuarios2` FOREIGN KEY (`destinatario`) REFERENCES `usuarios` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `respostas`
--
ALTER TABLE `respostas`
  ADD CONSTRAINT `fk_respostas_tweets1` FOREIGN KEY (`codigo_tweet`) REFERENCES `tweets` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_respostas_usuarios1` FOREIGN KEY (`codigo_usuario`) REFERENCES `usuarios` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `retweets`
--
ALTER TABLE `retweets`
  ADD CONSTRAINT `fk_retweets_tweets1` FOREIGN KEY (`codigo_tweet`) REFERENCES `tweets` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_retweets_usuarios1` FOREIGN KEY (`codigo_usuario`) REFERENCES `usuarios` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `seguidores`
--
ALTER TABLE `seguidores`
  ADD CONSTRAINT `seguidores_ibfk_2` FOREIGN KEY (`codigo_seguido`) REFERENCES `usuarios` (`codigo`),
  ADD CONSTRAINT `seguidores_ibfk_1` FOREIGN KEY (`codigo_seguidor`) REFERENCES `usuarios` (`codigo`);

--
-- Limitadores para a tabela `tweets`
--
ALTER TABLE `tweets`
  ADD CONSTRAINT `fk_tweets_usuarios` FOREIGN KEY (`codigo_usuario`) REFERENCES `usuarios` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
