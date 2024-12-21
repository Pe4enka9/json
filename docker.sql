-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: database:3306
-- Время создания: Дек 20 2024 г., 07:43
-- Версия сервера: 5.7.44
-- Версия PHP: 8.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `docker`
--

-- --------------------------------------------------------

--
-- Структура таблицы `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bold` tinyint(1) NOT NULL,
  `done` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `brands`
--

INSERT INTO `brands` (`id`, `name`, `url`, `bold`, `done`) VALUES
(34, 'Bugatti', 'https://www.drom.ru/catalog/bugatti/', 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `complectations`
--

CREATE TABLE `complectations` (
  `id` int(11) NOT NULL,
  `generation_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `complectations`
--

INSERT INTO `complectations` (`id`, `generation_id`, `name`, `url`, `group_name`) VALUES
(55, 28, '8.0 DSG Pur Sport', '/catalog/bugatti/chiron/294859/', '8.0 Ð», 1500 Ð».Ñ., Ð±ÐµÐ½Ð·Ð¸Ð½, Ñ€Ð¾Ð±Ð¾Ñ‚, Ð¿Ð¾Ð»Ð½Ñ‹Ð¹ Ð¿Ñ€Ð¸Ð²Ð¾Ð´ (4WD)'),
(56, 28, '8.0 DSG', '/catalog/bugatti/chiron/187237/', '8.0 Ð», 1500 Ð».Ñ., Ð±ÐµÐ½Ð·Ð¸Ð½, Ñ€Ð¾Ð±Ð¾Ñ‚, Ð¿Ð¾Ð»Ð½Ñ‹Ð¹ Ð¿Ñ€Ð¸Ð²Ð¾Ð´ (4WD)');

-- --------------------------------------------------------

--
-- Структура таблицы `generations`
--

CREATE TABLE `generations` (
  `id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `src` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `src2x` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `generationInfo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isNewAuto` tinyint(1) NOT NULL,
  `isComingSoon` tinyint(1) NOT NULL,
  `frameTypes` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_salug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_short` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `generations`
--

INSERT INTO `generations` (`id`, `model_id`, `src`, `src2x`, `url`, `title`, `generationInfo`, `isNewAuto`, `isComingSoon`, `frameTypes`, `group_name`, `group_salug`, `group_short`) VALUES
(28, 31, 'https://s.auto.drom.ru/i24212/c/photos/fullsize/bugatti/chiron/gen473_bugatti_chiron_750283.jpg', 'https://s.auto.drom.ru/i24212/c/photos/fullsize/bugatti/chiron/gen473x2_bugatti_chiron_750283.jpg', 'g_2016_7807', 'Bugatti Chiron \r\n03.2016 -  Ð½.Ð².', '1 Ð¿Ð¾ÐºÐ¾Ð»ÐµÐ½Ð¸Ðµ', 0, 0, 'ÐšÑƒÐ¿Ðµ', 'ÐœÐ¾Ð´ÐµÐ»ÑŒÐ½Ñ‹Ð¹ Ñ€ÑÐ´ Bugatti Chiron Ð´Ð»Ñ Ð•Ð²Ñ€Ð¾Ð¿Ñ‹', 'europe', 'Ð”Ð»Ñ Ð•Ð²Ñ€Ð¾Ð¿Ñ‹');

-- --------------------------------------------------------

--
-- Структура таблицы `models`
--

CREATE TABLE `models` (
  `id` int(11) NOT NULL,
  `brands_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hasPanorama` tinyint(1) NOT NULL,
  `done` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `models`
--

INSERT INTO `models` (`id`, `brands_id`, `name`, `url`, `hasPanorama`, `done`) VALUES
(31, 34, 'Chiron', 'https://www.drom.ru/catalog/bugatti/chiron/', 0, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `complectations`
--
ALTER TABLE `complectations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complectations_ibfk_1` (`generation_id`);

--
-- Индексы таблицы `generations`
--
ALTER TABLE `generations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `generations_ibfk_1` (`model_id`);

--
-- Индексы таблицы `models`
--
ALTER TABLE `models`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brands_id` (`brands_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT для таблицы `complectations`
--
ALTER TABLE `complectations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT для таблицы `generations`
--
ALTER TABLE `generations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT для таблицы `models`
--
ALTER TABLE `models`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `complectations`
--
ALTER TABLE `complectations`
  ADD CONSTRAINT `complectations_ibfk_1` FOREIGN KEY (`generation_id`) REFERENCES `generations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `generations`
--
ALTER TABLE `generations`
  ADD CONSTRAINT `generations_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `models` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `models`
--
ALTER TABLE `models`
  ADD CONSTRAINT `models_ibfk_1` FOREIGN KEY (`brands_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
