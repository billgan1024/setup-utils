

function get {
    param (
        [string]$url,
        [string]$out
    )
    # if out is not specified, use the filename from the url
    if (!$out) {
        $out = $url.Split("/")[-1]
    }
    invoke-webrequest -uri $url -outfile $out
    if ($out.EndsWith(".exe") -or $out.EndsWith(".msi")) {
        start-process -filepath $out -wait
    }
}