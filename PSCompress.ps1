function Get-CompressedData {
    <#
    .Synopsis
        Compresses data
    .Description
        Compresses data into a Format of your choice, outputting as either a Base64 String or a Byte Array
    .PARAMETER String
        The String which to compress. Mutually exclusive with Parameter Data
    .PARAMETER Data
        The Data which to compress. Mutually exclusive with Parameter String
    .PARAMETER As
        Determines the type which is used to return the compressed data. Valid types: String, Byte. Default: Byte
    .PARAMETER CompressionType
        The Compression Algorithm to use. Valid Algorithms: Brotli, GZip, Deflate. Default: Deflate
    .Parameter CompressionLevel
        How much to compress the Data: Valid Compression Levels: NoCompression, Fastest, Optimal, SmallestSize. Default: Optimal
    .Example
        $rawData = (Get-Command | Select-Object -ExpandProperty Name | Out-String)
        $originalSize = $rawData.Length
        $compressed = Get-CompressedData $rawData -As Byte
        "$($compressed.Length / $originalSize)% Smaller [ Compressed size $($compressed.Length / 1kb)kb : Original Size $($originalSize /1kb)kb] "
        Expand-Data -BinaryData $compressed
    .Usage 
        .\compress_gzip.ps1
        $content = [IO.File]::ReadAllText("path to file")
        Get-CompressedData $content -As String > gzip_compressed_payload
    #>
    [OutputType([String],[byte])]
    [CmdletBinding(DefaultParameterSetName='Data')]
    param(
        [Parameter(ParameterSetName='String',
            Position=0,
            Mandatory=$true,
            ValueFromPipelineByPropertyName=$true)]
        [string]$String,

        [Parameter(ParameterSetName='Data',
            Position=0,
            Mandatory=$true,
            ValueFromPipelineByPropertyName=$true)]
        [Byte[]]$Data,

        [ValidateSet('String','Byte')]
        [String]$As = 'byte', 

        [Parameter(Position=1, Mandatory=$false)]
        [ValidateSet('GZip', 'Brotli', 'Deflate')]
        [String]$CompressionType = 'Deflate',

        [Parameter(Position=2, Mandatory=$false)]
        [System.IO.Compression.CompressionLevel]$CompressionLevel = "Optimal"
    )
    if ($psCmdlet.ParameterSetName -eq 'String') {
        $Data = foreach ($c in $string.ToCharArray()) {
            $c -as [Byte]
        }            
    }
    $output_ms = New-Object IO.MemoryStream
    switch($CompressionType.ToLower()) {
        'gzip'    {$cs = New-Object System.IO.Compression.GZipStream($output_ms, $CompressionLevel, $false)}
        'brotli'  {$cs = New-Object System.IO.Compression.BrotliStream($output_ms, $CompressionLevel, $false)}
        'deflate' {$cs = New-Object System.IO.Compression.DeflateStream($output_ms, $CompressionLevel, $false)}
        default   {Write-Error 'Unreachable'; throw}
    }
    $cs.Write($Data, 0, $Data.Length)
    $cs.Close()
    if ($as -eq 'Byte') {
        $output_ms.ToArray() 
    } elseif ($as -eq 'string') {
        [Convert]::ToBase64String($output_ms.ToArray())
    }
    $output_ms.Close()
}

function Get-DecompressedData {
        <#
    .Synopsis
        Decompresses data
    .Description
        Decompresses data into a Format of your choice, outputting as either a Base64 String or a Byte Array
    .PARAMETER String
        The String which to decompress, which is data in a Base64 format. Mutually exclusive with Parameter Data
    .PARAMETER Data
        The Data which to decompress. Mutually exclusive with Parameter String
    .PARAMETER As
        Determines the type which is used to return the decompressed data. Valid types: String, Byte. Default: Byte
    .PARAMETER CompressionType
        The Compression Algorithm to use. Valid Algorithms: Brotli, GZip, Deflate. Default: Deflate
    #>
    [OutputType([String],[byte])]
    [CmdletBinding(DefaultParameterSetName='Data')]
    param(
        [Parameter(ParameterSetName='String',
            Position=0,
            Mandatory=$true,
            ValueFromPipelineByPropertyName=$true)]
        [string]$String,

        [Parameter(ParameterSetName='Data',
            Position=0,
            Mandatory=$true,
            ValueFromPipelineByPropertyName=$true)]
        [Byte[]]$Data,

        [ValidateSet('String','Byte')]
        [String]$As = 'byte', 

        [Parameter(Position=1, Mandatory=$false)]
        [ValidateSet('GZip', 'Brotli', 'Deflate')]
        [String]$CompressionType,

        [Parameter(Position=2, Mandatory=$false)]
        [System.IO.Compression.CompressionLevel]$CompressionLevel = "Optimal"
    )
    if ($psCmdlet.ParameterSetName -eq 'String') {
        $Data = [Convert]::FromBase64String($string)
    }
    $output_ms = New-Object IO.MemoryStream
    $input_ms = New-Object System.IO.MemoryStream(, $Data)
    switch($CompressionType.ToLower()) {
        'gzip'    {$cs = New-Object System.IO.Compression.GZipStream($input_ms, [System.IO.Compression.CompressionMode]::Decompress)}
        'brotli'  {$cs = New-Object System.IO.Compression.BrotliStream($input_ms, [System.IO.Compression.CompressionMode]::Decompress)}
        'deflate' {$cs = New-Object System.IO.Compression.DeflateStream($input_ms, [System.IO.Compression.CompressionMode]::Decompress)}
        default   {Write-Error 'Unreachable'; throw}
    }
    $cs.CopyTo($output_ms)
    $cs.Close()
    if ($as -eq 'Byte') {
        $output_ms.ToArray() 
    } elseif ($as -eq 'string') {
        [Convert]::ToBase64String($output_ms.ToArray())
    }
    $output_ms.Close()    
}

Export-ModuleMember -Function Get-CompressedData, Get-DecompressedData
