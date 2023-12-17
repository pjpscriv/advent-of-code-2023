$lines = get-content -Path 'input.txt'

# Parse cards
$cards = @{}
foreach ($line in $lines) {
    $card = [int] $line.split(':')[0].split(' ')[-1]
    $line = $line.split(':')[1].trim()
    $parts = $line.split('|')

    $winners = [int[]] $parts[0].trim().split(' ') | where-object { $_ -gt 0 }
    $actual = [int[]] $parts[1].trim().split(' ') | where-object { $_ -gt 0 }

    $actualWinners = $actual | where-object { $winners -contains $_  }
    
    # write-host $card, ":", $winners, '-', $actual, ', Win count:', $actualWinners.length

    $cards[$card] = @{
        copies = 1
        matches = $actualWinners.length
        processed = $false
        upTo = $card
    }
}


# Generate copies
$old_sum
for ($i = 1; $i -le $cards.count; $i += 1) {
    # write-host $i
    $card = $cards[$i]
    for ($j = ($i + 1); ($j -le ($i + $card.matches)) -and ($j -le $cards.count); $j += 1) {
        $cards[$j].copies += $card.copies
    }
    $cards[$i].processed = $true
    $cards[$i].upTo = $j - 1

    # write-host "$i - $($card.matches) matches - $($card.copies) copies - Up to: $($card.upTo)"
}

write-host ($cards.Values | ForEach-Object { $_.copies } | Measure-Object -Sum).Sum
