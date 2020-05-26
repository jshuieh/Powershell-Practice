Function Get-Fib ($num) {
    $curr = 0
    $index = $next = 1

    while ($index -le $num) {
        $abbrev = switch ($index % 10)
        { 
            1 { "st"; Break }
            2 { "nd"; Break }
            3 { "rd"; Break }
            Default { "th"}
        }
        Write-Output "$index$abbrev value: $curr"
        $curr, $next, $index = $next, ($curr + $next), ($index + 1)
    }
}

$input = Read-Host "How many Fibonnaci values would you like to compute?"

if ($input -match "^\d+$") { 
    Get-Fib ($input -as [int])
} elseif ($input -match "-?^\d+$") {
    Write-Output "You did not input a positive integer."
} else {
    Write-Output "You did not input an integer."
}