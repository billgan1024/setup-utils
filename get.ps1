
function get {
    param (
        [string]$url,
        [string]$out
    )
    # if out is not specified, use the filename from the url
    if (!$out) {
        $out = $url.Split("/")[-1]
    }
    Invoke-WebRequest -Uri $url -OutFile $out
    if ($out.EndsWith(".exe") -or $out.EndsWith(".msi")) {
        Start-Process -FilePath $out -Wait
    }
}
