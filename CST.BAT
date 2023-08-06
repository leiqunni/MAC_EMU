echo off
ECHO [2A
rem	MoJa作成

if "%1" == ""   goto errmes1
if "%1" == "-?" goto errmes1
if "%1" == "/?" goto errmes1

if not exist ROM goto errmes2
if not exist MAC.Z goto errmes3

if "%1" == "2M" goto RAM2MB
if "%1" == "2m" goto RAM2MB

if "%1" == "4M" goto RAM4MB
if "%1" == "4m" goto RAM4MB

if "%1" == "6M" goto RAM6MB
if "%1" == "6m" goto RAM6MB

if "%1" == "8M" goto RAM8MB
if "%1" == "8m" goto RAM8MB

goto errmes1

:RAM2MB
echo 2MBytes用に環境設定します。少々お持ち下さい。
echo r mac.z,.pc > MAC.PAT
echo mel .pc+1e 001D0000 >> MAC.PAT
echo mel .pc+22 001E0000 >> MAC.PAT
echo r ROM,1E0000 > start.db
goto pat_go

:RAM4MB
echo 4MBytes用に環境設定します。少々お持ち下さい。
echo r mac.z,.pc > MAC.PAT
echo mel .pc+1e 003D0000 >> MAC.PAT
echo mel .pc+22 003E0000 >> MAC.PAT
echo ROM,3E0000 > start.db
goto pat_go

:RAM6MB
echo 6MBytes用に環境設定します。少々お持ち下さい。
echo r mac.z,.pc > MAC.PAT
echo mel .pc+1e 005D0000 >> MAC.PAT
echo mel .pc+22 005E0000 >> MAC.PAT
echo ROM,5E0000 > start.db
goto pat_go

:RAM8MB
echo 8MBytes用に環境設定します。少々お持ち下さい。
echo r mac.z,.pc > MAC.PAT
echo mel .pc+1e 007D0000 >> MAC.PAT
echo mel .pc+22 007E0000 >> MAC.PAT
echo ROM,7E0000 > start.db
goto pat_go

:pat_go
echo w mac.z,.pc,.a1-1 >> MAC.PAT
echo q >> MAC.PAT
echo r rom,.pc > PATCH.SYS
echo Z1=E00000 >> PATCH.SYS
echo Z2=.Z1+FC80+80*7 >> PATCH.SYS
echo MEL .pc+07DE+2 .Z1+80*91+1E >> PATCH.SYS
echo MEL .pc+07F0+2 .Z1+80*A0+1F >> PATCH.SYS
echo MEW .pc+0EE0+2 3C+40 >> PATCH.SYS
echo MEW .pc+0EF0+2 40+40 >> PATCH.SYS
echo MEL .pc+0F0A+2 .Z1+80*91+1E >> PATCH.SYS
echo MEL .pc+0F16+2 .Z1+80*97+1F >> PATCH.SYS
echo MEW .pc+0F34+2 3E+40 >> PATCH.SYS
echo MEL .pc+0136+4 .Z2 >> PATCH.SYS
echo MEL .pc+1064+2 .Z2 >> PATCH.SYS
echo MEL .pc+1082+4 .Z2 >> PATCH.SYS
echo MEL .pc+109A+2 .Z2+4A >> PATCH.SYS
echo MEL .pc+10B0+4 .Z2 >> PATCH.SYS
echo MEL .pc+10BA+2 .Z2+4A >> PATCH.SYS
echo MEL .pc+10E6+4 .Z2 >> PATCH.SYS
echo MEL .pc+1104+2 .Z2+4C >> PATCH.SYS
echo MEL .pc+110A+2 .Z2+50 >> PATCH.SYS
echo MEL .pc+1116+2 .Z2+44 >> PATCH.SYS
echo MEL .pc+111C+2 .Z2+40 >> PATCH.SYS
echo MEL .pc+1142+4 .Z2 >> PATCH.SYS
echo MEL .pc+114A+2 .Z2+44 >> PATCH.SYS
echo MEL .pc+1150+2 .Z2+40 >> PATCH.SYS
echo MEL .pc+1164+2 .Z2+3C >> PATCH.SYS
echo MEL .pc+1196+4 .Z2 >> PATCH.SYS
echo MEL .pc+119E+2 .Z2+40 >> PATCH.SYS
echo MEL .pc+11A4+2 .Z2+44 >> PATCH.SYS
echo MEL .pc+146E+2 .Z2+78 >> PATCH.SYS
echo MEL .pc+1474+2 .Z2+7C >> PATCH.SYS
echo MEL .pc+1486+2 .Z2+76 >> PATCH.SYS
echo MEL .pc+15A6+2 .Z2+78 >> PATCH.SYS
echo MEL .pc+15DA+2 .Z2+7C >> PATCH.SYS
echo MEL .pc+1618+2 .Z2+78 >> PATCH.SYS
echo MEL .pc+163E+2 .Z2 >> PATCH.SYS
echo MEL .pc+163E+6 .Z2+7C >> PATCH.SYS
echo MEL .pc+164C+2 .Z2 >> PATCH.SYS
echo MEL .pc+1654+2 .Z2+20 >> PATCH.SYS
echo MEL .pc+165C+2 .Z2+40 >> PATCH.SYS
echo MEL .pc+1664+2 .Z2+44 >> PATCH.SYS
echo MEL .pc+16C0+2 .Z2+7C >> PATCH.SYS
echo MEL .pc+16CE+2 .Z2+76 >> PATCH.SYS
echo MEL .pc+16FE+2 .Z2+76 >> PATCH.SYS
echo MEL .pc+1738+2 .Z2+76 >> PATCH.SYS
echo MEL .pc+1774+2 .Z2+78 >> PATCH.SYS
echo MEL .pc+1792+2 .Z2+40 >> PATCH.SYS
echo MEL .pc+17AA+2 .Z2+20 >> PATCH.SYS
echo MEL .pc+17D8+2 .Z2 >> PATCH.SYS
echo MEL .pc+1810+2 .Z2+4A >> PATCH.SYS
echo MEL .pc+18A4+4 .Z2+5A >> PATCH.SYS
echo MEL .pc+18C8+2 .Z2+54 >> PATCH.SYS
echo MEL .pc+1952+4 .Z2+54 >> PATCH.SYS
echo MEL .pc+19A0+2 .Z2+5E >> PATCH.SYS
echo MEL .pc+19A8+2 .Z2+60 >> PATCH.SYS
echo MEL .pc+19C2+2 .Z2+5A >> PATCH.SYS
echo w ROM,.pc,.a1-1 >> PATCH.SYS
echo q >> PATCH.SYS
goto endmes

:endmes
echo r mac.z >> start.db
echo g >>  start.db

db < MAC.PAT > nul
del mac.pat > nul
db < PATCH.SYS > nul
del PATCH.SYS > nul
echo %1Bytes用にMAC.ZにPatchを当てました。ROMにもPatchを当てました。
echo Macintosh Emulatorの起動は、start.batを実行して下さい。
goto end

:errmes1
echo Macintosh Emulator用カスタマイズBatch
echo 書式 CST nM (nは2,4,6,8のみ指定できます。)
goto end
:errmes2
echo ROMファイルが見当たりません。Patchが当てられないよ。
goto end
:errmes3
echo MAC.Zファイルが見当たりません。Patchが当てられないよ。
goto end

:end
