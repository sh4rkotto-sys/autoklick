@echo off
title Auto Clicker Batch - Max Speed
color 0A
cls

:: ----------------------------------------------------------
:: CONFIGURAZIONE RAPIDA: Cambia qui sotto la velocita' (es. 40, 20, 10)
set CPS=40
:: ----------------------------------------------------------

echo =========================================
echo    AUTO CLICKER BATCH - %CPS% CPS
echo =========================================
echo.
echo - Premi [ M ] per ATTIVARE (ON) / DISATTIVARE (OFF)
echo - Premi [ Q ] per chiudere il programma
echo.
echo Pronto! In ascolto del tasto M...
echo.

powershell -Command "$cps = %CPS%; $ms = [math]::Round(1000 / $cps); $active = $false; $api = Add-Type -memberDefinition '[DllImport(\"user32.dll\")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int dwExtraInfo); [DllImport(\"user32.dll\")] public static extern short GetAsyncKeyState(int vKey);' -name 'Win32Api' -namespace 'Win32Functions' -passThru; while($true) { if(($api::GetAsyncKeyState(0x51) -band 0x8000) -ne 0) { break; } if(($api::GetAsyncKeyState(0x4D) -band 0x8000) -ne 0) { $active = -not $active; if($active) { Write-Host '[STATO] ATTIVATO (ON)' -ForegroundColor Green } else { Write-Host '[STATO] DISATTIVATO (OFF)' -ForegroundColor Red } Start-Sleep -Milliseconds 400; } if($active) { $api::mouse_event(2, 0, 0, 0, 0); $api::mouse_event(4, 0, 0, 0, 0); Start-Sleep -Milliseconds $ms; } else { Start-Sleep -Milliseconds 50; } }"

pause