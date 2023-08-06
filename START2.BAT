echo off
echo [2A
if not exist start.db  goto errmes
echo Macintosh Emulatorを起動します。 
db.x < start.db
:errmes
echo まず初めに、CST.batを起動してメモリ設定を行なって下さい。
:end
