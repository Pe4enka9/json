<?php
/** @var PDO $pdo */
// Устанавливаем соединение с базой данных через PDO, подключая файл `db.php` из корневой директории сайта.
$pdo = require_once $_SERVER['DOCUMENT_ROOT'] . '/db.php';

// Подготавливаем SQL-запросы для вставки данных в различные таблицы базы данных.
$brands = $pdo->prepare("INSERT INTO brands (name, url, bold, done) VALUES (?, ?, ?, ?)");
$models = $pdo->prepare("INSERT INTO models (brands_id, name, url, hasPanorama, done) VALUES (?, ?, ?, ?, ?)");
$generations = $pdo->prepare("INSERT INTO generations (model_id, src,	src2x, url, title, generationInfo, isNewAuto, isComingSoon, frameTypes, group_name, group_salug, group_short) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$complectations = $pdo->prepare("INSERT INTO complectations(generation_id, name, url, group_name) VALUES (?, ?, ?, ?)");

// Загружаем содержимое файла `Bugatti.json` и декодируем его в массив.
$content = file_get_contents('Bugatti.json');
$array = json_decode($content, true);

try {
    // Начинаем транзакцию для группировки всех операций вставки. Если что-то пойдет не так, изменения откатятся.
    $pdo->beginTransaction();

    // Конвертируем поле `bold` из JSON в 1 или 0 (для булевых значений).
    $bold = $array['bold'] ? 1 : 0;

    // Выполняем вставку данных о бренде в таблицу `brands`.
    $brands->execute([$array['name'], $array['url'], $bold, $array['done']]);
    // Получаем ID только что вставленной записи (бренда), чтобы использовать его при вставке связанных моделей.
    $brands_id = $pdo->lastInsertId();

    // Проходим по каждой модели, связанной с брендом.
    foreach ($array['models'] as $model) {
        // Конвертируем поля `hasPanorama` и `done` в 1 или 0.
        $hasPanorama = $model['hasPanorama'] ? 1 : 0;
        $done = $model['done'] ? 1 : 0;

        // Выполняем вставку данных о модели в таблицу `models`.
        $models->execute([$brands_id, $model['name'], $model['url'], $hasPanorama, $done]);
        // Получаем ID только что вставленной записи (модели), чтобы использовать его при вставке связанных поколений.
        $model_id = $pdo->lastInsertId();

        // Проходим по каждому поколению, связанному с моделью.
        foreach ($model['generations'] as $generation) {
            // Конвертируем поля `isNewAuto` и `isComingSoon` в 1 или 0.
            $isNewAuto = $generation['isNewAuto'] ? 1 : 0;
            $isComingSoon = $generation['isComingSoon'] ? 1 : 0;

            // Выполняем вставку данных о поколении в таблицу `generations`.
            $generations->execute([$model_id, $generation['src'], $generation['src2x'], $generation['url'], $generation['title'], $generation['generationInfo'], $isNewAuto, $isComingSoon, $generation['frameTypes'], $generation['group'], $generation['groupSalug'], $generation['groupShort']]);
            // Получаем ID только что вставленной записи (поколения), чтобы использовать его при вставке связанных комплектаций.
            $generation_id = $pdo->lastInsertId();

            // Проходим по каждой комплектации, связанной с поколением.
            foreach ($generation['complectations'] as $complectation) {
                // Выполняем вставку данных о комплектации в таблицу `complectations`.
                $complectations->execute([$generation_id, $complectation['name'], $complectation['url'], $complectation['group']]);
            }
        }
    }

    // Если все операции прошли успешно, фиксируем изменения в базе данных.
    $pdo->commit();
    echo "Успешно!";
} catch (PDOException $e) {
    // Если произошла ошибка, откатываем все изменения, выполненные в рамках транзакции.
    $pdo->rollBack();
    echo "Ошибка: " . $e->getMessage();
}
