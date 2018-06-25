-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2018 at 08:24 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tsl_cube_messenger`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `starting_at` timestamp NULL DEFAULT NULL,
  `ending_at` timestamp NULL DEFAULT NULL,
  `all_day` tinyint(1) NOT NULL DEFAULT '0',
  `venue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `appointment_external_participants`
--

CREATE TABLE `appointment_external_participants` (
  `id` int(10) UNSIGNED NOT NULL,
  `appointment_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `appointment_internal_participants`
--

CREATE TABLE `appointment_internal_participants` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `appointment_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `appointment_items`
--

CREATE TABLE `appointment_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `appointment_id` int(10) UNSIGNED NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `billable_id` int(10) UNSIGNED NOT NULL,
  `billable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `status` enum('BLOCKED','SETTLED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BLOCKED',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `client_id`, `billable_id`, `billable_type`, `amount`, `status`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 'App\\Order', 430.96000000000004, 'BLOCKED', 'Purchase of 4 products', '2018-06-24 20:52:59', '2018-06-24 20:52:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `order`, `slug`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Office Furniture', 5, NULL, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(2, 'Laptops & Desktops', 3, NULL, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(3, 'Computer Accessories', 4, NULL, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(4, 'Electronics', 2, NULL, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(5, 'Office Stationary', 1, NULL, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'images/client_default.png',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_type` enum('POST_PAID','PRE_PAID') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PRE_PAID',
  `limit` double(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `name`, `logo`, `email`, `phone`, `account_type`, `limit`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Test Client', 'images/client_default.jpg', 'testclient@cube-messenger.com', '0700000001', 'PRE_PAID', 0.00, '2018-06-24 20:43:55', '2018-06-24 20:43:55', NULL),
(2, 'Test Client 2', 'images/client_default.jpg', 'testclient2@cube-messenger.com', '0700000002', 'PRE_PAID', 0.00, '2018-06-24 20:43:56', '2018-06-24 20:43:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cost_variables`
--

CREATE TABLE `cost_variables` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` double(8,2) NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cost_variables`
--

INSERT INTO `cost_variables` (`id`, `name`, `value`, `public`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'URGENT_COST_PER_KM', 3.15, 1, '2018-06-24 20:43:54', '2018-06-24 20:43:54', NULL),
(2, 'NON_URGENT_COST_PER_KM', 2.00, 1, '2018-06-24 20:43:54', '2018-06-24 20:43:54', NULL),
(3, 'ERRAND_COST_PER_KM', 3.15, 1, '2018-06-24 20:43:54', '2018-06-24 20:43:54', NULL),
(4, 'URGENT_COST_PER_MIN', 1.50, 1, '2018-06-24 20:43:55', '2018-06-24 20:43:55', NULL),
(5, 'NON_URGENT_COST_PER_MIN', 1.00, 1, '2018-06-24 20:43:55', '2018-06-24 20:43:55', NULL),
(6, 'ERRAND_COST_PER_MIN', 3.00, 1, '2018-06-24 20:43:55', '2018-06-24 20:43:55', NULL),
(7, 'URGENT_BASE_COST', 150.00, 1, '2018-06-24 20:43:55', '2018-06-24 20:43:55', NULL),
(8, 'NON_URGENT_BASE_COST', 50.00, 1, '2018-06-24 20:43:55', '2018-06-24 20:43:55', NULL),
(9, 'ERRAND_BASE_COST', 150.00, 1, '2018-06-24 20:43:55', '2018-06-24 20:43:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `courier_options`
--

CREATE TABLE `courier_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plural_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courier_options`
--

INSERT INTO `courier_options` (`id`, `name`, `plural_name`, `icon`, `active`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Envelope', 'Envelopes', 'images/envelope.png', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:03', '2018-06-24 20:44:03', NULL),
(2, 'Box', 'Boxes', 'images/box.jpg', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(3, 'Errand', 'Errands', 'images/errand.gif', 0, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `crud_headers`
--

CREATE TABLE `crud_headers` (
  `id` int(10) UNSIGNED NOT NULL,
  `model` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `align` enum('left','center','right') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'left',
  `value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('text','textarea','number','email','boolean','select','select_remote','date','time','timestamp') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `options` text COLLATE utf8mb4_unicode_ci COMMENT 'Comma separated or url to options for select_remote',
  `mask` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `edit_hint` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_hint` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `edit_required` tinyint(1) NOT NULL DEFAULT '1',
  `create_required` tinyint(1) NOT NULL DEFAULT '1',
  `viewable` tinyint(1) NOT NULL DEFAULT '1',
  `editable` tinyint(1) NOT NULL DEFAULT '1',
  `creatable` tinyint(1) NOT NULL DEFAULT '1',
  `browsable` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `crud_headers`
--

INSERT INTO `crud_headers` (`id`, `model`, `text`, `align`, `value`, `type`, `options`, `mask`, `priority`, `edit_hint`, `create_hint`, `edit_required`, `create_required`, `viewable`, `editable`, `creatable`, `browsable`, `created_at`, `updated_at`) VALUES
(1, 'App\\Client', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:07', '2018-06-24 20:44:07'),
(2, 'App\\Client', 'Name', 'left', 'name', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:07', '2018-06-24 20:44:07'),
(3, 'App\\Client', 'Email', 'left', 'email', 'email', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(4, 'App\\Client', 'Phone', 'left', 'phone', 'text', NULL, '##########', 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(5, 'App\\Client', 'Account Type', 'left', 'accountType', 'select', 'PRE_PAID,POST_PAID', NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(6, 'App\\Client', 'Limit', 'left', 'limit', 'text', NULL, '######', 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(7, 'App\\Client', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(8, 'App\\Client', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(9, 'App\\User', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(10, 'App\\User', 'Client', 'left', 'clientId', 'select_remote', 'clients/search', NULL, 0, 'Leave empty to keep user on with current client', NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(11, 'App\\User', 'Role', 'left', 'roleId', 'select_remote', 'roles/search', NULL, 0, 'Leave empty to keep user with the same role', NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(12, 'App\\User', 'Name', 'left', 'name', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(13, 'App\\User', 'Email', 'left', 'email', 'email', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(14, 'App\\User', 'Password', 'left', 'password', 'email', NULL, NULL, 0, 'Leave empty to keep the same password', 'Password will be sent to the user phone number', 0, 1, 0, 1, 1, 0, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(15, 'App\\User', 'Phone', 'left', 'phone', 'text', NULL, '##########', 0, NULL, 'User password will be sent to this phone number', 1, 1, 1, 1, 1, 0, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(16, 'App\\User', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(17, 'App\\User', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(18, 'App\\TopUp', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(19, 'App\\TopUp', 'Client', 'left', 'clientId', 'select_remote', 'clients/search', NULL, 0, NULL, NULL, 1, 1, 1, 0, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(20, 'App\\TopUp', 'Amount', 'left', 'amount', 'text', NULL, '######', 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(21, 'App\\TopUp', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(22, 'App\\TopUp', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(23, 'App\\Role', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(24, 'App\\Role', 'Name', 'left', 'name', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:08', '2018-06-24 20:44:08'),
(25, 'App\\Role', 'Display Name', 'left', 'displayName', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(26, 'App\\Role', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(27, 'App\\Role', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(28, 'App\\Department', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(29, 'App\\Department', 'Name', 'left', 'name', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(30, 'App\\Department', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(31, 'App\\Department', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(32, 'App\\Product', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(33, 'App\\Product', 'Supplier', 'left', 'supplierId', 'select_remote', 'suppliers/search', NULL, 0, 'Leave empty to keep same supplier', NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(34, 'App\\Product', 'Name', 'left', 'name', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(35, 'App\\Product', 'Price', 'left', 'price', 'text', NULL, '#####', 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(36, 'App\\Product', 'Description', 'left', 'description', 'textarea', NULL, NULL, 0, NULL, NULL, 0, 0, 1, 1, 1, 0, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(37, 'App\\Product', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(38, 'App\\Product', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 0, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(39, 'App\\Order', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(40, 'App\\Order', 'Items', 'left', 'itemCount', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(41, 'App\\Order', 'Amount', 'left', 'amount', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(42, 'App\\Order', 'Status', 'left', 'status', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:09', '2018-06-24 20:44:09'),
(43, 'App\\Order', 'RejectedBy', 'left', 'rejectedBy', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(44, 'App\\Order', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 0, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(45, 'App\\Order', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 0, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(46, 'App\\OrderItem', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(47, 'App\\OrderItem', 'Product', 'left', 'product', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(48, 'App\\OrderItem', 'Supplier', 'left', 'supplier', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(49, 'App\\OrderItem', 'Quantity', 'left', 'quantity', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(50, 'App\\OrderItem', 'Price at Purchase', 'left', 'priceAtPurchase', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(51, 'App\\OrderItem', 'Amount', 'left', 'amount', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(52, 'App\\OrderItem', 'Status', 'left', 'status', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(53, 'App\\OrderItem', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 0, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(54, 'App\\OrderItem', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 0, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(55, 'App\\Category', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(56, 'App\\Category', 'Name', 'left', 'name', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(57, 'App\\Category', 'Order', 'left', 'order', 'number', NULL, '#', 0, NULL, NULL, 1, 1, 1, 1, 1, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(58, 'App\\Category', 'Items', 'left', 'productsCount', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:10', '2018-06-24 20:44:10'),
(59, 'App\\Category', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 0, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(60, 'App\\Category', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 0, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(61, 'App\\Delivery', 'Id', 'left', 'id', 'number', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 0, 1, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(62, 'App\\Delivery', 'Client', 'left', 'client', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 1, 1, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(63, 'App\\Delivery', 'Rider', 'left', 'riderId', 'select_remote', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 1, 0, 1, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(64, 'App\\Delivery', 'From', 'left', 'from', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 1, 1, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(65, 'App\\Delivery', 'Items', 'left', 'itemsCount', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 1, 1, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(66, 'App\\Delivery', 'Date', 'left', 'date', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 1, 1, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(67, 'App\\Delivery', 'Time', 'left', 'time', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 1, 1, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(68, 'App\\Delivery', 'Status', 'left', 'status', 'text', NULL, NULL, 0, NULL, NULL, 1, 1, 1, 0, 1, 1, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(69, 'App\\Delivery', 'Created At', 'left', 'createdAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 0, '2018-06-24 20:44:11', '2018-06-24 20:44:11'),
(70, 'App\\Delivery', 'Updated At', 'left', 'updatedAt', 'date', NULL, NULL, 0, NULL, NULL, 1, 1, 0, 0, 0, 0, '2018-06-24 20:44:11', '2018-06-24 20:44:11');

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `urgent` tinyint(1) NOT NULL,
  `origin_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origin_vicinity` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origin_formatted_address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `origin_latitude` double(8,5) NOT NULL,
  `origin_longitude` double(8,5) NOT NULL,
  `schedule_date` date NOT NULL,
  `schedule_time` time NOT NULL,
  `estimated_cost` double(8,2) NOT NULL,
  `estimated_max_distance` double(8,2) NOT NULL,
  `estimated_max_duration` double(8,2) NOT NULL,
  `rider_id` int(10) UNSIGNED DEFAULT NULL,
  `pickup_time` timestamp NULL DEFAULT NULL,
  `pickup_latitude` double(8,5) DEFAULT NULL,
  `pickup_longitude` double(8,5) DEFAULT NULL,
  `status` enum('AT_DEPARTMENT_HEAD','AT_PURCHASING_HEAD','REJECTED','PENDING_DELIVERY') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AT_DEPARTMENT_HEAD',
  `department_head_acted_at` timestamp NULL DEFAULT NULL,
  `purchasing_head_acted_at` timestamp NULL DEFAULT NULL,
  `rejected_by_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_items`
--

CREATE TABLE `delivery_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `courier_option_id` int(10) UNSIGNED NOT NULL,
  `delivery_id` int(10) UNSIGNED NOT NULL,
  `destination_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_vicinity` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_formatted_address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_latitude` double(8,5) NOT NULL,
  `destination_longitude` double(8,5) NOT NULL,
  `recipient_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `recipient_contact` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` smallint(5) UNSIGNED NOT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estimated_distance` double(8,2) NOT NULL,
  `estimated_duration` double(8,2) NOT NULL,
  `status` enum('EN_ROUTE_TO_DESTINATION','AT_DESTINATION') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estimated_arrival_time` timestamp NULL DEFAULT NULL,
  `received_confirmation_code` smallint(5) UNSIGNED DEFAULT NULL,
  `received_time` timestamp NULL DEFAULT NULL,
  `received_latitude` double(8,5) DEFAULT NULL,
  `received_longitude` double(8,5) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `client_id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Test Department', '2018-06-24 20:44:01', '2018-06-24 20:44:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `local_purchase_orders`
--

CREATE TABLE `local_purchase_orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `local_purchase_orders`
--

INSERT INTO `local_purchase_orders` (`id`, `supplier_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 4, '2018-06-24 20:54:49', '2018-06-24 20:54:49', NULL),
(2, 4, '2018-06-24 20:55:18', '2018-06-24 20:55:18', NULL),
(3, 4, '2018-06-24 20:58:33', '2018-06-24 20:58:33', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `local_purchase_order_items`
--

CREATE TABLE `local_purchase_order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `local_purchase_order_id` int(10) UNSIGNED NOT NULL,
  `order_item_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `local_purchase_order_items`
--

INSERT INTO `local_purchase_order_items` (`id`, `local_purchase_order_id`, `order_item_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 2, '2018-06-24 20:58:33', '2018-06-24 20:58:33', NULL),
(2, 3, 3, '2018-06-24 20:58:33', '2018-06-24 20:58:33', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(65, '2014_01_10_071110_create_clients_table', 1),
(66, '2014_01_11_071110_create_top_ups_table', 1),
(67, '2014_01_11_115437_create_departments_table', 1),
(68, '2014_10_10_190000_create_roles_table', 1),
(69, '2014_10_12_000000_create_users_table', 1),
(70, '2014_10_12_100000_create_password_resets_table', 1),
(71, '2018_01_12_121710_create_sms_messages_table', 1),
(72, '2018_01_30_094836_create_courier_options_table', 1),
(73, '2018_01_30_101110_create_cost_variables_table', 1),
(74, '2018_02_08_101907_create_deliveries_table', 1),
(75, '2018_02_08_103250_create_delivery_items_table', 1),
(76, '2018_02_26_134302_create_subscription_options_table', 1),
(77, '2018_02_26_154259_create_subscription_option_items_table', 1),
(78, '2018_02_27_155538_create_subscriptions_table', 1),
(79, '2018_03_01_133356_create_subscription_deliveries_table', 1),
(80, '2018_03_13_120127_create_appointments_table', 1),
(81, '2018_03_16_121623_create_appointment_internal_participants_table', 1),
(82, '2018_03_16_134619_create_appointment_external_participants_table', 1),
(83, '2018_03_16_141829_create_appointment_items_table', 1),
(84, '2018_03_17_121308_create_categories_table', 1),
(85, '2018_03_17_121317_create_products_table', 1),
(86, '2018_03_17_130028_create_orders_table', 1),
(87, '2018_03_17_135546_create_order_items_table', 1),
(88, '2018_03_18_130750_create_service_request_options_table', 1),
(89, '2018_03_24_085521_create_service_requests_table', 1),
(90, '2018_04_09_101150_create_bills_table', 1),
(91, '2018_04_17_104322_create_service_request_quotes_table', 1),
(92, '2018_04_17_104803_create_service_request_items_table', 1),
(93, '2018_05_10_124141_create_notifications_table', 1),
(94, '2018_05_22_124701_create_crud_headers_table', 1),
(95, '2018_06_16_132352_create_local_purchase_orders_table', 1),
(96, '2018_06_16_132403_create_local_purchase_order_items_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` int(10) UNSIGNED NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_id`, `notifiable_type`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('d9e80d8e-d0db-414b-bf9a-e7848be03203', 'App\\Notifications\\BillNotification', 1, 'App\\Client', '[]', NULL, '2018-06-24 20:53:03', '2018-06-24 20:53:03'),
('df3a57fc-a508-4f48-8e94-0d6f50dda593', 'App\\Notifications\\TopUpNotification', 1, 'App\\Client', '[]', NULL, '2018-06-24 20:44:01', '2018-06-24 20:44:01'),
('e4d980f7-02c9-4043-91ba-4c2ec825dfbc', 'App\\Notifications\\LPONotification', 4, 'App\\User', '[]', NULL, '2018-06-24 20:55:22', '2018-06-24 20:55:22'),
('efea39fb-32d7-4b12-94b0-eb59bb1a1986', 'App\\Notifications\\OrderNotification', 1, 'App\\Client', '[]', NULL, '2018-06-24 20:53:08', '2018-06-24 20:53:08'),
('fd35f70d-7ec1-4544-ab0d-fef4b02d0580', 'App\\Notifications\\LPONotification', 4, 'App\\User', '[]', NULL, '2018-06-24 20:58:38', '2018-06-24 20:58:38');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `status` enum('AT_DEPARTMENT_HEAD','AT_PURCHASING_HEAD','REJECTED','PENDING_DELIVERY','DELIVERED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AT_DEPARTMENT_HEAD',
  `rejected_by_id` int(10) UNSIGNED DEFAULT NULL,
  `department_head_acted_at` timestamp NULL DEFAULT NULL,
  `purchasing_head_acted_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `status`, `rejected_by_id`, `department_head_acted_at`, `purchasing_head_acted_at`, `delivered_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 7, 'PENDING_DELIVERY', NULL, '2018-06-24 20:53:51', '2018-06-24 20:54:06', NULL, '2018-06-24 20:52:58', '2018-06-24 20:54:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `price_at_purchase` double NOT NULL,
  `status` enum('PENDING_LPO','ACCEPTED_BY_SUPPLIER','REJECTED_BY_SUPPLIER') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price_at_purchase`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, 106.52, 'ACCEPTED_BY_SUPPLIER', '2018-06-24 20:52:58', '2018-06-24 20:54:49', NULL),
(2, 1, 2, 1, 115.23, 'ACCEPTED_BY_SUPPLIER', '2018-06-24 20:52:58', '2018-06-24 20:58:33', NULL),
(3, 1, 3, 1, 160.98, 'ACCEPTED_BY_SUPPLIER', '2018-06-24 20:52:58', '2018-06-24 20:58:33', NULL),
(4, 1, 4, 1, 48.23, 'REJECTED_BY_SUPPLIER', '2018-06-24 20:52:59', '2018-06-24 20:58:33', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'images/product_default.jpg',
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `supplier_id`, `name`, `image`, `slug`, `price`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 5, 4, 'Highlighter', 'images/product_default.jpg', NULL, 106.52, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(2, 5, 4, 'Permanent marker (Texta / Sharpie)', 'images/product_default.jpg', NULL, 115.23, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(3, 5, 4, 'Pencil and pencil sharpener', 'images/product_default.jpg', NULL, 160.98, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(4, 5, 4, 'Colored pencils', 'images/product_default.jpg', NULL, 48.23, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(5, 5, 4, 'Colored pens', 'images/product_default.jpg', NULL, 171.63, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(6, 5, 4, 'Correction tape / fluid / Liquid Paper', 'images/product_default.jpg', NULL, 166.42, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(7, 5, 4, 'Eraser', 'images/product_default.jpg', NULL, 75.16, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(8, 5, 4, 'Mechanical pencil and spare leads', 'images/product_default.jpg', NULL, 34.13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(9, 5, 4, 'Plain paper (for printer)', 'images/product_default.jpg', NULL, 67.88, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(10, 5, 4, 'Notebooks, ruled paper, binder books', 'images/product_default.jpg', NULL, 75.57, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(11, 5, 4, 'Scrapbook, art book', 'images/product_default.jpg', NULL, 149.29, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(12, 5, 4, 'Ruler', 'images/product_default.jpg', NULL, 170.58, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(13, 5, 4, 'Glue', 'images/product_default.jpg', NULL, 79.16, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(14, 5, 4, 'Sticky tape + dispenser', 'images/product_default.jpg', NULL, 68.82, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(15, 5, 4, 'Packing tape + dispenser', 'images/product_default.jpg', NULL, 160.3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'ADMIN', 'Administrator', '2018-06-24 20:44:01', '2018-06-24 20:44:01', NULL),
(2, 'OPERATIONS', 'Operations', '2018-06-24 20:44:01', '2018-06-24 20:44:01', NULL),
(3, 'SUPPLIER', 'Supplier', '2018-06-24 20:44:01', '2018-06-24 20:44:01', NULL),
(4, 'CLIENT_ADMIN', 'Client Administrator', '2018-06-24 20:44:01', '2018-06-24 20:44:01', NULL),
(5, 'PURCHASING_HEAD', 'Purchasing Head', '2018-06-24 20:44:01', '2018-06-24 20:44:01', NULL),
(6, 'DEPARTMENT_HEAD', 'Department Head', '2018-06-24 20:44:01', '2018-06-24 20:44:01', NULL),
(7, 'DEPARTMENT_USER', 'Department User', '2018-06-24 20:44:02', '2018-06-24 20:44:02', NULL),
(8, 'RIDER', 'Rider', '2018-06-24 20:44:02', '2018-06-24 20:44:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `service_requests`
--

CREATE TABLE `service_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `assigned_to` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('IT','REPAIR') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('AT_DEPARTMENT_HEAD','AT_PURCHASING_HEAD','PENDING_QUOTE','PENDING_QUOTE_CONFIRMATION','QUOTE_REJECTED','PENDING_ATTENDANCE','ATTENDED','REJECTED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AT_DEPARTMENT_HEAD',
  `rejected_by_id` int(10) UNSIGNED DEFAULT NULL,
  `details` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_date` date DEFAULT NULL,
  `schedule_time` time DEFAULT NULL,
  `department_head_acted_at` timestamp NULL DEFAULT NULL,
  `purchasing_head_acted_at` timestamp NULL DEFAULT NULL,
  `attended_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_request_items`
--

CREATE TABLE `service_request_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `service_request_quote_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_request_options`
--

CREATE TABLE `service_request_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('IT','REPAIR') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `service_request_options`
--

INSERT INTO `service_request_options` (`id`, `type`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'IT', 'Computer is slow', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(2, 'IT', 'Computer keeps restarting', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(3, 'IT', 'Keyboard, mouse, printer or other peripherals aren’t working properly', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(4, 'IT', 'Computer not booting', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(5, 'IT', 'Frozen screen', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(6, 'IT', 'Strange noises', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(7, 'IT', 'Slow internet', '2018-06-24 20:44:06', '2018-06-24 20:44:06', NULL),
(8, 'IT', 'Overheating', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(9, 'IT', 'Downloads take forever', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(10, 'IT', 'Computer freezes', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(11, 'IT', 'Attachments not opening', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(12, 'IT', 'Pop-up ads', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(13, 'IT', 'Corrupt files', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(14, 'IT', 'Long delays accessing files', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(15, 'IT', 'Sudden Shut off', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(16, 'IT', 'Computer not turning On', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(17, 'IT', 'Applications not installing', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(18, 'IT', 'Applications running slowly', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(19, 'IT', 'Blue Screen of Death (BSoD)', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(20, 'REPAIR', 'Wall Painting', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(21, 'REPAIR', 'Broken Chair', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(22, 'REPAIR', 'Broken Desk', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL),
(23, 'REPAIR', 'Broken Door Handle', '2018-06-24 20:44:07', '2018-06-24 20:44:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `service_request_quotes`
--

CREATE TABLE `service_request_quotes` (
  `id` int(10) UNSIGNED NOT NULL,
  `service_request_id` int(10) UNSIGNED NOT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diagnosis_cost` double(8,2) NOT NULL,
  `labour_cost` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms_messages`
--

CREATE TABLE `sms_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `subscription_option_item_id` int(10) UNSIGNED NOT NULL,
  `weekdays` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_cost` double(8,2) NOT NULL,
  `item_cost` double(8,2) NOT NULL,
  `renew_every_month` tinyint(1) NOT NULL DEFAULT '1',
  `termination_date` date DEFAULT NULL,
  `quantity` mediumint(8) UNSIGNED NOT NULL,
  `status` enum('AT_DEPARTMENT_HEAD','AT_PURCHASING_HEAD','REJECTED','EXPIRED','ACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AT_DEPARTMENT_HEAD',
  `department_head_acted_at` timestamp NULL DEFAULT NULL,
  `purchasing_head_acted_at` timestamp NULL DEFAULT NULL,
  `rejected_by_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_deliveries`
--

CREATE TABLE `subscription_deliveries` (
  `id` int(10) UNSIGNED NOT NULL,
  `subscription_id` int(10) UNSIGNED NOT NULL,
  `received_by_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_options`
--

CREATE TABLE `subscription_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_cost` smallint(5) UNSIGNED NOT NULL COMMENT 'Base cost for delivering the item to the client',
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscription_options`
--

INSERT INTO `subscription_options` (`id`, `name`, `delivery_cost`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Newspaper', 5, NULL, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(2, 'Milk', 10, NULL, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(3, 'Water', 5, NULL, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subscription_option_items`
--

CREATE TABLE `subscription_option_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscription_option_id` int(10) UNSIGNED DEFAULT NULL,
  `price` smallint(5) UNSIGNED NOT NULL COMMENT 'Current retail price of the item',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscription_option_items`
--

INSERT INTO `subscription_option_items` (`id`, `name`, `subscription_option_id`, `price`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Daily Nation', 1, 65, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(2, 'The Standard', 1, 65, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(3, 'The Star', 1, 65, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(4, 'The EastAfrican', 1, 65, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(5, 'Business Daily Africa', 1, 65, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(6, 'Taifa Leo', 1, 65, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(7, 'Kenya Times', 1, 65, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(8, 'Kenya Gazzette', 1, 65, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(9, 'Brookside 500 ML', 2, 55, '2018-06-24 20:44:04', '2018-06-24 20:44:04', NULL),
(10, 'Tuzo 500 ML', 2, 55, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(11, 'Ilara 500 ML', 2, 55, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(12, 'Gold Crown 500 ML', 2, 55, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(13, 'Molo Milk 500 ML', 2, 55, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL),
(14, 'Aqua', 3, 200, '2018-06-24 20:44:05', '2018-06-24 20:44:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `top_ups`
--

CREATE TABLE `top_ups` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `top_ups`
--

INSERT INTO `top_ups` (`id`, `client_id`, `amount`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 5000, '2018-06-24 20:43:56', '2018-06-24 20:43:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED DEFAULT NULL,
  `department_id` int(10) UNSIGNED DEFAULT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'users/default.png',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_recovery_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `client_id`, `department_id`, `role_id`, `avatar`, `name`, `email`, `phone`, `password`, `password_recovery_code`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, 1, 'users/default.png', 'Administrator', 'admin@cube-messenger.com', '254700000000', '$2y$10$8gr86rP9ibPNJyvRIIIgQecvsptP.LbqgP6oi3gMmgIn5s4Z29AqW', NULL, 'FRJOxZWMfOKDWShkZnvVXqqjzjzM3KAREdw4gIUTfXBFaEAEZQV4uWxDnlav', '2018-06-24 20:44:02', '2018-06-24 20:44:02', NULL),
(2, NULL, NULL, 2, 'users/default.png', 'Operations', 'operations@cube-messenger.com', '254700000001', '$2y$10$0SBcM5A.Hh4azthkk8hjFeUv65nJQdDF4TD88zK2eNo8iV8ZUhqcq', NULL, 'Gsr0ECNDGZZbPIdqFtDWnwMtAd3oPsMjIK2jmGi3AEIWrSyPGQy4Z6hG6aLv', '2018-06-24 20:44:02', '2018-06-24 20:44:02', NULL),
(3, 1, NULL, 4, 'users/default.png', 'Test Admin', 'testadmin@cube-messenger.com', NULL, '$2y$10$UIIGTxdyCaTsQzSc6mnVt.FFckdb6bzsSICZtz4r4j3DIa.HstM.C', NULL, 'k0TTdvd23unl6d50XEdE9a9vPQKYIAjZLdiIIIbDEn1wwGKJ9uDrPs0iY5kN', '2018-06-24 20:44:02', '2018-06-24 20:44:02', NULL),
(4, NULL, NULL, 3, 'users/default.png', 'Test Supplier', 'testsupplier@cube-messenger.com', NULL, '$2y$10$Edqx/gWSSoJKFbVVuzrNHeH/iCZ5K4hr46wdXDK3bV7yCT0OpemWK', NULL, 'DvrgyRWkxfoJHAbuHJYmprrYriaFl5xnThHUzOKUfnYs4jwYqQlgRO7BD0GR', '2018-06-24 20:44:02', '2018-06-24 20:44:02', NULL),
(5, 1, NULL, 5, 'users/default.png', 'Test Purchasing Head', 'testpurchasinghead@cube-messenger.com', NULL, '$2y$10$7Ha01DNgCvq6ALvvVGQlOuvyHminrIO3V/Qs0qtUs334VWhNfHOM.', NULL, '38Z0qfCfRHGLCmkbY3xqdzWnNzSeNdz1pusK3t3GLUs9VurF8PkfyBbaVoX9', '2018-06-24 20:44:02', '2018-06-24 20:44:02', NULL),
(6, 1, 1, 6, 'users/default.png', 'Test Department Head', 'testdepartmenthead@cube-messenger.com', NULL, '$2y$10$z6bSo6z7Wd0.SIGlPqv/rempOoK/A4hJLMNY5dnHXX4XZZcAzEw16', NULL, 'evZLnDeTVtRzXu7hObbgnPXe5hPl7PN9eDvOPrVVQ4AqHwusyon1uFcyHlyV', '2018-06-24 20:44:03', '2018-06-24 20:44:03', NULL),
(7, 1, 1, 7, 'users/default.png', 'Test Department User', 'testdepartmentuser@cube-messenger.com', NULL, '$2y$10$.LKb9WlfE8Jjbu1T8xzJ6e6QRKL72nOHLJDQ1paFn9Cdvpc602hPy', NULL, 'vmZG9z3GZpQnfQ6F1UnvIqJoa7j2dqlJgpaqTwWAI3DnDT2nakeQ2ZtSCHOk', '2018-06-24 20:44:03', '2018-06-24 20:44:03', NULL),
(8, NULL, NULL, 8, 'users/default.png', 'Test Rider ', 'testrider@cube-messenger.com', '443-936-7402 x069', '$2y$10$d68MsH3ZCSYNgw55EyZ46.G.A3z7nHdpjsanQl9HOkJM/14Cs3XRS', NULL, 'nnaVk6MOJtPlYVbp6McihIR7fNZVNzhRJlGA2X5U2W5XwYVPHS3AnTndqi14', '2018-06-24 20:44:03', '2018-06-24 20:44:03', NULL),
(9, NULL, NULL, 8, 'users/default.png', 'Test Rider 1', 'testrider1@cube-messenger.com', '771-930-7154', '$2y$10$iJYemNiwvGw455GS9w8tTeim57vYmEcEFtMqAsofgNeWTD5gdilXy', NULL, '8v7lfii65s68gZP7sO4CwNfjaTFkHErl4wwSyShQuSpnB28YYHTkOjxX1p8j', '2018-06-24 20:44:03', '2018-06-24 20:44:03', NULL),
(10, NULL, NULL, 8, 'users/default.png', 'Test Rider 2', 'testrider2@cube-messenger.com', '(559) 895-1620 x77247', '$2y$10$xeWOmOMTPrre3BVaTHLd8uKuEUoV2O2gD0ZA.n/7nR/075O92fylO', NULL, 'g658HnnMEARnPoOy6Tg0dNbpY7zYKHj5dmP2ajhWRnpe709TbcNjKT2fZptl', '2018-06-24 20:44:03', '2018-06-24 20:44:03', NULL),
(11, NULL, NULL, 8, 'users/default.png', 'Test Rider 3', 'testrider3@cube-messenger.com', '685-672-7529 x58916', '$2y$10$3SjtiG7Fe8Rl1PJaLpEjj.FmwCx8r5W6uV4YtMekJK4BVl2xYxiwa', NULL, 'mQnqret1WsnrfNbkjJhMtO9nAY3LDoJA52zn7nMo9SUUhlc5deWWNK47HiOw', '2018-06-24 20:44:03', '2018-06-24 20:44:03', NULL),
(12, NULL, NULL, 8, 'users/default.png', 'Test Rider 4', 'testrider4@cube-messenger.com', '(313) 334-0086 x38654', '$2y$10$gkA0B86bHwU3XN1dCiHUqecIJz4Mo3SlWMHb0pSSNEESq7GZFBYDW', NULL, 'Kgan2OaI1VMZOwicq7XeAe4JMzasok5OF8kStmSK92elQ0HiqRp5AVLhGDwY', '2018-06-24 20:44:03', '2018-06-24 20:44:03', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointments_user_id_foreign` (`user_id`);

--
-- Indexes for table `appointment_external_participants`
--
ALTER TABLE `appointment_external_participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_external_participants_appointment_id_foreign` (`appointment_id`);

--
-- Indexes for table `appointment_internal_participants`
--
ALTER TABLE `appointment_internal_participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_internal_participants_user_id_foreign` (`user_id`),
  ADD KEY `appointment_internal_participants_appointment_id_foreign` (`appointment_id`);

--
-- Indexes for table `appointment_items`
--
ALTER TABLE `appointment_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_items_appointment_id_foreign` (`appointment_id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bills_client_id_foreign` (`client_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clients_email_unique` (`email`),
  ADD UNIQUE KEY `clients_phone_unique` (`phone`);

--
-- Indexes for table `cost_variables`
--
ALTER TABLE `cost_variables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cost_variables_name_unique` (`name`);

--
-- Indexes for table `courier_options`
--
ALTER TABLE `courier_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courier_options_name_unique` (`name`),
  ADD UNIQUE KEY `courier_options_plural_name_unique` (`plural_name`);

--
-- Indexes for table `crud_headers`
--
ALTER TABLE `crud_headers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deliveries_user_id_foreign` (`user_id`),
  ADD KEY `deliveries_rider_id_foreign` (`rider_id`),
  ADD KEY `deliveries_rejected_by_id_foreign` (`rejected_by_id`);

--
-- Indexes for table `delivery_items`
--
ALTER TABLE `delivery_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_items_courier_option_id_foreign` (`courier_option_id`),
  ADD KEY `delivery_items_delivery_id_foreign` (`delivery_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departments_client_id_foreign` (`client_id`);

--
-- Indexes for table `local_purchase_orders`
--
ALTER TABLE `local_purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `local_purchase_orders_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `local_purchase_order_items`
--
ALTER TABLE `local_purchase_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `local_purchase_order_items_local_purchase_order_id_foreign` (`local_purchase_order_id`),
  ADD KEY `local_purchase_order_items_order_item_id_foreign` (`order_item_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_id_notifiable_type_index` (`notifiable_id`,`notifiable_type`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_rejected_by_id_foreign` (`rejected_by_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `service_requests`
--
ALTER TABLE `service_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_requests_user_id_foreign` (`user_id`),
  ADD KEY `service_requests_assigned_to_foreign` (`assigned_to`),
  ADD KEY `service_requests_rejected_by_id_foreign` (`rejected_by_id`);

--
-- Indexes for table `service_request_items`
--
ALTER TABLE `service_request_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_request_items_service_request_quote_id_foreign` (`service_request_quote_id`);

--
-- Indexes for table `service_request_options`
--
ALTER TABLE `service_request_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_request_quotes`
--
ALTER TABLE `service_request_quotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_request_quotes_service_request_id_foreign` (`service_request_id`);

--
-- Indexes for table `sms_messages`
--
ALTER TABLE `sms_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriptions_user_id_foreign` (`user_id`),
  ADD KEY `subscriptions_subscription_option_item_id_foreign` (`subscription_option_item_id`),
  ADD KEY `subscriptions_rejected_by_id_foreign` (`rejected_by_id`);

--
-- Indexes for table `subscription_deliveries`
--
ALTER TABLE `subscription_deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscription_deliveries_subscription_id_foreign` (`subscription_id`),
  ADD KEY `subscription_deliveries_received_by_id_foreign` (`received_by_id`);

--
-- Indexes for table `subscription_options`
--
ALTER TABLE `subscription_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription_option_items`
--
ALTER TABLE `subscription_option_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscription_option_items_subscription_option_id_foreign` (`subscription_option_id`);

--
-- Indexes for table `top_ups`
--
ALTER TABLE `top_ups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `top_ups_client_id_foreign` (`client_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`),
  ADD KEY `users_client_id_foreign` (`client_id`),
  ADD KEY `users_department_id_foreign` (`department_id`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointment_external_participants`
--
ALTER TABLE `appointment_external_participants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointment_internal_participants`
--
ALTER TABLE `appointment_internal_participants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointment_items`
--
ALTER TABLE `appointment_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cost_variables`
--
ALTER TABLE `cost_variables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `courier_options`
--
ALTER TABLE `courier_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `crud_headers`
--
ALTER TABLE `crud_headers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_items`
--
ALTER TABLE `delivery_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `local_purchase_orders`
--
ALTER TABLE `local_purchase_orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `local_purchase_order_items`
--
ALTER TABLE `local_purchase_order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `service_requests`
--
ALTER TABLE `service_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_request_items`
--
ALTER TABLE `service_request_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_request_options`
--
ALTER TABLE `service_request_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `service_request_quotes`
--
ALTER TABLE `service_request_quotes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms_messages`
--
ALTER TABLE `sms_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_deliveries`
--
ALTER TABLE `subscription_deliveries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_options`
--
ALTER TABLE `subscription_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscription_option_items`
--
ALTER TABLE `subscription_option_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `top_ups`
--
ALTER TABLE `top_ups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `appointment_external_participants`
--
ALTER TABLE `appointment_external_participants`
  ADD CONSTRAINT `appointment_external_participants_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`);

--
-- Constraints for table `appointment_internal_participants`
--
ALTER TABLE `appointment_internal_participants`
  ADD CONSTRAINT `appointment_internal_participants_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`),
  ADD CONSTRAINT `appointment_internal_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `appointment_items`
--
ALTER TABLE `appointment_items`
  ADD CONSTRAINT `appointment_items_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`);

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_rejected_by_id_foreign` FOREIGN KEY (`rejected_by_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `deliveries_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `deliveries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `delivery_items`
--
ALTER TABLE `delivery_items`
  ADD CONSTRAINT `delivery_items_courier_option_id_foreign` FOREIGN KEY (`courier_option_id`) REFERENCES `courier_options` (`id`),
  ADD CONSTRAINT `delivery_items_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`);

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Constraints for table `local_purchase_orders`
--
ALTER TABLE `local_purchase_orders`
  ADD CONSTRAINT `local_purchase_orders_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `local_purchase_order_items`
--
ALTER TABLE `local_purchase_order_items`
  ADD CONSTRAINT `local_purchase_order_items_local_purchase_order_id_foreign` FOREIGN KEY (`local_purchase_order_id`) REFERENCES `local_purchase_orders` (`id`),
  ADD CONSTRAINT `local_purchase_order_items_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_rejected_by_id_foreign` FOREIGN KEY (`rejected_by_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `products_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `service_requests`
--
ALTER TABLE `service_requests`
  ADD CONSTRAINT `service_requests_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `service_requests_rejected_by_id_foreign` FOREIGN KEY (`rejected_by_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `service_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `service_request_items`
--
ALTER TABLE `service_request_items`
  ADD CONSTRAINT `service_request_items_service_request_quote_id_foreign` FOREIGN KEY (`service_request_quote_id`) REFERENCES `service_request_quotes` (`id`);

--
-- Constraints for table `service_request_quotes`
--
ALTER TABLE `service_request_quotes`
  ADD CONSTRAINT `service_request_quotes_service_request_id_foreign` FOREIGN KEY (`service_request_id`) REFERENCES `service_requests` (`id`);

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_rejected_by_id_foreign` FOREIGN KEY (`rejected_by_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `subscriptions_subscription_option_item_id_foreign` FOREIGN KEY (`subscription_option_item_id`) REFERENCES `subscription_option_items` (`id`),
  ADD CONSTRAINT `subscriptions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `subscription_deliveries`
--
ALTER TABLE `subscription_deliveries`
  ADD CONSTRAINT `subscription_deliveries_received_by_id_foreign` FOREIGN KEY (`received_by_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `subscription_deliveries_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`);

--
-- Constraints for table `subscription_option_items`
--
ALTER TABLE `subscription_option_items`
  ADD CONSTRAINT `subscription_option_items_subscription_option_id_foreign` FOREIGN KEY (`subscription_option_id`) REFERENCES `subscription_options` (`id`);

--
-- Constraints for table `top_ups`
--
ALTER TABLE `top_ups`
  ADD CONSTRAINT `top_ups_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
