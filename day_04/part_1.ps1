$lines = get-content -Path 'input.txt'

$scores = @()

foreach ($line in $lines) {
    # $card = $line.split(':')[0]
    $line = $line.split(':')[1].trim()
    $parts = $line.split('|')

    $winners = [int[]] $parts[0].trim().split(' ') | where-object { $_ -gt 0 }
    $actual = [int[]] $parts[1].trim().split(' ') | where-object { $_ -gt 0 }

    $actualWinners = $actual | where-object { $winners -contains $_  }
    
    # write-host $card, ":", $winners, '-', $actual, ', Win count:', $actualWinners.length

    if ($actualWinners.length -gt 0) {
        $scores += [Math]::Pow(2, ($actualWinners.length - 1))
    }
}


write-host ($scores | Measure-Object -sum).sum
