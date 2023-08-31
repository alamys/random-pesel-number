function IsBirthDate($indexes) {
    $birthDateIndexes = @(0, 1, 2, 3, 4, 5)
    $sortedIndexes = $indexes | Sort-Object
    for ($i = 0; $i -lt ($sortedIndexes.Count - 1); $i++) {
        if ($sortedIndexes[$i + 1] - $sortedIndexes[$i] -eq 1) {
            return $false
        }
    }
    return ($sortedIndexes | ForEach-Object { $birthDateIndexes -contains $_ }) -eq $false
}

while ($true) {
    # Wprowadz numer PESEL
    $pesel = Read-Host "`nWprowadz numer PESEL"

    # Sprawdz, czy podano dokladnie 11 cyfr
    if ($pesel.Length -ne 11 -or $pesel -match '\D') {
        Write-Host "Numer PESEL powinien skladać sie z 11 cyfr."
    }
    else {
        do {
            # Losowo wybierz 4 pozycje z numeru PESEL
            $randomIndexes = 0..10 | Get-Random -Count 4

            # Sprawdz, czy wybrane pozycje spelniaja warunki (max 3 cyfry z daty urodzenia, pozycje nie moga następować jedna po drugiej)
            $isValid = IsBirthDate $randomIndexes
        } while (-not $isValid)

        # Sortuj wybrane pozycje
        $sortedRandomIndexes = $randomIndexes | Sort-Object

        # Wyswietlenie wybranych losowych pozycji i ich cyfr
        Write-Host "`nWybrane losowe pozycje z numeru PESEL:`n"
        foreach ($index in $sortedRandomIndexes) {
            $selectedDigit = $pesel[$index]
            Write-Host "Pozycja $($index + 1): $selectedDigit"
        }
    }
}
