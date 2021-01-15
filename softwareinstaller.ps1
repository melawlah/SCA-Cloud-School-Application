write-host "`n  ## NODEJS, cURL, WGET INSTALLER ## `n"

### CONFIGURATION

# nodejs
$version = "14.15.4"
$url = "https://nodejs.org/dist/v14.15.4/node-v14.15.4-x86.msi"
$macurl = "https://nodejs.org/dist/v14.15.4/node-v14.15.4.pkg"



### nodejs version check

if (Get-Command node -errorAction SilentlyContinue) {
    $current_version = (node -v)
}
 
if ($current_version) {
    write-host "[NODE] nodejs $current_version already installed"
  
        $install_node = $FALSE

}

write-host "`n"



if ($install_node) {
    
    ### download nodejs msi file
    # warning : if a node.msi file is already present in the current folder, this script will simply use it
        
    write-host "`n----------------------------"
    write-host "  nodejs msi file retrieving  "
    write-host "----------------------------`n"


    if ($IsWindows)
    {       
    $filename = "node.msi"
    $node_msi = "$PSScriptRoot\$filename"
    
    $download_node = $TRUE




    if (Test-Path $node_msi) {
       
            $download_node = $FALSE
        
    }

    if ($download_node) {
        write-host "[NODE] downloading nodejs install"
        write-host "url : $url"
        $start_time = Get-Date
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($url, $node_msi)
        write-Output "$filename downloaded"
        write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
    } else {
        write-host "using the existing node.msi file"
    }

    ### nodejs install

    write-host "`n----------------------------"
    write-host " nodejs installation  "
    write-host "----------------------------`n"

    write-host "[NODE] running $node_msi"
    Start-Process $node_msi -Wait
    
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    
    } 
   
    if ($IsMacOS)
    {

    $filename = "node.pkg"
    $node_pkg = "$PSScriptRoot\$filename"
    
    $download_node = $TRUE

    if (Test-Path $node_pkg) {
       
            $download_node = $FALSE
        
    }

    if ($download_node) {
        write-host "[NODE] downloading nodejs install"
        write-host "url : $url"
        $start_time = Get-Date
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($url, $node_pkg)
        write-Output "$filename downloaded"
        write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
    } 
    else {
        write-host "using the existing node.pkg file"
    }

    ### nodejs install

    write-host "`n----------------------------"
    write-host " nodejs installation  "
    write-host "----------------------------`n"

    write-host "[NODE] running $node_pkg"
    Start-Process $node_pkg -Wait
    
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    
    }  


   
}
 
 else {
        write-host "Proceeding with the previously installed nodejs version ..."
    }


write-host "`n----------------------------"
write-host " wget installation  "
write-host "----------------------------`n"

## wget installation

# wget
# $version = "14.15.4"
$urlwget = "https://downloads.sourceforge.net/gnuwin32/wget-1.11.4-1-setup.exe"



### wget version check

if (Get-Command wget -errorAction SilentlyContinue) {
    $current_version = (wget -v)
}
 
if ($current_version) {
    write-host "[WGET] wget $current_version already installed"
  
        $install_wget = $FALSE

}

write-host "`n"



if ($install_wget) {
    
    ### download wget exe file
    # warning : if a wget.exe file is already present in the current folder, this script will simply use it
        
    write-host "`n----------------------------"
    write-host "  wget exe file retrieving  "
    write-host "----------------------------`n"


    if ($IsWindows)
    {       
    $filename = "wget.exe"
    $wget_exe = "$PSScriptRoot\$filename"
    
    $download_wget = $TRUE

    if (Test-Path $wget_exe) {
       
            $download_wget = $FALSE
        
    }

    if ($download_wget) {
        write-host "[WGET] downloading wget install"
        write-host "url : $urlwget"
        $start_time = Get-Date
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($urlwget, $wget_exe)
        write-Output "$filename downloaded"
        write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
    } else {
        write-host "using the existing wget.exe file"
    }

    ### wget install

    write-host "`n----------------------------"
    write-host " wget installation  "
    write-host "----------------------------`n"

    write-host "[WGET] running $wget_exe"
    Start-Process $wget_exe -Wait
    
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    
    } 
   
    if ($IsMacOS)
    {

        if (Get-Command wget -errorAction SilentlyContinue) {
            $wget_prev_version = (wget --version)
        }

        if ($wget_prev_version) {
            write-host "[WGET] wget is already installed :"
            write-host $wget_prev_version 
            
                $install_wget = $FALSE

        }

        if ($install_wget) {
            write-host "Installing wget"
            brew install wget  
        }
    
    }  
   
}
 
 else {
        write-host "Proceeding with the previously installed wget version ..."
    }

## wget installation ends


### curl package install

write-host "`n----------------------------"
write-host " curl installation  "
write-host "----------------------------`n"

if (Get-Command curl -errorAction SilentlyContinue) {
    $curl_prev_version = (curl -V)
}

if ($curl_prev_version) {
    write-host "[CURL] Curl is already installed :"
    write-host $curl_prev_version 
    
        $install_curl = $FALSE

}

## installing curl with npm
if ($install_curl) {
    write-host "Installing cURL-cli"
    npm i curl
}

## ending of curl installation

### clean

write-host "`n----------------------------"
write-host " system cleaning "
write-host "----------------------------`n"


    if ($node_msi -and (Test-Path $node_msi)) {
        rm $node_msi
        rm $wget_exe
       
    }
  

write-host "Done !"