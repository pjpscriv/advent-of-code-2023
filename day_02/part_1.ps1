$lines = get-content -Path 'input.txt'

$redMax = 12
$greenMax = 13
$blueMax = 14

$sum = 0

foreach ($line in $lines) {
    $parts = $line.split(':')
    $gameNum = [int] $parts[0].split(' ')[1]

    $isValid = $True
    $rounds = $parts[1].split(';')
    foreach($round in $rounds) {

        $colorCounts = $round.split(',')
        foreach ($colorCount in $colorCounts) {
            $colorCount = $colorCount.trim().split(' ')
            $color = $colorCount[1]
            $count = [int] $colorCount[0]

            if (($color -eq 'red') -and ($count -gt $redMax)) {
                $isValid = $False
            } elseif (($color -eq 'green') -and ($count -gt $greenMax)) {
                $isValid = $False
            } elseif (($color -eq 'blue') -and ($count -gt $blueMax)) {
                $isValid = $False
            }
        }
    }

    if ($isValid) {
        $sum = $sum + $gameNum
    }
}

write-host $sum
