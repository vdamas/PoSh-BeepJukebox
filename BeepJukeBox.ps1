
# Tone,Duration,Pause,Tone,Duration,Pause,...
$tunes = @{
 "The Imperial March (Star Wars)" = @(440,500,0,440,500,0,440,500,0,349,350,0,523,150,0,440,500,0,349,350,0,523,150,0,440,1000,0,659,500,0,659,500,0,659,500,0,698,350,0,523,150,0,415,500,0,349,350,0,523,150,0,440,1000,0)
 "Mission Impossible" = @(784,150,300,784,150,300,932,150,150,1047,150,150,784,150,300,784,150,300,699,150,150,740,150,150,784,150,300,784,150,300,932,150,150,1047,150,150,784,150,300,784,150,300,699,150,150,740,150,150,932,150,0,784,150,0,587,1200,75,932,150,0,784,150,0,554,1200,75,932,150,0,784,150,0,523,1200,150,466,150,0,523,150,0)
 "Super Mario Intro" = @(659,250,0,659,250,0 ,659,300,0,523,250,0,659,250,0,784,300,0,392,300,0,523,275,0,392,275,0,330,275,0,440,250,0,494,250,0,466,275,0,440,275,0,392,275,0,659,250,0,784,250,0,880,275,0,698,275,0,784,225,0,659,250,0,523,250,0,587,225,0,494,225,0)
 "Tetris" = @(658,125,0,1320,500,0,990,250,0,1056,250,0,1188,250,0,1320,125,0,1188,125,0,1056,250,0,990,250,0,880,500,0,880,250,0,1056,250,0,1320,500,0,1188,250,0,1056,250,0,990,750,0,1056,250,0,1188,500,0,1320,500,0,1056,500,0,880,500,0,880,500,250,1188,500,0,1408,250,0,1760,500,0,1584,250,0,1408,250,0,1320,750,0,1056,250,0,1320,500,0,1188,250,0,1056,250,0,990,500,0,990,250,0,1056,250,0,1188,500,0,1320,500,0,1056,500,0,880,500,0,880,500,500,1320,500,0,990,250,0,1056,250,0,1188,250,0,1320,125,0,1188,125,0,1056,250,0,990,250,0,880,500,0,880,250,0,1056,250,0,1320,500,0,1188,250,0,1056,250,0,990,750,0,1056,250,0,1188,500,0,1320,500,0,1056,500,0,880,500,0,880,500,250,1188,500,0,1408,250,0,1760,500,0,1584,250,0,1408,250,0,1320,750,0,1056,250,0,1320,500,0,1188,250,0,1056,250,0,990,500,0,990,250,0,1056,250,0,1188,500,0,1320,500,0,1056,500,0,880,500,0,880,500,500,660,1000,0,528,1000,0,594,1000,0,495,1000,0,528,1000,0,440,1000,0,419,1000,0,495,1000,0,660,1000,0,528,1000,0,594,1000,0,495,1000,0,528,500,0,660,500,0,880,1000,0,838,2000,0,660,1000,0,528,1000,0,594,1000,0,495,1000,0,528,1000,0,440,1000,0,419,1000,0,495,1000,0,660,1000,0,528,1000,0,594,1000,0,495,1000,0,528,500,0,660,500,0,880,1000,0,838,2000)
}

function Play-Tune{
 [CmdletBinding()]
 Param(
  [Switch]$Loop
 )
 DynamicParam {
 
   # Set the dynamic parameters' name
   $ParameterName = 'TuneName'
 
   # Create the dictionary
   $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
 
   # Create the collection of attributes
   $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
 
   # Create and set the parameters' attributes
   $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
   $ParameterAttribute.Mandatory = $true
   #$ParameterAttribute.Position = 1
 
   # Add the attributes to the attributes collection
   $AttributeCollection.Add($ParameterAttribute)
 
   # Generate and set the ValidateSet
   $arrSet = $Global:tunes.Keys
   $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
 
   # Add the ValidateSet to the attributes collection
   $AttributeCollection.Add($ValidateSetAttribute)
 
   # Create and return the dynamic parameter
   $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName,[string],$AttributeCollection)
   $RuntimeParameterDictionary.Add($ParameterName,$RuntimeParameter)
   return $RuntimeParameterDictionary
 }
 
 begin {
   # Bind the parameter to a friendly variable
   $TuneName = $PsBoundParameters[$ParameterName]
   $tune = $Global:tunes[$TuneName]
 }

 process{
  do{
   for($i = 0; $i -lt $tune.Length; $i += 3){
    [console]::beep($tune[$i],$tune[$i+1])
    Start-Sleep -m $tune[$i+2] 
   }
  }while($Loop)
 }
}
