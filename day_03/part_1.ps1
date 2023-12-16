$lines = get-content -Path 'input.txt'


# Parse Numbers
$numbers = @()
$y = 0
foreach ($line in $lines) {
    $currentNum = ""
    $position = $Null

    $x = 0
    foreach ($char in $line.toCharArray()) {
        if ($char -match "\d") {
            if ($currentNum.Length -eq 0) {
                $position = @{ x=$x; y=$y }
            }
            $currentNum += $char
        } else {
            if ($currentNum.Length -gt 0) {
                $numbers += @{
                    number = [int] $currentNum
                    start = $position
                    length = $currentNum.Length
                }
                $currentNum = ""
                $position = $null
            }
        }
        $x += 1
    }

    if ($currentNum.Length -gt 0) {
        $numbers += @{
            number = [int] $currentNum
            start = $position
            length = $currentNum.Length
            valid = $False
        }
        $currentNum = ""
        $position = $null
    }

    $y += 1
}


function isAdjacent($number, $point) {
    $xMin = $number.start.x - 1
    $xMax = $number.start.x + $number.length
    $yMin = $number.start.y - 1
    $yMax = $number.start.y + 1
    $xInRange = ($xMin -le $point.x) -and ($xMax -ge $point.x)
    $yInRange = ($yMin -le $point.y) -and ($yMax -ge $point.y)
    return $xInRange -and $yInRange
}

            
# Find Valid Numbers
$y = 0
foreach ($line in $lines) {
    $x = 0
    foreach ($char in $line.ToCharArray()) {
        if ($char -match "[^0-9.]") {
            for ($i = 0; $i -lt $numbers.Length; $i +=1) {
                $charPos = @{ x = $x; y = $y }
                if (isAdjacent $numbers[$i] $charPos) { # Cursed function calling syntax
                    write-host "Adjacent! - $char ($($charPos.x), $($charPos.y)) $($numbers[$i].number)"
                    $numbers[$i].valid = $True
                }
            }
        }
        $x += 1
    }
    $y += 1
}


$valids = $numbers | Where-Object -Property valid

Write-Host "# of valid numbers:", $valids.length
$sum = 0
foreach ($v in $valids) {
    $sum += $v.number
}

write-host $sum
