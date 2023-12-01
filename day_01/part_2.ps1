$lines = get-content -Path 'input.txt'
$sum = 0

# Copied from ChatGPT
function Get-LastNumeralIndex {
    param (
        [string]$inputString
    )
    $lastNumeralIndex = -1

    # Iterate through the string in reverse order
    for ($i = $inputString.Length - 1; $i -ge 0; $i--) {
        if ($inputString[$i] -match '\d') {
            $lastNumeralIndex = $i
            break
        }
    }

    return $lastNumeralIndex
}



foreach ($line in $lines) {
    # Hoo baby we're doing some hardcoding
    $firstNIndex = [regex]::Match($line, '\d').Index
    $firstN = [pscustomobject]@{ index = $firstNIndex; val = $line[$firstNIndex]; }
    $first1 = [pscustomobject]@{index = $line.IndexOf('one');   val = '1'; }
    $first2 = [pscustomobject]@{index = $line.IndexOf('two');   val = '2'; }
    $first3 = [pscustomobject]@{index = $line.IndexOf('three'); val = '3'; }
    $first4 = [pscustomobject]@{index = $line.IndexOf('four');  val = '4'; }
    $first5 = [pscustomobject]@{index = $line.IndexOf('five');  val = '5'; }
    $first6 = [pscustomobject]@{index = $line.IndexOf('six');   val = '6'; }
    $first7 = [pscustomobject]@{index = $line.IndexOf('seven'); val = '7'; }
    $first8 = [pscustomobject]@{index = $line.IndexOf('eight'); val = '8'; }
    $first9 = [pscustomobject]@{index = $line.IndexOf('nine');  val = '9'; }

    $lastNIndex = Get-LastNumeralIndex($line)
    $lastN = [pscustomobject] @{ index = $lastNIndex; val = $line[$lastNIndex]; }
    $last1 = [pscustomobject] @{ index = $line.lastIndexOf('one');   val = '1'; }
    $last2 = [pscustomobject] @{ index = $line.lastIndexOf('two');   val = '2'; }
    $last3 = [pscustomobject] @{ index = $line.lastIndexOf('three'); val = '3'; }
    $last4 = [pscustomobject] @{ index = $line.lastIndexOf('four');  val = '4'; }
    $last5 = [pscustomobject] @{ index = $line.lastIndexOf('five');  val = '5'; }
    $last6 = [pscustomobject] @{ index = $line.lastIndexOf('six');   val = '6'; }
    $last7 = [pscustomobject] @{ index = $line.lastIndexOf('seven'); val = '7'; }
    $last8 = [pscustomobject] @{ index = $line.lastIndexOf('eight'); val = '8'; }
    $last9 = [pscustomobject] @{ index = $line.lastIndexOf('nine');  val = '9'; }

    $firsts = @($firstN, $first1, $first2, $first3, $first4, $first5, $first6, $first7, $first8, $first9) | sort-object -property index
    $lasts = @($lastN, $last1, $last2, $last3, $last4, $last5, $last6, $last7, $last8, $last9) | sort-object -property index

    $first = $($firsts | where-object -property index -ge 0 | select-object -first 1).val
    $last = $($lasts | where-object -property index -ge 0 | select-object -last 1).val

    $num = [int] $($first + $last)

    $sum += $num
}

write-host $sum
