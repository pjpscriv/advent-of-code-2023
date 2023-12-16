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
    $dict = [Ordered]@{}
    foreach ($char in $uniques) {
        $count = ($string.ToCharArray() | Where-Object {$_ -eq $char}).count
        $dict[$char] = $count
    }
    return $dict
}

function getHandScore($hand) {
    $countDict = countChars($hand)

    # Add Joker count to most common card
    if ($countDict.Keys -Contains 'J') {
        $jChar = [char] 'J'
        $jokerCount = $countDict[$jChar]
        if ($jokerCount -lt 5) {
            $countDict.Remove($jChar)
            $commonCard = $($countDict.GetEnumerator() | Sort-Object -Property:Value | Select-object -Last 1)
            $countDict[$commonCard.Name] = $commonCard.Value + $jokerCount
        }
    }

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

function transformToSortable($cards) {
    $cards = $cards.Replace("J", "M")

    $cards = $cards.Replace("A", "A")
    $cards = $cards.Replace("K", "B")
    $cards = $cards.Replace("Q", "C")
    $cards = $cards.Replace("T", "D")
    $cards = $cards.Replace("9", "E")
    $cards = $cards.Replace("8", "F")
    $cards = $cards.Replace("7", "G")
    $cards = $cards.Replace("6", "H")
    $cards = $cards.Replace("5", "I")
    $cards = $cards.Replace("4", "J")
    $cards = $cards.Replace("3", "K")
    $cards = $cards.Replace("2", "L")
    return $cards
}


$lines = get-content -Path 'input.txt'

$hands = @()
foreach ($line in $lines) {
    $parts = $line.split(' ')
    $cards = $parts[0]
    $bid = [int] $parts[1]

    $score = getHandScore($cards)
    
    $hand = @{
        score = $score
        cards = $cards
        sortHand = transformToSortable($cards)
        bid = $bid
    }

    $hands += $hand
}
    

write-host
$hands = $hands | Sort-Object -Property { $_.score }, { $_.sortHand }

# Do Summing
$sum = 0
$multiplier = $lines.length
foreach ($hand in $hands) {
    Write-Host $hand.score, $hand.cards, $hand.bid, $multiplier, $hand.sortHand
    $sum += ($hand.bid * $multiplier)
    # write-host $sum
    $multiplier -= 1
}

Write-Host $sum
