<?php
/** @var PDO $pdo */
$pdo = require_once $_SERVER['DOCUMENT_ROOT'] . '/db.php';

$brands = $pdo->prepare("INSERT INTO brands (name, url, bold, done) VALUES (?, ?, ?, ?)");
$models = $pdo->prepare("INSERT INTO models (brands_id, name, url, hasPanorama, done) VALUES (?, ?, ?, ?, ?)");
$generations = $pdo->prepare("INSERT INTO generations (model_id, src,	src2x, url, title, generationInfo, isNewAuto, isComingSoon, frameTypes, group_name, group_salug, group_short) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$complectations = $pdo->prepare("INSERT INTO complectations(generation_id, name, url, group_name) VALUES (?, ?, ?, ?)");

$content = file_get_contents('Bugatti.json');
$array = json_decode($content, true);

try {
    $pdo->beginTransaction();

    $bold = $array['bold'] ? 1 : 0;
    $brands->execute([$array['name'], $array['url'], $bold, $array['done']]);
    $brands_id = $pdo->lastInsertId();

    foreach ($array['models'] as $model) {
        $hasPanorama = $model['hasPanorama'] ? 1 : 0;
        $done = $model['done'] ? 1 : 0;

        $models->execute([$brands_id, $model['name'], $model['url'], $hasPanorama, $done]);
        $model_id = $pdo->lastInsertId();

        foreach ($model['generations'] as $generation) {
            $isNewAuto = $generation['isNewAuto'] ? 1 : 0;
            $isComingSoon = $generation['isComingSoon'] ? 1 : 0;
            $generations->execute([$model_id, $generation['src'], $generation['src2x'], $generation['url'], $generation['title'], $generation['generationInfo'], $isNewAuto, $isComingSoon, $generation['frameTypes'], $generation['group'], $generation['groupSalug'], $generation['groupShort']]);
            $generation_id = $pdo->lastInsertId();

            foreach ($generation['complectations'] as $complectation) {
                $complectations->execute([$generation_id, $complectation['name'], $complectation['url'], $complectation['group']]);
            }
        }
    }

    $pdo->commit();
    echo "Успешно!";
} catch (PDOException $e) {
    $pdo->rollBack();
    echo "Ошибка: " . $e->getMessage();
}
