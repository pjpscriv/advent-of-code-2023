$lines = get-content -Path 'input.txt'

$sum = 0

foreach ($line in $lines) {
    $numbers = $($line -replace '\D','' ).TocharArray()
    $first = $numbers | select-object -first 1
    $last = $numbers | select-object -last 1
    $num = [int] $($first + $last)

    $sum += $num
}

write-host $sum
