$lines = get-content -Path 'input.txt'

$sum = 0

foreach ($line in $lines) {
    $parts = $line.split(':')
    # $gameNum = [int] $parts[0].split(' ')[1]

    $redMax = 0
    $greenMax = 0
    $blueMax = 0

    $rounds = $parts[1].split(';')
    foreach($round in $rounds) {

        $colorCounts = $round.split(',')
        foreach ($colorCount in $colorCounts) {
            $colorCount = $colorCount.trim().split(' ')
            $color = $colorCount[1]
            $count = [int] $colorCount[0]

            if (($color -eq 'red') -and ($count -gt $redMax)) {
                $redMax = $count
            } elseif (($color -eq 'green') -and ($count -gt $greenMax)) {
                $greenMax = $count
            } elseif (($color -eq 'blue') -and ($count -gt $blueMax)) {
                $blueMax = $count
            }
        }
    }

    $power = $redMax * $greenMax * $blueMax

    $sum = $sum + $power
}

write-host $sum
