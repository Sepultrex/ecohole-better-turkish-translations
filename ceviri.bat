@echo off

echo ================================================
echo ==    ECO HOLE Better Turkish Translations    ==
echo ================================================
echo.

echo turkce ceviriyi uygulamak icin 1'e basin.
echo islemi iptal etmek icin 2'ye basin.

choice /c 12 /n /m ""

:: 2'ye basildiysa islemi iptal et
if errorlevel 2 (
    echo Islem iptal ediliyor...
    exit /b
)

setlocal enabledelayedexpansion

:: çeviri dosyalarinin konumu
set "ceviri=.\Turkish"
:: oyunun steam versiyonunun konumu
set "oyun_konum=%ProgramFiles(x86)%\Steam\steamapps\common\ECO HOLE\Data\Languages\Turkish"

:: çeviri dosyalari bulunamadiysa uyarı ver ve işlemi iptal et
if not exist "%ceviri%" (
    cls
    color 4
    echo ceviri dosyalari bulunamadi
    echo lutfen dosyalari dogru bir sekilde indirdiginizden emin olun!
    echo.
    pause
    exit /b
)

:: oyun dosyalari bulunamadiysa hedef klasör seçimi için bir pencere aç
if not exist "%oyun_konum%" (
    cls
    color 6
    echo oyun dosyalari bulunamadi
    echo dosyalari secmek icin bir pencere aciliyor...
    echo.
    echo dosyalarin nerde oldugunu bilmiyorsaniz github sayfamizdan yardim alabilirsiniz.
    set "oyun_konum="
    
    for /f "delims=" %%i in ('powershell -Command "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; $fbd = New-Object System.Windows.Forms.FolderBrowserDialog; $fbd.Description = 'cevirinin calisabilmesi icin' + [System.Environment]::NewLine + 'Steam\steamapps\common\ECO HOLE\Data\Languages' + [System.Environment]::NewLine + 'klasorunun icindeki Turkish dosyasini secin'; $fbd.RootFolder = 'MyComputer'; $fbd.Title = 'dosya secimi'; if ($fbd.ShowDialog() -eq 'OK') { Write-Output $fbd.SelectedPath } else { Write-Output '' }"') do set "oyun_konum=%%i"
    if "%oyun_konum%"=="" (
        cls
    )
)

:: klasör secme islemi iptal edildiyse uyari goster
powershell -Command "Copy-Item -Path '%ceviri%\*' -Destination '%oyun_konum%' -Recurse -Force"
if errorlevel 1 (
    cls
    color 4
    echo islemi iptal ettiniz
    echo.
    pause
    exit /b
)

:: çeviri uygulandı mesajı göster
cls
color 2
echo ceviri uygulandi.
echo iyi oyunlar!
echo.
pause
exit /b
