$lines = get-content -Path 'input.txt'

$output = ""

foreach ($line in $lines) {
    $output = $output + $line
    write-host $line
}

write-host $output
