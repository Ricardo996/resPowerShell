$resFile = Get-Content C:\Users\ricardo.lopes\Downloads\brisaTemp.txt

foreach ($line in $resFile){
    $array = $line.split(',')

    
    $reverseArray=''
    for (($i=$array.Length-1); $i -gt -1; $i--){
       
       if ($i -eq 0){
       Write-Host "1"
            $reverseArray = $reverseArray + $array[$i] 
       }elseif($i -eq $array.Length-1){
       Write-Host "2"
            $array[$i] = $array[$i].replace(' ','')
            $reverseArray = $reverseArray + $array[$i] + ',' 
       }else{ 
       Write-Host "3"
            $reverseArray = $reverseArray + $array[$i] + ',' 
       }
    }
    $reverseArray | Out-File -FilePath C:\Users\ricardo.lopes\Downloads\brisaDefFile.txt -Append
}