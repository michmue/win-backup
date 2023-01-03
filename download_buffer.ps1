enum DistributionPlatforms {
    GITHUB
}

class DistributionPlatform {
    [DistributionPlatforms]$Name
    [string]$Url
    [string]$DownloadSelector 

    [PSCustomObject] GetDownloadSelector($gitOrganization, $gitRepo, $regex) {
        $parsing_url = $this.Url -f $args[-1]
        
        ,$gitOrganization, $gitRepo
        $api = Invoke-RestMethod -Uri $parsing_url
        $asset = Invoke-Expression $this.DownloadSelector -f $regex
        
        $file_name = $asset.name
        $download_url = $asset.browser_download_url

        return @{
            FileName = $file_name
            DownloadUrl = $download_url
        }
    }
}

$DISTRIBUTION_PLATFORM_GITHUB = [DistributionPlatform]@{
    Name="GitHub"
    Url="https://api.github.com/{0}/{1}/releases/latest"
    DownloadSelector="{1} | ? Name -Match '{2}'"
}

$DISTRIBUTION_PLATFORM_GITHUB.DownloadUri($orginazation, $repo, $regex)
$DISTRIBUTION_PLATFORM_MICROSOFT.DownloadUri($date, $regex)


$prog
if ($prog.DistributionPlatform) {
	$platform 	= $prog.DistributionPlatform
	$gitUser 	= $prog.GitUser
	$gitRepo 	= $prog.GitRepo
	$regex 		= $prog.Regex
	
	$url = $platform.DownloadUri($gitUser, $gitRepo, $regex)
	$platform.DownloadSelector($gitUser, $gitRepo, $regex)
	$wc.Download($url)
}


