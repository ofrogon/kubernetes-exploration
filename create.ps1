Param(
        [Parameter(Mandatory=$True,Position=0)]
        [ValidateSet('full','node')]
        [string]$InstallationTarget,
        [Parameter(Mandatory=$True,Position=1)]
        [ValidateSet('complete','refresh')]
        [string]$InstallationType,
        [Parameter(Mandatory=$False,Position=2)]
        [switch]$SingleNode
)

## Remove U: and F: drive
Write-Host "Removing network drives..." -ForegroundColor Yellow
$_driveLetters = "U:", "F:"
foreach ($_driveLetter in $_driveLetters) {
    $Drive = Get-WmiObject -Class Win32_mappedLogicalDisk |  Where-Object { $_.Caption -eq $_driveLetter }

    if ($Drive) {
        & net use $Drive.Name /delete /y
    }
}
Write-Host "...Done" -ForegroundColor Green


if ($InstallationType -eq 'complete') {
    Write-Host "Install/Refresh Helm..." -ForegroundColor Yellow
    & cinst kubernetes-helm -y --acceptlicense
    Write-Host "...Done" -ForegroundColor Green
}

## Istio
$_istioVersion = '1.1.7'
$_istioHome = "${Env:Programfiles}\Istio"
$_istioDownloadUrl = "https://github.com/istio/istio/releases/download/$_istioVersion/istio-$_istioVersion-win.zip"
$_istioArchive = "$PSScriptRoot\Istio\istio-$_istioVersion-win.zip"
$_istioExtracted = "$PSScriptRoot\Istio\istio-$_istioVersion"

Write-Host "Installing Istio $_istioVersion..." -ForegroundColor Yellow

if (Test-Path $_istioHome) {
    Remove-Item $_istioHome -Recurse
}

if (Test-Path $_istioExtracted) {
    Remove-Item $_istioExtracted -Recurse
}

helm repo add istio.io https://storage.googleapis.com/istio-release/releases/$_istioVersion/charts/
if (!(Test-Path $_istioArchive)) {
    (New-Object System.Net.WebClient).DownloadFile($_istioDownloadUrl, $_istioArchive)
}
Expand-Archive $_istioArchive -DestinationPath "$PSScriptRoot\Istio"

New-Item -ItemType Directory -Path "$_istioHome" -Force | Out-Null
Copy-Item "$_istioExtracted\bin\istioctl.exe" -Destination "$_istioHome\istioctl.exe" -Force
New-EnvironmentVariable -Name PATH -Value $_istioHome -Scope User -Append

Set-Location "$PSScriptRoot\Istio\istio-$_istioVersion"
kubectl apply -f install/kubernetes/helm/helm-service-account.yaml
helm init --service-account tiller
Start-Sleep -s 10
helm install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system
Start-Sleep -s 60
helm install install/kubernetes/helm/istio --name istio --namespace istio-system
Set-Location $PSScriptRoot
Write-Host "...Done" -ForegroundColor Green

## Kubernetes Dasboard
Write-Host "Installing Kubernetes Dasboard..." -ForegroundColor Yellow
kubectl label namespace kube-system istio-injection=enabled
kubectl create -n kube-system -f $PSScriptRoot\KubernetesUI\kubernetes-dashboard.yml

istioctl kube-inject -f "$PSScriptRoot\KubernetesUI\kubernetes-dashboard.yml" > "$PSScriptRoot\KubernetesUI\kubernetes-dashboard-istiofied.yml"
kubectl apply -f "$PSScriptRoot\KubernetesUI\kubernetes-dashboard-istiofied.yml"
Write-Host "...Done" -ForegroundColor Green

## Elastic Search
if($SingleNode) {
    helm install --name elasticsearch elastic/elasticsearch --version 7.0.1-alpha1 --set replicas=2 --set minimumMasterNodes=1 --namespace elk --set antiAffinity=soft
} else {
    helm install --name elasticsearch elastic/elasticsearch --version 7.0.1-alpha1 --set replicas=2 --set minimumMasterNodes=1 --namespace elk
}

## Set ambassador to make it available externally

## Kibana

helm install --name kibana elastic/kibana --version 7.0.1-alpha1 --set elasticsearchHosts=???? --namespace elk