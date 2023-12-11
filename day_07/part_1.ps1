enum HandScores {
    FiveOfKind  = 1
    FourOfKind  = 2
    FullHouse   = 3
    ThreeOfKind = 4
    TwoPair     = 5
    OnePair     = 6
    HighCard    = 7
}

function countChars($string) {
    $uniques = $string.toCharArray() | select-object -unique
    $dict = @{}
    foreach ($char in $uniques) {
        $count = ($string.ToCharArray() | Where-Object {$_ -eq $char}).count
        $dict[$char] = $count
    }
    return $dict
}


function getHandScore($hand) {
    $countDict = countChars($hand)
    $counts = $countDict.Values
    $maxCount = $counts | Sort-Object | Select-Object -Last 1
    switch ($maxCount) {
        5 { return [HandScores]::FiveOfKind }
        4 { return [HandScores]::FourOfKind }
        3 {
            if ($counts -contains 2) {
                return [HandScores]::FullHouse
            }
            return [HandScores]::ThreeOfKind
        }
        2 {
            if (($counts | Where-Object {$_ -eq 2}).count -eq 2) {
                return [HandScores]::TwoPair
            }
            return [HandScores]::OnePair
        }
        default {
            return [HandScores]::HighCard
        }
    }    
}


$lines = get-content -Path 'test.txt'

$hands = @()
foreach ($line in $lines) {
    $parts = $line.split(' ')
    $cards = $parts[0]
    $bid = [int] $parts[1]

    $score = getHandScore($cards)
    Write-Host $score
    
    $hand = @{
        score = $score
        sortHand = $cards
        bid = $bid
    }

    $hands += $hand
}

write-host


foreach ($hand in $hands) { write-host $hand.score, $hand.sortHand }


write-host

write-host gettype $hands[0]

$hands = $hands | Sort-Object { $_.score }


# Do Summing
$sum = 0
$score = $lines.length
foreach ($hand in $hands) {
    Write-Host $hand.score, $hand.sortHand
    $sum += $hand.bid * $score
    $score -= 1
}

Write-Host $sum


