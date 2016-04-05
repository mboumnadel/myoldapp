-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 05, 2016 at 10:47 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mystore`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `date_account_opened` date NOT NULL,
  `account_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `gender` char(1) NOT NULL,
  `email_address` varchar(50) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `address_line_1` varchar(50) NOT NULL,
  `address_line_2` varchar(50) NOT NULL,
  `address_line_3` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `zipcode` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `financial_transaction`
--

CREATE TABLE IF NOT EXISTS `financial_transaction` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `invoice_number` int(11) NOT NULL,
  `transaction_type_code` varchar(10) NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_amount` decimal(10,0) NOT NULL,
  `transaction_comment` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index` (`account_id`),
  KEY `invoice_number_index` (`invoice_number`),
  KEY `trans_type_code_index` (`transaction_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE IF NOT EXISTS `invoices` (
  `invoice_number` int(11) NOT NULL,
  `invoice_date` date NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_number`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_line_items`
--

CREATE TABLE IF NOT EXISTS `invoice_line_items` (
  `order_item_id` int(11) NOT NULL,
  `invoice_number` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_title` varchar(50) NOT NULL,
  `product_qunatity` int(11) NOT NULL,
  `product_price` decimal(10,0) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `invoice_number_index` (`invoice_number`),
  KEY `product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `date_order_placed` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE IF NOT EXISTS `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id_index` (`order_id`),
  KEY `product_id_index` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL,
  `product_type_code` varchar(10) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_price` decimal(10,0) NOT NULL,
  `product_color` varchar(30) NOT NULL,
  `product_size` int(11) NOT NULL,
  `product_description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_type_code` (`product_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_types`
--

CREATE TABLE IF NOT EXISTS `product_types` (
  `product_type_code` varchar(10) NOT NULL,
  `parent_product_type_code` varchar(10) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`product_type_code`),
  KEY `index` (`parent_product_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_types`
--

CREATE TABLE IF NOT EXISTS `transaction_types` (
  `transaction_type_code` varchar(10) NOT NULL,
  `transaction_type_description` varchar(100) NOT NULL,
  PRIMARY KEY (`transaction_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `financial_transaction`
--
ALTER TABLE `financial_transaction`
  ADD CONSTRAINT `financial_transaction_ibfk_7` FOREIGN KEY (`transaction_type_code`) REFERENCES `transaction_types` (`transaction_type_code`),
  ADD CONSTRAINT `financial_transaction_ibfk_5` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `financial_transaction_ibfk_6` FOREIGN KEY (`invoice_number`) REFERENCES `invoices` (`invoice_number`);

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `invoice_line_items`
--
ALTER TABLE `invoice_line_items`
  ADD CONSTRAINT `invoice_line_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `invoice_line_items_ibfk_1` FOREIGN KEY (`invoice_number`) REFERENCES `invoices` (`invoice_number`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`product_type_code`) REFERENCES `product_types` (`product_type_code`);

--
-- Constraints for table `product_types`
--
ALTER TABLE `product_types`
  ADD CONSTRAINT `product_types_ibfk_1` FOREIGN KEY (`parent_product_type_code`) REFERENCES `product_types` (`product_type_code`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
