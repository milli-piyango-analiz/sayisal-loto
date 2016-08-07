<?php

$includes = __DIR__ . "/../includes";
if (file_exists($includes . '/connect.local.php')) {
    include $includes . '/connect.local.php';
} else {
    include $includes . '/connect.php';
}

$url = 'http://www.millipiyango.gov.tr';

$dateListJson = request('/sonuclar/listCekilisleriTarihleri.php?tur=sayisal');
$dateList = json_decode($dateListJson);

foreach($dateList as $date) {
    $dateViewList = explode('-', $date->tarihView);
    $dateView = $dateViewList[2] . '-' . $dateViewList[1] . '-' . $dateViewList[0];

    print "Fetching: {$dateView}\n\r";
    $resultsJson = request('/sonuclar/cekilisler/sayisal/' . $date->tarih . '.json');
    $results = json_decode($resultsJson);

    if (!empty($results->success)) {
        $data = $results->data;

        try {
            $selectSql = "Select id from loto_history Where date = '{$dateView}'";
            $stmtSelect = $dbh->prepare($selectSql);
            $stmtSelect->execute();
            $lotoHistory = $stmtSelect->fetch();

            if (empty($lotoHistory)) {
                $success3Count = 0;
                $success3Amount = 0;
                $success4Count = 0;
                $success4Amount = 0;
                $success5Count = 0;
                $success5Amount = 0;
                $success6Count = 0;
                $success6Amount = 0;

                foreach($data->bilenKisiler as $success) {
                    if ($success->tur == '$3_BILEN') {
                        $success3Count = $success->kisiSayisi;
                        $success3Amount = $success->kisiBasinaDusenIkramiye;
                    } else if ($success->tur == '$4_BILEN') {
                        $success4Count = $success->kisiSayisi;
                        $success4Amount = $success->kisiBasinaDusenIkramiye;
                    } else if ($success->tur == '$5_BILEN') {
                        $success5Count = $success->kisiSayisi;
                        $success5Amount = $success->kisiBasinaDusenIkramiye;
                    } else if ($success->tur == '$6_BILEN') {
                        $success6Count = $success->kisiSayisi;
                        $success6Amount = $success->kisiBasinaDusenIkramiye;
                    }
                }

                $sql = "INSERT INTO loto_history (`json`, `date`, `week`, `oid`, `cycle_count`, 
`success_3_count`, `success_4_count`, `success_5_count`, `success_6_count`, `success_3_amount`, `success_4_amount`, `success_5_amount`, `success_6_amount`) 
VALUES ('{$resultsJson}', '{$dateView}', '{$data->hafta}', '{$data->oid}', '{$data->devirSayisi}',
'{$success3Count}',  '{$success4Count}',  '{$success5Count}',  '{$success6Count}',
'{$success3Amount}',  '{$success4Amount}',  '{$success5Amount}',  '{$success6Amount}')";
                $stmt = $dbh->prepare($sql);

                if ($stmt->execute()) {
                    $lotoHistoryId = $dbh->lastInsertId();

                    if (!empty($data->buyukIkrKazananIlIlceler)) {
                        foreach($data->buyukIkrKazananIlIlceler as $region) {
                            $sql = "INSERT INTO loto_jackpot (loto_history_id, city, district) VALUES('{$lotoHistoryId}', '{$region->ilView}', '{$region->ilceView}')";
                            $stmt = $dbh->prepare($sql);
                            $stmt->execute();
                        }
                    }

                    $numbers = explode('#', $data->rakamlar);

                    foreach($numbers as $index => $number) {
                        $sort = $index + 1;
                        $sql = "INSERT INTO loto_numbers (loto_history_id, `sort`, `number`) VALUES('{$lotoHistoryId}', '{$sort}', '{$number}')";
                        $stmt = $dbh->prepare($sql);
                        $stmt->execute();
                    }

                    print "Done\n\r";
                } else {
                    print "Insert Error : {$sql}";
                }
            } else {
                print "History already exists: {$dateView}\n\r";
            }
        } catch (Exception $e) {
            print "Insert Fatal Error: {$e->getMessage()}\n\r";
        }
    } else {
        print "Results not found\n\r";
    }
}

function request($path)
{
    global $url;

    $ch = curl_init($url . $path);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $output = curl_exec($ch);
    curl_close($ch);

    return $output;
}