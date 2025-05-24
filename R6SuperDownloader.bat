@shift /0
@shift /0
@echo off
setlocal enableextensions
Color 0F

set region=0
set maxspeed=25
set depotmain="359551"
set depotregion="377237"
set depotrus="377238"
set SeasonID="YXSXvX_X"
set SeasonName="SeasonName"
set crack="YXSX"

:onedrive
ECHO %cd% | FIND /C "OneDrive" >NUL
IF ERRORLEVEL 1 (
goto dotnetcheck
) ELSE (
start https://www.youtube.com/watch?v=FK2QLcCf9Uo
cls
echo You ran this downloader inside of a OneDrive folder, move the downloader to a different location. If you can't figure out how to move it follow the guide that'll open.(https://www.youtube.com/watch?v=FK2QLcCf9Uo)
echo Press any key to close the downloader. . .
pause >nul
exit
)

:dotnetcheck
Title Downloading .NET Core SDK...
MODE 100,50
if exist "C:\Program Files\dotnet\dotnet.exe" (
goto dotnet9check
) ELSE (
  start https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-9.0.300-windows-x64-installer
  cls
  echo Could not find .NET 9 SDK, please download it and restart the downloader.
  echo Press any key to close the downloader. . .
  pause >nul
  exit
)
goto dotnet9check

:dotnet9check
dotnet --list-sdks | findstr /C:"9.0"
if errorlevel 1 (
  start https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-9.0.300-windows-x64-installer
  cls
  echo Could not find .NET 9 SDK, please download it and restart the downloader. Help posts will be deleted about this issue.
  dotnet --version
  dotnet --list-sdks  
  dotnet --list-runtimes
  echo Press any key to close the downloader. . .
  pause >nul
  exit
) ELSE (
  goto 7zCheck
)

::requirements
  :7zCheck
    MODE 62,50
    if exist "Resources\7z.exe" (
      goto DepotCheck
    ) else (
      mkdir Resources
      goto no7zip
    )
    goto 7zCheck

  :no7zip
    cls
    MODE 79,20
    echo -------------------------------------------------------------------------------
    echo                       Downloading 7-Zip...
    echo -------------------------------------------------------------------------------
    curl.exe -L  "https://github.com/DataCluster0/R6TBBatchTool/raw/master/Requirements/7z.exe" --ssl-no-revoke --output 7z.exe
    move 7z.exe Resources
    goto 7zCheck

  :DepotCheck
    if exist "Resources\DepotDownloader.dll" (
      goto PlazaCheck
    ) else (
	goto DepotDownloader
    )
    goto DepotCheck

  :DepotDownloader
    cls
    MODE 79,20
    echo -------------------------------------------------------------------------------
    echo                        Downloading DepotDownloader...
    echo -------------------------------------------------------------------------------
    curl -L  "https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_3.1.0/DepotDownloader-framework.zip" --ssl-no-revoke --output depot.zip
    ::Extract
    for %%I in ("depot.zip") do (
      "Resources\7z.exe" x -y -o"Resources" "%%I" -aoa && del %%I
    )
    goto DepotCheck

:PlazaCheck
    if exist "Resources\Plazas" (
      goto cmdCheck 
    ) else (
      goto GetPlaza
    )
    goto PlazaCheck

  :GetPlaza
    cls
    MODE 79,20
    echo -------------------------------------------------------------------------------
    echo                          Downloading Plaza Bypass...
    echo -------------------------------------------------------------------------------
    curl -L  "https://github.com/SMGTD/R6SuperDownloader/raw/refs/heads/main/Plazas.zip" --ssl-no-revoke --output plazas.zip
    ::Extract
    for %%I in ("plazas.zip") do (
    "Resources\7z.exe" x -y -o"Resources\Plazas" "%%I" -aoa && del %%I
    )
    goto PlazaCheck

  :cmdCheck
    if exist "Resources\cmdmenusel.exe" (
      goto foridiots
    ) else (
      goto GetCmd
    )
    goto cmdCheck

  :GetCmd
    cls
    MODE 79,20
    echo -------------------------------------------------------------------------------
    echo                        Downloading cmdmenusel...
    echo -------------------------------------------------------------------------------
    curl -L  "https://github.com/SlejmUr/R6-AIOTool-Batch/raw/master/Requirements/cmdmenusel.exe" --ssl-no-revoke --output cmdmenusel.exe
    move cmdmenusel.exe Resources
    goto cmdCheck
::End requirements

:foridiots
Title Main Menu
cls
MODE 87,11
echo ---------------------------------------------------------------------------------------
echo ^| PLEASE read the FAQ and Guide section before asking for help in our Discord server. ^|
echo ^| Your problem can most likely be resolved by reading the FAQ and Guide.              ^|
echo ^| If you come across a problem/issue, or have a question, please look on YouTube for  ^|
echo ^| tutorials on how to use these tools, or ask for help in Throwback or Renegades!     ^|
echo ---------------------------------------------------------------------------------------
echo.
timeout /T 5 >nul | echo 			Please wait 5 sec to continue^!
Resources\cmdMenuSel f870 "                                 -> Continue" ""
if %ERRORLEVEL% == 1 goto guidefaq



:mainmenu
Title Rainbow Six Siege Super Downloader
cls
MODE 64,14
echo ----------------------------------------------------------------
echo ^|         Soviet Option is for Soviet Accounts, if you         ^|
echo ^|         are missing RainbowSix.exe, try using it.            ^|
echo ^| You MUST own Rainbow Six Siege on Steam to install the game. ^|
echo ^|        Click on the option you would like to select.         ^|
echo ----------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  Game Downloader" "  Tool Downloader" "  More Settings" "  Installation Guide and FAQ" "  Credits"
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto tools
if %ERRORLEVEL% == 3 goto moresettings
if %ERRORLEVEL% == 4 goto guidefaq
if %ERRORLEVEL% == 5 goto credits

:moresettings
Title Settings...
cls
MODE 44,9
echo --------------------------------------------
if %region% == 0 (
echo ^|              Region: GLOBAL              ^|
)
if %region% == 1 (
echo ^|              Region: SOVIET              ^|
)
echo ^| Max servers: %maxspeed% (25 Default, 40 Boosted) ^|
echo --------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Main Menu" "  Toggle Region" "  Toggle Server Speed"
if %ERRORLEVEL% == 1 goto mainmenu
if %ERRORLEVEL% == 2 (
  if %region% == 1 (
    set region=0
  ) else (
    set region=1
  )
  goto moresettings
)
if %ERRORLEVEL% == 3 (
  if %maxspeed% == 25 (
    set maxspeed=40
  ) else (
    set maxspeed=25
  )
  goto moresettings
)

:credits
Title R6SuperDownloader Credits...
cls
mode 50,9
echo --------------------------------------------------
echo ^| R6Downloader made by Sheyyy                    ^|
echo ^| R6Downloader maintained by SlejmUr             ^|
echo ^| R6Downloader maintained by VergePoland         ^|
echo ^| R6SuperDownloader made by SMGTD and Lostinwave ^|
echo --------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Main Menu"
if %ERRORLEVEL% == 1 goto mainmenu

:tools
Title Downloading Tools...
cls
MODE 79,14
echo -------------------------------------------------------------------------------
echo ^|                  Click on the Tool you want to download.                    ^|
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  <- Back to Main Menu" "" "  Moss Anti-Cheat | Nohope92 | REQUIRED for Competitive Play" "  Radmin VPN | Famatech | REQUIRED for all Online Play" "  Liberator (Classic) | Cheato | Unlock All and Playlist Manager for Y1S0-Y4S4" "  Liberator 2 | dla19 | Unlock All and Warmup enabler for Y5S3"
if %ERRORLEVEL% == 1 goto mainmenu
if %ERRORLEVEL% == 2 goto tools
if %ERRORLEVEL% == 3 goto getmoss
if %ERRORLEVEL% == 4 goto getradmin
if %ERRORLEVEL% == 5 goto getliberator
if %ERRORLEVEL% == 6 goto getlibtwo

:getmoss
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                         Downloading Moss Anti-Cheat...
echo -------------------------------------------------------------------------------
curl -L  "https://nohope.eu/down/MossX645.zip" --ssl-no-revoke --output MossX645.zip
::Extract
for %%I in ("MossX645.zip") do (
  "Resources\7z.exe" x -pMoss -y "%%I" -aoa && del %%I
)
goto tools

:getradmin
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                         Downloading Radmin VPN Installer...
echo -------------------------------------------------------------------------------
curl -L "https://download.radmin-vpn.com/download/files/Radmin_VPN_1.4.4642.1.exe" --ssl-no-revoke --output Radmin_VPN.exe
start Radmin_VPN.exe
goto tools

:getliberator
cls
MODE 79,10
echo -------------------------------------------------------------------------------
echo                         Downloading Liberator Classic...
echo -------------------------------------------------------------------------------
curl -L "https://github.com/SlejmUr/Manifest_Tool_TB/raw/refs/heads/main/R6_Liberator_0.0.0.22.exe" --ssl-no-revoke --output R6Liberator.exe
goto tools

:getlibtwo
cls
MODE 79,10
echo -------------------------------------------------------------------------------
echo                         Downloading Liberator 2...
echo -------------------------------------------------------------------------------
curl -L "https://github.com/SMGTD/R6SuperDownloader/raw/refs/heads/main/R6Liberator2.exe" --ssl-no-revoke --output R6Liberator2.exe
goto tools

:seasonmenu
Title Choosing Season...
cls
MODE 78,45
echo ------------------------------------------------------------------------------
echo ^| Click on the Season of the Rainbow Six Siege Version you want to download. ^|
echo ------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  <- Back to Main Menu" "" "  Vanilla          | Y1S0" "  Black Ice        | Y1S1" "  Dust Line        | Y1S2" "  Skull Rain       | Y1S3" "  Red Crow         | Y1S4" "  Velvet Shell     | Y2S1" "  Health           | Y2S2" "  Blood Orchid     | Y2S3" "  White Noise      | Y2S4" "  Chimera          | Y3S1 (Outbreak)" "  Para Bellum      | Y3S2" "  Grim Sky         | Y3S3 (Mad House)" "  Wind Bastion     | Y3S4" "  Burnt Horizon    | Y4S1 (Rainbow Is Magic)" "  Phantom Sight    | Y4S2 (Showdown)" "  Ember Rise       | Y4S3 (Doktor's Curse, Money Heist)" "  Shifting Tides   | Y4S4 (S.I. Stadium)" "  Void Edge        | Y5S1 (The Grand Larceny, Golden Gun)" "  Steel Wave       | Y5S2 (M.U.T.E. Protocol)" "  Shadow Legacy    | Y5S3 (Sugar Fright)" "  Neon Dawn        | Y5S4 (Road To S.I. 2021, Legacy)" "  Crimson Heist    | Y6S1 (Rainbow Is Magic 2, Apocalypse)" "  North Star       | Y6S2 (Nest Destruction)" "  Crystal Guard    | Y6S3 (Showdown 2)" "  High Calibre     | Y6S4 (Stadium, Snowbrawl)" "  Demon Veil       | Y7S1 (TOKY)" "  Vector Glare     | Y7S2 (Mute Protocol Reboot)" "  Brutal Swarm     | Y7S3 (Doktor's Curse 2, Snipers Only)" "  Solar Raid       | Y7S4 (Snow Brawl)" "  Commanding Force | Y8S1 (RIM, TOKY)" "  Dread Factor     | Y8S2 (Rengoku V2)" "  Heavy Mettle     | Y8S3 (Doktor's Curse 3)" "  Deep Freeze      | Y8S4" "  Deadly Omen      | Y9S1 (Containment 2)" "  New Blood        | Y9S2 (MUTE Protocol 3)" "  Twin Shells      | Y9S3 (Doktor's Curse 5)" "  Collision Point  | Y9S4 (Assault on Hereford)" "  Prep Phase       | Y10S1"
if %ERRORLEVEL% == 1 goto mainmenu
if %ERRORLEVEL% == 2 goto seasonmenu
if %ERRORLEVEL% == 3 goto vanilla
if %ERRORLEVEL% == 4 goto blackice
if %ERRORLEVEL% == 5 goto dustline
if %ERRORLEVEL% == 6 goto skullrain
if %ERRORLEVEL% == 7 goto redcrow
if %ERRORLEVEL% == 8 goto velvetshell
if %ERRORLEVEL% == 9 goto health
if %ERRORLEVEL% == 10 goto bloodorchid
if %ERRORLEVEL% == 11 goto whitenoise
if %ERRORLEVEL% == 12 goto chimera
if %ERRORLEVEL% == 13 goto parabellum
if %ERRORLEVEL% == 14 goto grimsky
if %ERRORLEVEL% == 15 goto windbastion
if %ERRORLEVEL% == 16 goto burnthorizon
if %ERRORLEVEL% == 17 goto phantomsight
if %ERRORLEVEL% == 18 goto emberrise
if %ERRORLEVEL% == 19 goto shiftingtides
if %ERRORLEVEL% == 20 goto voidedge
if %ERRORLEVEL% == 21 goto steelwave
if %ERRORLEVEL% == 22 goto shadowlegacy
if %ERRORLEVEL% == 23 goto neondawn
if %ERRORLEVEL% == 24 goto crimsonheist
if %ERRORLEVEL% == 25 goto northstar
if %ERRORLEVEL% == 26 goto crystalguard
if %ERRORLEVEL% == 27 goto highcalibre
if %ERRORLEVEL% == 28 goto demonveil
if %ERRORLEVEL% == 29 goto vectorglare
if %ERRORLEVEL% == 30 goto brutalswarm
if %ERRORLEVEL% == 31 goto solarraid
if %ERRORLEVEL% == 32 goto commandingforce
if %ERRORLEVEL% == 33 goto dreadfactor
if %ERRORLEVEL% == 34 goto heavymettle
if %ERRORLEVEL% == 35 goto deepfreeze
if %ERRORLEVEL% == 36 goto deadlyomen
if %ERRORLEVEL% == 37 goto newblood
if %ERRORLEVEL% == 38 goto twinshells
if %ERRORLEVEL% == 39 goto collisionpoint
if %ERRORLEVEL% == 40 goto prepphase

:vanilla
MODE 64,17
Title Selecting Vanilla Version...
echo ----------------------------------------------------------------
echo ^| Click on the Version of Vanilla (Y1S0) you want to download. ^|
echo ----------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y1S0   | 2015/12/05 | Liberator Supported" "   Y1S0.1  | 2015/12/16" "  Y1S0.1.1 | 2015/12/18" "  Y1S0.1.2 | 2015/12/23" "   Y1S0.2  | 2016/01/07" "   Y1S0.3  | 2016/01/13" "  Y1S0.3.1 | 2016/01/15" "  Y1S0.3.2 | 2016/01/26"
set SeasonName="Vanilla"
set crack="Y1S0-Y1S4"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto vanilla
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto vanilla0
if %ERRORLEVEL% == 4 goto vanilla1
if %ERRORLEVEL% == 5 goto vanilla2
if %ERRORLEVEL% == 6 goto vanilla3
if %ERRORLEVEL% == 7 goto vanilla4
if %ERRORLEVEL% == 8 goto vanilla5
if %ERRORLEVEL% == 9 goto vanilla6
if %ERRORLEVEL% == 10 goto vanila7

:vanilla0
set SeasonID="Y1S0"
set depotregion="8358812283631269928"
set depotrus="6835384933146381100"
set depotmain="3893422760579204530"
goto download

:vanilla1
set SeasonID="Y1S0v1"
set depotregion="3743055105300313317"
set depotrus="1844364798002952887"
set depotmain="8448565135935143640"
goto download

:vanilla2
set SeasonID="Y1S0v1_1"
set depotregion="32013936088805901"
set depotrus="2756679630378217563"
set depotmain="8448565135935143640"
goto download

:vanilla3
set SeasonID="Y1S0v1_2"
set depotregion="1621018853317322701"
set depotrus="2252698315680156686"
set depotmain="8448565135935143640"
goto download

:vanilla4
set SeasonID="Y1S0v2"
set depotregion="4202925682014566403"
set depotrus="5561172616734770733"
set depotmain="5198033313120870543"
goto download

:vanilla5
set SeasonID="Y1S0v3"
set depotregion="342789376182018798"
set depotrus="2057957336520818670"
set depotmain="8484530985139103446"
goto download

:vanilla6
set SeasonID="Y1S0v3_1"
set depotregion="4504696248935187117"
set depotrus="3547146964527804727"
set depotmain="8484530985139103446"
goto download

:vanilla7
set SeasonID="Y1S0v3_2"
set depotregion="4482491938515656079"
set depotrus="2809547126796582712"
set depotmain="8484530985139103446"
goto download

:blackice
MODE 66,16
Title Selecting Black Ice Version...
echo ------------------------------------------------------------------
echo ^| Click on the Version of Black Ice (Y1S1) you want to download. ^|
echo ------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y1S1   | 2016/02/02 | Liberator Supported" "   Y1S1.1  | 2016/02/11" "   Y1S1.2  | 2016/03/01" "  Y1S1.2.1 | 2016/03/16" "   Y1S1.3  | 2016/03/30" "   Y1S1.4  | 2016/04/11" "   Y1S1.5  | 2016/04/14"
set SeasonName="BlackIce"
set crack="Y1S0-Y1S4"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto blackice
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto blackice0
if %ERRORLEVEL% == 4 goto blackice1
if %ERRORLEVEL% == 5 goto blackice2
if %ERRORLEVEL% == 6 goto blackice3
if %ERRORLEVEL% == 7 goto blackice4
if %ERRORLEVEL% == 8 goto blackice5
if %ERRORLEVEL% == 9 goto blackice6

:blackice0
set SeasonID="Y1S1"
set depotregion="5188997148801516344"
set depotrus="5362991837480196824"
set depotmain="7932785808040895147"
goto download

:blackice1
set SeasonID="Y1S1v1"
set depotregion="3614622975614716469"
set depotrus="8937559145294178457"
set depotmain="6465708515497307590"
goto download

:blackice2
set SeasonID="Y1S1v2"
set depotregion="7711720801595135532"
set depotrus="6721319605412870852"
set depotmain="2524431103528773481"
goto download

:blackice3
set SeasonID="Y1S1v2_1"
set depotregion="261126452890862552"
set depotrus="6185232766669245902"
set depotmain="2524431103528773481"
goto download

:blackice4
set SeasonID="Y1S1v3"
set depotregion="368945703399504083"
set depotrus="7235255154111440496"
set depotmain="584269430056918938"
goto download

:blackice5
set SeasonID="Y1S1v4"
set depotregion="8734645814465151674"
set depotrus="4665055293816211286"
set depotmain="6241860061250357494"
goto download

:blackice6
set SeasonID="Y1S1v5"
set depotregion="1974012529226262250"
set depotrus="493792591149888945"
set depotmain="1014705032639418053"
goto download

:dustline
MODE 66,15
Title Selecting Dust Line Version...
echo ------------------------------------------------------------------
echo ^| Click on the Version of Dust Line (Y1S2) you want to download. ^|
echo ------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y1S2   | 2016/05/11 | Liberator Supported" "   Y1S2.1  | 2016/05/31" "  Y1S2.1.1 | 2016/06/09" "   Y1S2.2  | 2016/06/21" "   Y1S2.3  | 2016/07/13" "   Y1S2.4  | 2016/07/27"
set SeasonName="DustLine"
set crack="Y1S0-Y1S4"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto dustline
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto dustline0
if %ERRORLEVEL% == 4 goto dustline1
if %ERRORLEVEL% == 5 goto dustline2
if %ERRORLEVEL% == 6 goto dustline3
if %ERRORLEVEL% == 7 goto dustline4
if %ERRORLEVEL% == 8 goto dustline5

:dustline0
set SeasonID="Y1S2"
set depotregion="2303064029242396590"
set depotrus="3040224537841664111"
set depotmain="2206497318678061176"
goto download

:dustline1
set SeasonID="Y1S2v1"
set depotregion="5444052019647296295"
set depotrus="2098996701789899280"
set depotmain="7981531019080197347"
goto download

:dustline2
set SeasonID="Y1S2v1_1"
set depotregion="8204078813908269108"
set depotrus="4561679417405056911"
set depotmain="7981531019080197347"
goto download

:dustline3
set SeasonID="Y1S2v2"
set depotregion="38954874887789989"
set depotrus="2217747372781104155"
set depotmain="2148935588340429809"
goto download

:dustline4
set SeasonID="Y1S2v3"
set depotregion="5964959312615478607"
set depotrus="1478750972833588542"
set depotmain="858265076760852545"
goto download

:dustline5
set SeasonID="Y1S2v4"
set depotregion="934562366846671272"
set depotrus="6259966046089368070"
set depotmain="1161523382541911933"
goto download

:skullrain
MODE 67,22
Title Selecting Skull Rain Version...
echo -------------------------------------------------------------------
echo ^| Click on the Version of Skull Rain (Y1S3) you want to download. ^|
echo -------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y1S3   | 2016/08/02 | Liberator Supported" "   Y1S3.1  | 2016/08/04" "   Y1S3.2  | 2016/08/09" "   Y1S3.3  | 2016/08/25" "   Y1S3.4  | 2016/08/31" "   Y1S3.5  | 2016/09/13 | Liberator Supported" "   Y1S3.6  | 2016/09/27" "   Y1S3.7  | 2016/10/06" "   Y1S3.8  | 2016/10/12" "  Y1S3.8.1 | 2016/10/13" "   Y1S3.9  | 2016/10/17" "  Y1S3.9.1 | 2016/10/20" "  Y1S3.9.2 | 2016/10/24" 
set SeasonName="SkullRain"
set crack="Y1S0-Y1S4"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto skullrain
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto skullrain0
if %ERRORLEVEL% == 4 goto skullrain1
if %ERRORLEVEL% == 5 goto skullrain2
if %ERRORLEVEL% == 6 goto skullrain3
if %ERRORLEVEL% == 7 goto skullrain4
if %ERRORLEVEL% == 8 goto skullrain5
if %ERRORLEVEL% == 9 goto skullrain6
if %ERRORLEVEL% == 10 goto skullrain7
if %ERRORLEVEL% == 11 goto skullrain8
if %ERRORLEVEL% == 12 goto skullrain9
if %ERRORLEVEL% == 13 goto skullrain10
if %ERRORLEVEL% == 14 goto skullrain11
if %ERRORLEVEL% == 15 goto skullrain12
if %ERRORLEVEL% == 16 goto skullrain13

:skullrain0
set SeasonID="Y1S3"
set depotregion="3552784069501585540"
set depotrus="2956768406107766016"
set depotmain="6528040263176897081"
goto download

:skullrain1
set SeasonID="Y1S3v1"
set depotregion="108974318854764405"
set depotrus="6921284394153406844"
set depotmain="3819830470755700957"
goto download

:skullrain2
set SeasonID="Y1S3v2"
set depotregion="1819797176947817907"
set depotrus="5675110311121280912"
set depotmain="8833587871984796227"
goto download

:skullrain3
set SeasonID="Y1S3v3"
set depotregion="2978247056480781896"
set depotrus="15433649744453620"
set depotmain="6969794674410105876"
goto download

:skullrain4
set SeasonID="Y1S3v4"
set depotregion="4412055913875466379"
set depotrus="4602326659902744964"
set depotmain="4881642088507148952"
goto download

:skullrain5
set SeasonID="Y1S3v5"
set depotregion="5819137024728546741"
set depotrus="7597187834633512926"
set depotmain="5851804596427790505"
goto download

:skullrain6
set SeasonID="Y1S3v6"
set depotregion="6726754894792889715"
set depotrus="3242637972983694236"
set depotmain="3103938330992097713"
goto download

:skullrain7
set SeasonID="Y1S3v7"
set depotregion="8724972822612769160"
set depotrus="2125032293861562324"
set depotmain="9020896956815803664"
goto download

:skullrain8
set SeasonID="Y1S3v8"
set depotregion="9202119119811655737"
set depotrus="5336179551805445683"
set depotmain="2820140842513732881"
goto download

:skullrain9
set SeasonID="Y1S3v8_1"
set depotregion="1080679534951626344"
set depotrus="257091128581804500"
set depotmain="2820140842513732881"
goto download

:skullrain10
set SeasonID="Y1S3v9"
set depotregion="6875721849698410550"
set depotrus="5888814717312674889"
set depotmain="3601410060583959541"
goto download

:skullrain11
set SeasonID="Y1S3v9_1"
set depotregion="3474306112942978465"
set depotrus="4527683120880581149"
set depotmain="3601410060583959541"
goto download

:skullrain12
set SeasonID="Y1S3v9_2"
set depotregion="464238060451207169"
set depotrus="1784336138459523166"
set depotmain="3601410060583959541"
goto download

:redcrow
MODE 65,15
Title Selecting Red Crow Version...
echo -----------------------------------------------------------------
echo ^| Click on the Version of Red Crow (Y1S4) you want to download. ^|
echo -----------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y1S4   | 2016/11/17 | Liberator Supported" "   Y1S4.1  | 2016/11/22" "   Y1S4.2  | 2016/12/15" "   Y1S4.3  | 2017/01/11" "  Y1S4.3.1 | 2017/01/18" "   Y1S4.4  | 2017/01/25"
set SeasonName="RedCrow"
set crack="Y1S0-Y1S4"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto redcrow
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto redcrow0
if %ERRORLEVEL% == 4 goto redcrow1
if %ERRORLEVEL% == 5 goto redcrow2
if %ERRORLEVEL% == 6 goto redcrow3
if %ERRORLEVEL% == 7 goto redcrow4
if %ERRORLEVEL% == 8 goto redcrow5

:redcrow0
set SeasonID="Y1S4"
set depotregion="3576607363557872807"
set depotrus="912564683190696342"
set depotmain="8569920171217002292"
goto download

:redcrow1
set SeasonID="Y1S4v1"
set depotregion="46687528476211647"
set depotrus="928377878194096332"
set depotmain="6220281101741165824"
goto download

:redcrow2
set SeasonID="Y1S4v2"
set depotregion="4723151273899978451"
set depotrus="1392224162684852622"
set depotmain="7602209696235700467"
goto download

:redcrow3
set SeasonID="Y1S4v3"
set depotregion="7853710360160705853"
set depotrus="209902469469869154"
set depotmain="6110300168016662940"
goto download

:redcrow4
set SeasonID="Y1S4v3_1"
set depotregion="3964014675867413060"
set depotrus="6898151523965649940"
set depotmain="6110300168016662940"
goto download

:redcrow5
set SeasonID="Y1S4v4"
set depotregion="7833614888759022957"
set depotrus="4590341058812313649"
set depotmain="3362062577581866690"
goto download

:velvetshell
MODE 69,17
Title Selecting Velvet Shell Version...
echo ---------------------------------------------------------------------
echo ^| Click on the Version of Velvet Shell (Y2S1) you want to download. ^|
echo ---------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y2S1   | 2017/02/07 | Liberator Supported" "   Y2S1.1  | 2017/02/21" "   Y2S1.2  | 2017/03/15" "   Y2S1.3  | 2017/04/18" "   Y2S1.4  | 2017/04/19" "  Y2S1.4.1 | 2017/04/20" "  Y2S1.4.2 | 2017/04/26" "   Y2S1.5  | 2017/05/24"
set SeasonName="VelvetShell"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto velvetshell
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto velvetshell0
if %ERRORLEVEL% == 4 goto velvetshell1
if %ERRORLEVEL% == 5 goto velvetshell2
if %ERRORLEVEL% == 6 goto velvetshell3
if %ERRORLEVEL% == 7 goto velvetshell4
if %ERRORLEVEL% == 8 goto velvetshell5
if %ERRORLEVEL% == 9 goto velvetshell6
if %ERRORLEVEL% == 10 goto velvetshell7

:velvetshell0
set SeasonID="Y2S1"
set depotregion="2248734317261478192"
set depotrus="2687181326074258760"
set depotmain="8006071763917433748"
goto download

:velvetshell1
set SeasonID="Y2S1v1"
set depotregion="1109940109645161197"
set depotrus="4459749312953465907"
set depotmain="7262126865275704318"
goto download

:velvetshell2
set SeasonID="Y2S1v2"
set depotregion="8772452879995678519"
set depotrus="2263328096994467375"
set depotmain="5433608839766509703"
goto download

:velvetshell3
set SeasonID="Y2S1v3"
set depotregion="2391739041108762163"
set depotrus="6338713447389056350"
set depotmain="240727859968587980"
goto download

:velvetshell4
set SeasonID="Y2S1v4"
set depotregion="3881084181952257002"
set depotrus="2197849583338850413"
set depotmain="6010094878936184160"
goto download

:velvetshell5
set SeasonID="Y2S1v4_1"
set depotregion="2090680669657578041"
set depotrus="2197849583338850413"
set depotmain="6010094878936184160"
goto download

:velvetshell6
set SeasonID="Y2S1v4_2"
set depotregion="5599731048449043716"
set depotrus="3997457949519098943"
set depotmain="6010094878936184160"
goto download

:velvetshell7
set SeasonID="Y2S1v5"
set depotregion="2786501509753402970"
set depotrus="2156232380211655527"
set depotmain="2332919753188284154"
goto download

:health
MODE 63,13
Title Selecting Health Version...
echo ---------------------------------------------------------------
echo ^| Click on the Version of Health (Y2S2) you want to download. ^|
echo ---------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y2S2  | 2017/06/07 | Liberator Supported" "  Y2S2.1 | 2017/06/20" "  Y2S2.2 | 2017/07/11" "  Y2S2.3 | 2017/08/09"
set SeasonName="Health"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto health
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto health0
if %ERRORLEVEL% == 4 goto health1
if %ERRORLEVEL% == 5 goto health2
if %ERRORLEVEL% == 6 goto health3

:health0
set SeasonID="Y2S2"
set depotregion="5875987479498297665"
set depotrus="8542242518901049325"
set depotmain="708773000306432190"
goto download

:health1
set SeasonID="Y2S2v1"
set depotregion="1473850143576448359"
set depotrus="5400243521053222686"
set depotmain="6064603295984080517"
goto download

:health2
set SeasonID="Y2S2v2"
set depotregion="6422590123566126189"
set depotrus="1387511590499267896"
set depotmain="2489064564707465531"
goto download

:health3
set SeasonID="Y2S2v3"
set depotregion="8948840210977117778"
set depotrus="1621080914528275732"
set depotmain="2410147212125863824"
goto download

:bloodorchid
MODE 69,16
Title Selecting Blood Orchid Version...
echo ---------------------------------------------------------------------
echo ^| Click on the Version of Blood Orchid (Y2S3) you want to download. ^|
echo ---------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y2S3   | 2017/09/05 | Liberator Supported" "   Y2S3.1  | 2017/09/07" "  Y2S3.1.1 | 2017/09/12" "   Y2S3.2  | 2017/09/19" "  Y2S3.2.1 | 2017/09/25 | Liberator Supported" "   Y2S3.3  | 2017/10/26" "   Y2S3.4  | 2017/11/20
set SeasonName="BloodOrchid"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto bloodorchid
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto bloodorchid0
if %ERRORLEVEL% == 4 goto bloodorchid1
if %ERRORLEVEL% == 5 goto bloodorchid2
if %ERRORLEVEL% == 6 goto bloodorchid3
if %ERRORLEVEL% == 7 goto bloodorchid4

:bloodorchid0
set SeasonID="Y2S3"
set depotregion="8738820022932508379"
set depotrus="4662662335520989204"
set depotmain="2595400291492146232"
goto download

:bloodorchid1
set SeasonID="Y2S3v1"
set depotregion="204390740189861409"
set depotrus="1845409411684836957"
set depotmain="4213475201659399282"
goto download

:bloodorchid2
set SeasonID="Y2S3v1_1"
set depotregion="5831959061468534291"
set depotrus="8778988986972747563"
set depotmain="4213475201659399282"
goto download

:bloodorchid3
set SeasonID="Y2S3v2"
set depotregion="6309847129820490464"
set depotrus="3899500673949464829"
set depotmain="1613631671988840841"
goto download

:bloodorchid4
set SeasonID="Y2S3v2_1"
set depotregion="6708129824495912434"
set depotrus="5927780489446635852"
set depotmain="1613631671988840841"
goto download

:bloodorchid5
set SeasonID="Y2S3v3"
set depotregion="3129574670456383472"
set depotrus="3742126739332198372"
set depotmain="9058009727395365075"
goto download

:bloodorchid6
set SeasonID="Y2S3v4"
set depotregion="1680894189539527336"
set depotrus="656513879743173133"
set depotmain="1714870111073381407"
goto download

:whitenoise
MODE 68,13
Title Selecting White Noise Version...
echo --------------------------------------------------------------------
echo ^| Click on the Version of White Noise (Y2S4) you want to download. ^|
echo --------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y2S4   | 2017/12/05 | Liberator Supported" "   Y2S4.1  | 2017/12/14 | Liberator Supported" "  Y2S4.1.1 | 2018/01/09" "   Y2S4.2  | 2018/01/23"
set SeasonName="WhiteNoise"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto whitenoise
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto whitenoise0
if %ERRORLEVEL% == 4 goto whitenoise1
if %ERRORLEVEL% == 5 goto whitenoise2
if %ERRORLEVEL% == 6 goto whitenoise3

:whitenoise0
set SeasonID="Y2S4"
set depotregion="2066250193950057921"
set depotrus="8421028160473337894"
set depotmain="2783803489764777627"
goto download

:whitenoise1
set SeasonID="Y2S4v1"
set depotregion="8748734086032257441"
set depotrus="8175359039160965183"
set depotmain="4221297486420648079"
goto download

:whitenoise2
set SeasonID="Y2S4v1_1"
set depotregion="8153937375637500344"
set depotrus="6972019683540660469"
set depotmain="4221297486420648079"
goto download

:whitenoise3
set SeasonID="Y2S4v2"
set depotregion="2394373235773179546"
set depotrus="8626573768000118855"
set depotmain="2234327846530762420"
goto download

:chimera
MODE 64,17
Title Selecting Chimera Version...
echo ----------------------------------------------------------------
echo ^| Click on the Version of Chimera (Y3S1) you want to download. ^|
echo ----------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y3S1   | 2018/03/06 | Liberator Supported" "  Y3S1.0.1 | 2018/03/08" "  Y3S1.0.2 | 2018/03/14" "   Y3S1.1  | 2018/03/20" "   Y3S1.2  | 2018/04/05" "   Y3S1.3  | 2018/04/10" "   Y3S1.4  | 2018/05/01" "  Y3S1.4.1 | 2018/05/09"
set SeasonName="Chimera"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto chimera
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto chimera0
if %ERRORLEVEL% == 4 goto chimera1
if %ERRORLEVEL% == 5 goto chimera2
if %ERRORLEVEL% == 6 goto chimera3
if %ERRORLEVEL% == 7 goto chimera4
if %ERRORLEVEL% == 8 goto chimera5
if %ERRORLEVEL% == 9 goto chimera6
if %ERRORLEVEL% == 10 goto chimera7

:chimera0
set SeasonID="Y3S1"
set depotregion="5071357104726974256"
set depotrus="4768963659370299631"
set depotmain="4701787239566783972"
goto download

:chimera1
set SeasonID="Y3S1v0_1"
set depotregion="1956606670653760710"
set depotrus="1246769048193210206"
set depotmain="4701787239566783972"
goto download

:chimera2
set SeasonID="Y3S1v0_2"
set depotregion="5094178044344901960"
set depotrus="5892652439969936880"
set depotmain="4701787239566783972"
goto download

:chimera3
set SeasonID="Y3S1v1"
set depotregion="2098238722661610069"
set depotrus="1669296079326672351
set depotmain="8844018984991890719"
goto download

:chimera4
set SeasonID="Y3S1v2"
set depotregion="6573659793474565633"
set depotrus="5339391413754634142"
set depotmain="8623187438757487885"
goto download

:chimera5
set SeasonID="Y3S1v3"
set depotregion="7501650168266880884"
set depotrus="6640586092473093025"
set depotmain="487952443106690921"
goto download

:chimera6
set SeasonID="Y3S1v4"
set depotregion="5419923013486940526"
set depotrus="4847821550610846352"
set depotmain="8908597131992649182"
goto download

:chimera7
set SeasonID="Y3S1v4_1"
set depotregion="8313695599061167710"
set depotrus="6222837626242055146"
set depotmain="8908597131992649182"
goto download

:parabellum
MODE 68,21
Title Selecting Para Bellum Version...
echo --------------------------------------------------------------------
echo ^| Click on the Version of Para Bellum (Y3S2) you want to download. ^|
echo --------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y3S2   | 2018/06/07 | Liberator Supported" "  Y3S2.0.1 | 2018/06/11" "  Y3S2.0.2 | 2018/06/13" "   Y3S2.1  | 2018/06/15" "   Y3S2.2  | 2018/06/20" "   Y3S2.3  | 2018/06/21 | Liberator Supported" "   Y3S2.4  | 2018/06/29" "   Y3S2.5  | 2018/07/23" "  Y3S2.5.1 | 2018/07/25" "   Y3S2.6  | 2018/07/23" "   Y3S2.7  | 2018/08/06" "  Y3S2.7.1 | 2018/08/14"
set SeasonName="ParaBellum"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto parabellum
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto parabellum0
if %ERRORLEVEL% == 4 goto parabellum1
if %ERRORLEVEL% == 5 goto parabellum2
if %ERRORLEVEL% == 6 goto parabellum3
if %ERRORLEVEL% == 7 goto parabellum4
if %ERRORLEVEL% == 8 goto parabellum5
if %ERRORLEVEL% == 9 goto parabellum6
if %ERRORLEVEL% == 10 goto parabellum7
if %ERRORLEVEL% == 11 goto parabellum8
if %ERRORLEVEL% == 12 goto parabellum9
if %ERRORLEVEL% == 13 goto parabellum10
if %ERRORLEVEL% == 14 goto parabellum11

:parabellum0
set SeasonID="Y3S2"
set depotregion="8312108283310615233"
set depotrus="1474330970340166539"
set depotmain="8765715607275074515"
goto download

:parabellum1
set SeasonID="Y3S2v0_1"
set depotregion="804008783478102509"
set depotrus="8531117638322604677"
set depotmain="8765715607275074515"
goto download

:parabellum2
set SeasonID="Y3S2v0_2"
set depotregion="6507886921175556869"
set depotrus="7995779530685147208"
set depotmain="8765715607275074515"
goto download

:parabellum3
set SeasonID="Y3S2v1"
set depotregion="4697717947558759780"
set depotrus="6590905581675762186"
set depotmain="3656511082285344569"
goto download

:parabellum4
set SeasonID="Y3S2v2"
set depotregion="4301615908332004424"
set depotrus="1354286977188776086"
set depotmain="1769902689993452071"
goto download

:parabellum5
set SeasonID="Y3S2v3"
set depotregion="7734407702273584928"
set depotrus="5811120377524556582"
set depotmain="6040984784493697965"
goto download

:parabellum6
set SeasonID="Y3S2v4"
set depotregion="7956377116434183560"
set depotrus="1028206749361977442"
set depotmain="538997523841428235"
goto download

:parabellum7
set SeasonID="Y3S2v5"
set depotregion="7144286775470165233"
set depotrus="2217143106878866652"
set depotmain="1543621376410399758"
goto download

:parabellum8
set SeasonID="Y3S2v5_1"
set depotregion="2338096639894370747"
set depotrus="2510140363942237144"
set depotmain="1543621376410399758"
goto download

:parabellum9
set SeasonID="Y3S2v6"
set depotregion="7727030782821676747"
set depotrus="7612896943642733404"
set depotmain="4479992811705865482"
goto download

:parabellum10
set SeasonID="Y3S2v7"
set depotregion="1535576122597123448"
set depotrus="5208645364457207536"
set depotmain="635931011346159044"
goto download

:parabellum11
set SeasonID="Y3S2v7_1"
set depotregion="2448060187292553320"
set depotrus="6117737361379131831"
set depotmain="635931011346159044"
goto download

:grimsky
MODE 65,18
Title Selecting Grim Sky Version...
echo -----------------------------------------------------------------
echo ^| Click on the Version of Grim Sky (Y3S3) you want to download. ^|
echo -----------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y3S3   | 2018/09/04 | Liberator Supported" "   Y3S3.1  | 2018/09/18" "   Y3S3.2  | 2018/09/19" "   Y3S3.3  | 2018/09/26" "   Y3S3.4  | 2018/10/11" "   Y3S3.5  | 2018/10/18 | Liberator Supported" "  Y3S3.5.1 | 2018/10/23" "   Y3S3.6  | 2018/10/29" "   Y3S3.7  | 2018/11/28"
set SeasonName="GrimSky"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto grimsky
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto grimsky0
if %ERRORLEVEL% == 4 goto grimsky1
if %ERRORLEVEL% == 5 goto grimsky2
if %ERRORLEVEL% == 6 goto grimsky3
if %ERRORLEVEL% == 7 goto grimsky4
if %ERRORLEVEL% == 8 goto grimsky5
if %ERRORLEVEL% == 9 goto grimsky6
if %ERRORLEVEL% == 10 goto grimsky7
if %ERRORLEVEL% == 11 goto grimsky8

:grimsky0
set SeasonID="Y3S3"
set depotregion="7286067994760020542"
set depotrus="3144556314994867170"
set depotmain="4133951394045241747"
goto download

:grimsky1
set SeasonID="Y3S3v1"
set depotregion="2118401075539499814"
set depotrus="6283695903707886313"
set depotmain="4603455046923951203"
goto download

:grimsky2
set SeasonID="Y3S3v2"
set depotregion="4363787590839129578"
set depotrus="990555358632001985"
set depotmain="127181656040860107"
goto download

:grimsky3
set SeasonID="Y3S3v3"
set depotregion="7451253491361086198"
set depotrus="8220207063901924057"
set depotmain="5707418668160922298"
goto download

:grimsky4
set SeasonID="Y3S3v4"
set depotregion="4084799593640814162"
set depotrus="929730484688021278"
set depotmain="3501848630521433893"
goto download

:grimsky5
set SeasonID="Y3S3v5"
set depotregion="5562094852451837435"
set depotrus="5465169470949211447"
set depotmain="7781202564071310413"
goto download

:grimsky6
set SeasonID="Y3S3v5_1"
set depotregion="1341605814940437835"
set depotrus="4370736249866983513"
set depotmain="7781202564071310413"
goto download

:grimsky7
set SeasonID="Y3S3v6"
set depotregion="203822255775319406"
set depotrus="3436480691217969192"
set depotmain="143501903900249747"
goto download

:grimsky8
set SeasonID="Y3S3v7"
set depotregion="6910510172259860111"
set depotrus="8943431450771867505"
set depotmain="4985672080416935919"
goto download

:windbastion
MODE 69,18
Title Selecting Wind Bastion Version...
echo ---------------------------------------------------------------------
echo ^| Click on the Version of Wind Bastion (Y3S4) you want to download. ^|
echo ---------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y3S4   | 2018/12/04 | Liberator Supported" "  Y3S4.0.1 | 2018/12/06" "   Y3S4.1  | 2018/12/11" "   Y3S4.2  | 2018/12/17" "   Y3S4.3  | 2018/12/19" "  Y3S4.3.1 | 2019/01/07" "   Y3S4.4  | 2019/02/05" "   Y3S4.5  | 2019/02/07" "   Y3S4.6  | 2019/02/11"
set SeasonName="WindBastion"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto windbastion
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto windbastion0
if %ERRORLEVEL% == 4 goto windbastion1
if %ERRORLEVEL% == 5 goto windbastion2
if %ERRORLEVEL% == 6 goto windbastion3
if %ERRORLEVEL% == 7 goto windbastion4

:windbastion0
set SeasonID="Y3S4"
set depotregion="6502258854032233436"
set depotrus="5406593359909338734"
set depotmain="7659555540733025386"
goto download

:windbastion1
set SeasonID="Y3S4v0_1"
set depotregion="8446247965926304539"
set depotrus="4227230729218867895"
set depotmain="7659555540733025386"
goto download

:windbastion2
set SeasonID="Y3S4v1"
set depotregion="2880124854973873639"
set depotrus="3555832692766590945"
set depotmain="6764973742243879985"
goto download

:windbastion3
set SeasonID="Y3S4v2"
set depotregion="744456657004633411"
set depotrus="4126218862518568871"
set depotmain="7715052318385672223"
goto download

:windbastion4
set SeasonID="Y3S4v3"
set depotregion="8186313077310924606"
set depotrus="1628717841717962896"
set depotmain="4309991311044407261"
goto download

:windbastion5
set SeasonID="Y3S4v3_1"
set depotregion="7809121215489044354"
set depotrus="3459766989728569600"
set depotmain="4309991311044407261"
goto download

:windbastion6
set SeasonID="Y3S4v4"
set depotregion="6130430544139136530"
set depotrus="5480052847996174997"
set depotmain="1156748851350771617"
goto download

:windbastion7
set SeasonID="Y3S4v5"
set depotregion="1662003928727350637"
set depotrus="7017601593481118499"
set depotmain="5523355888647508215"
goto download

:windbastion8
set SeasonID="Y3S4v6"
set depotregion="6352416656473591151"
set depotrus="7555192545340590824"
set depotmain="3687288632143124824"
goto download

:burnthorizon
MODE 70,17
Title Selecting Burnt Horizon Version...
echo ----------------------------------------------------------------------
echo ^| Click on the Version of Burnt Horizon (Y4S1) you want to download. ^|
echo ----------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y4S1  | 2019/03/06 | Liberator Supported" "  Y4S1.1 | 2019/03/11" "  Y4S1.2 | 2019/03/14 | Liberator Supported" "  Y4S1.3 | 2019/03/19" "  Y4S1.4 | 2019/04/04" "  Y4S1.5 | 2019/04/16" "  Y4S1.6 | 2019/04/30" "  Y4S1.7 | 2019/05/14"
set SeasonName="BurntHorizon"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto burnthorizon
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto burnthorizon0
if %ERRORLEVEL% == 4 goto burnthorizon1
if %ERRORLEVEL% == 5 goto burnthorizon2
if %ERRORLEVEL% == 6 goto burnthorizon3
if %ERRORLEVEL% == 7 goto burnthorizon4
if %ERRORLEVEL% == 8 goto burnthorizon5
if %ERRORLEVEL% == 9 goto burnthorizon6
if %ERRORLEVEL% == 10 goto burnthorizon7

:burnthorizon0
set SeasonID="Y4S1"
set depotregion="8985694971177711792"
set depotrus="3777349673527123995"
set depotmain="4355229858723790756"
goto download

:burnthorizon1
set SeasonID="Y4S1v1"
set depotregion="2883608350934762524"
set depotrus="8802081240559204995"
set depotmain="9186018008487227562"
goto download

:burnthorizon2
set SeasonID="Y4S1v2"
set depotregion="8356277316976403078"
set depotrus="1384328559966859661"
set depotmain="5935578581006804383"
goto download

:burnthorizon3
set SeasonID="Y4S1v3"
set depotregion="3845413840757522720"
set depotrus="4496022170389689875"
set depotmain="4091857012692615756"
goto download

:burnthorizon4
set SeasonID="Y4S1v4"
set depotregion="5048274162618266481"
set depotrus="8604304832622395595"
set depotmain="1596013337033707402"
goto download

:burnthorizon5
set SeasonID="Y4S1v5"
set depotregion="793717907296878217"
set depotrus="1374718118029860085"
set depotmain="3426817840625102736"
goto download

:burnthorizon6
set SeasonID="Y4S1v6"
set depotregion="1656772351530803955"
set depotrus="4581126506658813391"
set depotmain="6376489936568800025"
goto download

:burnthorizon7
set SeasonID="Y4S1v7"
set depotregion="9038890325117120680"
set depotrus="601757694227841208"
set depotmain="5843281626943861656"
goto download

:phantomsight
MODE 70,20
Title Selecting Phantom Sight Version...
echo ----------------------------------------------------------------------
echo ^| Click on the Version of Phantom Sight (Y4S2) you want to download. ^|
echo ----------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y4S2   | 2019/06/11 | Liberator Supported" "   Y4S2.1  | 2019/06/21" "   Y4S2.2  | 2019/06/25" "   Y4S2.3  | 2019/07/03" "   Y4S2.4  | 2019/07/08" "  Y4S2.4.1 | 2019/07/09" "   Y4S2.5  | 2019/07/11" "   Y4S2.6  | 2019/07/22" "   Y4S2.7  | 2019/08/01" "   Y4S2.8  | 2019/08/12" "  Y4S2.8.1 | 2019/08/15"
set SeasonName="PhantomSight"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto phantomsight
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto phantomsight0
if %ERRORLEVEL% == 4 goto phantomsight1
if %ERRORLEVEL% == 5 goto phantomsight2
if %ERRORLEVEL% == 6 goto phantomsight3
if %ERRORLEVEL% == 7 goto phantomsight4
if %ERRORLEVEL% == 8 goto phantomsight5
if %ERRORLEVEL% == 9 goto phantomsight6
if %ERRORLEVEL% == 10 goto phantomsight7
if %ERRORLEVEL% == 11 goto phantomsight8
if %ERRORLEVEL% == 12 goto phantomsight9

:phantomsight0
set SeasonID="Y4S2"
set depotregion="693082837425613508"
set depotrus="3326664059403997209"
set depotmain="5408324128694463720"
goto download

:phantomsight1
set SeasonID="Y4S2v1"
set depotregion="1416149532693733884"
set depotrus="2755787459219956782"
set depotmain="8620347804827657342"
goto download

:phantomsight2
set SeasonID="Y4S2v2"
set depotregion="7057301638407442677"
set depotrus="1140829388758894130"
set depotmain="725464114660493736"
goto download

:phantomsight3
set SeasonID="Y4S2v3"
set depotregion="5747930459706794468"
set depotrus="3835855819216663195"
set depotmain="8568659457012896424"
goto download

:phantomsight4
set SeasonID="Y4S2v4"
set depotregion="1328428879254881830"
set depotrus="6130428231836870749"
set depotmain="1007326454437934684"
goto download

:phantomsight5
set SeasonID="Y4S2v4_1"
set depotregion="5880456241094312599"
set depotrus="7407352186561606299"
set depotmain="1007326454437934684"
goto download

:phantomsight6
set SeasonID="Y4S2v5"
set depotregion="1780911893717639181"
set depotrus="5426114590475776262"
set depotmain="2275606874716984149"
goto download

:phantomsight7
set SeasonID="Y4S2v6"
set depotregion="874784204095967460"
set depotrus="8312012121516406316"
set depotmain="1799279767606256135"
goto download

:phantomsight8
set SeasonID="Y4S2v7"
set depotregion="1274027230492785392"
set depotrus="6302362483192637251"
set depotmain="7148106320391914372"
goto download

:phantomsight9
set SeasonID="Y4S2v8"
set depotregion="3094705790262026432"
set depotrus="7319694800451534348"
set depotmain="822407407036453959"
goto download

:phantomsight10
set SeasonID="Y4S2v8_1"
set depotregion="6078996442549337746"
set depotrus="3722403327683788177"
set depotmain="822407407036453959"
goto download

:emberrise
MODE 67,15
Title Selecting Ember Rise Version...
echo -------------------------------------------------------------------
echo ^| Click on the Version of Ember Rise (Y4S3) you want to download. ^|
echo -------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y4S3  | 2019/09/11" "  Y4S3.1 | 2019/09/12" "  Y4S3.2 | 2019/09/19" "  Y4S3.3 | 2019/10/08 | Liberator Supported" "  Y4S3.4 | 2019/10/22 | Liberator Supported" "  Y4S3.5 | 2019/11/19"
set SeasonName="EmberRise"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto emberrise
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto emberrise0
if %ERRORLEVEL% == 4 goto emberrise1
if %ERRORLEVEL% == 5 goto emberrise2
if %ERRORLEVEL% == 6 goto emberrise3
if %ERRORLEVEL% == 7 goto emberrise4
if %ERRORLEVEL% == 8 goto emberrise5

:emberrise0
set SeasonID="Y4S3"
set depotregion="7309481042294838052"
set depotrus="684480090862996679"
set depotmain="5429930338066808153"
goto download

:emberrise1
set SeasonID="Y4S3v1"
set depotregion="6976661838537581555"
set depotrus="25810888895947694"
set depotmain="883167482474833003"
goto download

:emberrise2
set SeasonID="Y4S3v2"
set depotregion="1131006631054616836"
set depotrus="6138349797489385660"
set depotmain="2876542200021274815"
goto download

:emberrise3
set SeasonID="Y4S3v3"
set depotregion="6592316509286407119"
set depotrus="4614590885164494388"
set depotmain="1556527176552332195"
goto download

:emberrise4
set SeasonID="Y4S3v4"
set depotregion="3546781236735558235"
set depotrus="9016692046802024636"
set depotmain="7869081741739849703"
goto download

:emberrise5
set SeasonID="Y4S3v5"
set depotregion="6875900529806704351"
set depotrus="9195312485590853270"
set depotmain="8896835795789302677"
goto download

:shiftingtides
MODE 71,17
Title Selecting Shifting Tides Version...
echo -----------------------------------------------------------------------
echo ^| Click on the Version of Shifting Tides (Y4S4) you want to download. ^|
echo -----------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y4S4  | 2019/12/03 | Liberator Supported" "  Y4S4.1 | 2019/12/11" "  Y4S4.2 | 2019/12/19" "  Y4S4.3 | 2020/01/13 | Liberator Supported" "  Y4S4.4 | 2020/01/21" "  Y4S4.5 | 2020/01/28" "  Y4S4.6 | 2020/02/05" "  Y4S4.7 | 2020/02/25"
set SeasonName="ShiftingTides"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto shiftingtides
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto shiftingtides0
if %ERRORLEVEL% == 4 goto shiftingtides1
if %ERRORLEVEL% == 5 goto shiftingtides2
if %ERRORLEVEL% == 6 goto shiftingtides3
if %ERRORLEVEL% == 7 goto shiftingtides4
if %ERRORLEVEL% == 8 goto shiftingtides5
if %ERRORLEVEL% == 9 goto shiftingtides6
if %ERRORLEVEL% == 10 goto shiftingtides7

:shiftingtides0
set SeasonID="Y4S4"
set depotregion="299124516841461614"
set depotrus="510172308722680354"
set depotmain="1842268638395240106"
goto download

:shiftingtides1
set SeasonID="Y4S4v1"
set depotregion="7901823222448081080"
set depotrus="636698585452907732"
set depotmain="3112063757020158619"
goto download

:shiftingtides2
set SeasonID="Y4S4v2"
set depotregion="3238415028817932471"
set depotrus="7798807920191935662"
set depotmain="444689710003629547"
goto download

:shiftingtides3
set SeasonID="Y4S4v3"
set depotregion="3348757540492389781"
set depotrus="4959786928733194709"
set depotmain="3048894025352845317"
goto download

:shiftingtides4
set SeasonID="Y4S4v4"
set depotregion="4431387403886426551"
set depotrus="9099211881280164426"
set depotmain="7583962726478413267"
goto download

:shiftingtides5
set SeasonID="Y4S4v5"
set depotregion="9019721415992897209"
set depotrus="7587097985997786157"
set depotmain="8467388685592738778"
goto download

:shiftingtides6
set SeasonID="Y4S4v6"
set depotregion="955314308543204975"
set depotrus="2943715111250422481"
set depotmain="1433254118097489604"
goto download

:shiftingtides7
set SeasonID="Y4S4v7"
set depotregion="6416106558518086188"
set depotrus="4026078393324221501"
set depotmain="8695823324941118609"
goto download

:voidedge
MODE 66,17
Title Selecting Void Edge Version...
echo ------------------------------------------------------------------
echo ^| Click on the Version of Void Edge (Y5S1) you want to download. ^|
echo ------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y5S1  | 2020/03/10" "  Y5S1.1 | 2020/03/24" "  Y5S1.2 | 2020/03/30" "  Y5S1.3 | 2020/04/14" "  Y5S1.4 | 2020/04/21" "  Y5S1.5 | 2020/04/30" "  Y5S1.6 | 2020/05/12" "  Y5S1.7 | 2020/06/03"
set SeasonName="VoidEdge"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto voidedge
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto voidedge0
if %ERRORLEVEL% == 4 goto voidedge1
if %ERRORLEVEL% == 5 goto voidedge2
if %ERRORLEVEL% == 6 goto voidedge3
if %ERRORLEVEL% == 7 goto voidedge4
if %ERRORLEVEL% == 8 goto voidedge5
if %ERRORLEVEL% == 9 goto voidedge6
if %ERRORLEVEL% == 10 goto voidedge7

:voidedge0
set SeasonID="Y5S1"
set depotregion="8007091753837589034"
set depotrus="2583838033617047180"
set depotmain="2810676266503656332"
goto download

:voidedge1
set SeasonID="Y5S1v1"
set depotregion="3748961496348274353"
set depotrus="6361747839297327021"
set depotmain="9223121581080736558"
goto download

:voidedge2
set SeasonID="Y5S1v2"
set depotregion="6343963438285695058"
set depotrus="657217859200426719"
set depotmain="7558663913421321484"
goto download

:voidedge3
set SeasonID="Y5S1v3"
set depotregion="5879760851393026226"
set depotrus="6956474275298330226"
set depotmain="7341086999128856043"
goto download

:voidedge4
set SeasonID="Y5S1v4"
set depotregion="1231043991433329965"
set depotrus="3519213792348908963"
set depotmain="6774583324924310612"
goto download

:voidedge5
set SeasonID="Y5S1v5"
set depotregion="4736360397583523381"
set depotrus="3070256018494753206"
set depotmain="6296533808765702678"
goto download

:voidedge6
set SeasonID="Y5S1v6"
set depotregion="1378283477131353042"
set depotrus="8141661820686844368"
set depotmain="1739364586766771991"
goto download

:voidedge7
set SeasonID="Y5S1v7"
set depotregion="6923455200973694065"
set depotrus="3314146123345252455"
set depotmain="3207361501910189821"
goto download

:steelwave
MODE 67,16
Title Selecting Steel Wave Version...
echo -------------------------------------------------------------------
echo ^| Click on the Version of Steel Wave (Y5S2) you want to download. ^|
echo -------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y5S2   | 2020/06/16" "   Y5S2.1  | 2020/06/22" "  Y5S2.1.1 | 2020/06/23" "   Y5S2.2  | 2020/06/30" "   Y5S2.3  | 2020/07/14" "   Y5S2.4  | 2020/07/29" "   Y5S2.5  | 2020/08/10"
set SeasonName="SteelWave"
set crack="Y2S1-Y5S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto steelwave
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto steelwave0
if %ERRORLEVEL% == 4 goto steelwave1
if %ERRORLEVEL% == 5 goto steelwave2
if %ERRORLEVEL% == 6 goto steelwave3
if %ERRORLEVEL% == 7 goto steelwave4
if %ERRORLEVEL% == 8 goto steelwave5
if %ERRORLEVEL% == 9 goto steelwave6

:steelwave0
set SeasonID="Y5S2"
set depotregion="1296806240678481187"
set depotrus="5838065097101371940"
set depotmain="2911638056757212246"
goto download

:steelwave1
set SeasonID="Y5S2v1"
set depotregion="7032500641931923367"
set depotrus="7091016154116813735"
set depotmain="4896370297497223234"
goto download

:steelwave2
set SeasonID="Y5S2v1_1"
set depotregion="7032500641931923367"
set depotrus="7091016154116813735"
set depotmain="8083217055977195199"
goto download

:steelwave3
set SeasonID="Y5S2v2"
set depotregion="6993916839791687054"
set depotrus="1589808308880546752"
set depotmain="2135342411441413776"
goto download

:steelwave4
set SeasonID="Y5S2v3"
set depotregion="8825153716341224927"
set depotrus="662827015244686671"
set depotmain="786683960845548681"
goto download

:steelwave5
set SeasonID="Y5S2v4"
set depotregion="2287849678928593252"
set depotrus="8753206532335363245"
set depotmain="1610834739284564851"
goto download

:steelwave6
set SeasonID="Y5S2v5"
set depotregion="4367817844736324940"
set depotrus="6938478745264725185"
set depotmain="893971391196952070"
goto download

:shadowlegacy
MODE 70,16
Title Selecting Shadow Legacy Version...
echo ----------------------------------------------------------------------
echo ^| Click on the Version of Shadow Legacy (Y5S3) you want to download. ^|
echo ----------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y5S3   | 2020/09/10" "   Y5S3.1  | 2020/09/11" "   Y5S3.2  | 2020/09/22" "  Y5S3.2.1 | 2020/10/01" "   Y5S3.3  | 2020/10/06" "   Y5S3.4  | 2020/10/20" "   Y5S3.5  | 2020/11/17 | Liberator2 and R6SGlobal Supported"
set SeasonName="ShadowLegacy"
set crack="Y5S3-Y6S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto shadowlegacy
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto shadowlegacy0
if %ERRORLEVEL% == 4 goto shadowlegacy1
if %ERRORLEVEL% == 5 goto shadowlegacy2
if %ERRORLEVEL% == 6 goto shadowlegacy3
if %ERRORLEVEL% == 7 goto shadowlegacy4
if %ERRORLEVEL% == 8 goto shadowlegacy5
if %ERRORLEVEL% == 9 goto shadowlegacy6

:shadowlegacy0
set SeasonID="Y5S3"
set depotregion="885453180592640750"
set depotrus="6833050800226599890"
set depotmain="7750070106878890861"
goto download

:shadowlegacy1
set SeasonID="Y5S3v1"
set depotregion="3606889793388026846"
set depotrus="5834041157623245782"
set depotmain="7135972290082565698"
goto download

:shadowlegacy2
set SeasonID="Y5S3v2"
set depotregion="7972140223274394822"
set depotrus="3898102269005926959"
set depotmain="7600696543346383673"
goto download

:shadowlegacy3
set SeasonID="Y5S3v2_1"
set depotregion="7972140223274394822"
set depotrus="3898102269005926959"
set depotmain="5928024184814796453"
goto download

:shadowlegacy4
set SeasonID="Y5S3v3"
set depotregion="6855429514477551456"
set depotrus="8162181424375250084"
set depotmain="1697363535014326612"
goto download

:shadowlegacy5
set SeasonID="Y5S3v4"
set depotregion="3265954110064157115"
set depotrus="693505476132312360"
set depotmain="5436378897406471956"
goto download

:shadowlegacy6
set SeasonID="Y5S3v5"
set depotregion="85893637567200342"
set depotrus="4020038723910014041"
set depotmain="3089981610366186823"
goto download

:neondawn
MODE 66,14
Title Selecting Neon Dawn Version...
echo ------------------------------------------------------------------
echo ^| Click on the Version of Neon Dawn (Y5S4) you want to download. ^|
echo ------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y5S4  | 2020/12/01" "  Y5S4.1 | 2020/12/15" "  Y5S4.2 | 2021/01/19" "  Y5S4.3 | 2021/01/28" "  Y5S4.4 | 2021/02/03"
set SeasonName="NeonDawn"
set crack="Y5S3-Y6S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto neondawn
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto neondawn0
if %ERRORLEVEL% == 4 goto neondawn1
if %ERRORLEVEL% == 5 goto neondawn2
if %ERRORLEVEL% == 6 goto neondawn3
if %ERRORLEVEL% == 7 goto neondawn4

:neondawn0
set SeasonID="Y5S4"
set depotregion="752517632960395491"
set depotrus="4263017894965855363"
set depotmain="7979405601806736439"
goto download

:neondawn1
set SeasonID="Y5S4v1"
set depotregion="4603466410264012468"
set depotrus="5905072207961244743"
set depotmain="8734330129538360617"
goto download

:neondawn2
set SeasonID="Y5S4v2"
set depotregion="3390446325154338855"
set depotrus="3175150742361965235"
set depotmain="6947060999143280245"
goto download

:neondawn3
set SeasonID="Y5S4v3"
set depotregion="7090564554929047639"
set depotrus="355628345676656623"
set depotmain="2389874338514947626"
goto download

:neondawn4
set SeasonID="Y5S4v4"
set depotregion="4713320084981112320"
set depotrus="3560446343418579092"
set depotmain="3711873929777458413"
goto download

:crimsonheist
MODE 70,16
Title Selecting Crimson Heist Version...
echo ----------------------------------------------------------------------
echo ^| Click on the Version of Crimson Heist (Y6S1) you want to download. ^|
echo ----------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y6S1   | 2021/03/16" "   Y6S1.1  | 2021/03/25" "  Y6S1.1.1 | 2021/03/30" "   Y6S1.2  | 2021/04/13" "   Y6S1.3  | 2021/05/03" "   Y6S1.4  | 2021/05/06" "  Y6S1.4.1 | 2021/05/31"
set SeasonName="CrimsonHeist"
set crack="Y5S3-Y6S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto crimsonheist
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto crimsonheist0
if %ERRORLEVEL% == 4 goto crimsonheist1
if %ERRORLEVEL% == 5 goto crimsonheist2
if %ERRORLEVEL% == 6 goto crimsonheist3
if %ERRORLEVEL% == 7 goto crimsonheist4
if %ERRORLEVEL% == 8 goto crimsonheist5
if %ERRORLEVEL% == 9 goto crimsonheist6

:crimsonheist0
set SeasonID="Y6S1"
set depotregion="2856157791070230108"
set depotrus="6508466502906951104"
set depotmain="5052226358972290060"
goto download

:crimsonheist1
set SeasonID="Y6S1v1"
set depotregion="7890853311380514304"
set depotrus="6130917224459224462"
set depotmain="3603418605816093265"
goto download

:crimsonheist2
set SeasonID="Y6S1v1_1"
set depotregion="7890853311380514304"
set depotrus="6130917224459224462"
set depotmain="7485515457663576274"
goto download

:crimsonheist3
set SeasonID="Y6S1v2"
set depotregion="3064601145867200235"
set depotrus="112545903505397258"
set depotmain="4116516450666651052"
goto download

:crimsonheist4
set SeasonID="Y6S1v3"
set depotregion="2885061431730336182"
set depotrus="6490511620863477502"
set depotmain="7462379569977894137"
goto download

:crimsonheist5
set SeasonID="Y6S1v4"
set depotregion="2200775373002020326"
set depotrus="8008777170632151465"
set depotmain="6368399491057872261"
goto download

:crimsonheist6
set SeasonID="Y6S1v4_1"
set depotregion="2200775373002020326"
set depotrus="8008777170632151465"
set depotmain="7781896841500953375"
goto download

:northstar
MODE 67,15
Title Selecting North Star Version...
echo -------------------------------------------------------------------
echo ^| Click on the Version of North Star (Y6S2) you want to download. ^|
echo -------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y6S2   | 2021/06/14" "   Y6S2.1  | 2021/06/29" "  Y6S2.1.1 | 2021/07/13" "   Y6S2.2  | 2021/07/27" "   Y6S2.3  | 2021/08/03" "  Y6S2.3.1 | 2021/08/12"
set SeasonName="NorthStar"
set crack="Y5S3-Y6S2"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto northstar
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto northstar0
if %ERRORLEVEL% == 4 goto northstar1
if %ERRORLEVEL% == 5 goto northstar2
if %ERRORLEVEL% == 6 goto northstar3
if %ERRORLEVEL% == 7 goto northstar4
if %ERRORLEVEL% == 8 goto northstar5

:northstar0
set SeasonID="Y6S2"
set depotregion="8733653062998518164"
set depotrus="5612633601760514684"
set depotmain="809542866761090243"
goto download

:northstar1
set SeasonID="Y6S2v1"
set depotregion="8541967402175826950"
set depotrus="8308768144536362238"
set depotmain="3162843171572073638"
goto download

:northstar2
set SeasonID="Y6S2v1_1"
set depotregion="8541967402175826950"
set depotrus="8308768144536362238"
set depotmain="614840333090258438"
goto download

:northstar3
set SeasonID="Y6S2v2"
set depotregion="2525708706057497155"
set depotrus="6767916709017546201"
set depotmain="6304700868033912207"
goto download

:northstar4
set SeasonID="Y6S2v3"
set depotregion="8537616701006158335"
set depotrus="7182046459781166052"
set depotmain="171281154865548992"
goto download

:northstar5
set SeasonID="Y6S2v3_1"
set depotregion="8537616701006158335"
set depotrus="7182046459781166052"
set depotmain="5588923295150591607"
goto download

:crystalguard
MODE 70,16
Title Selecting Crystal Guard Version...
echo ----------------------------------------------------------------------
echo ^| Click on the Version of Crystal Guard (Y6S3) you want to download. ^|
echo ----------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y6S3  | 2021/09/07" "  Y6S3.1 | 2021/09/15" "  Y6S3.2 | 2021/09/21" "  Y6S3.3 | 2021/09/28" "  Y6S3.4 | 2021/10/04" "  Y6S3.5 | 2021/10/19" "  Y6S3.6 | 2021/11/15"
set SeasonName="CrystalGuard"
set crack="Y6S3"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto crystalguard
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto crystalguard0
if %ERRORLEVEL% == 4 goto crystalguard1
if %ERRORLEVEL% == 5 goto crystalguard2
if %ERRORLEVEL% == 6 goto crystalguard3
if %ERRORLEVEL% == 7 goto crystalguard4
if %ERRORLEVEL% == 8 goto crystalguard5
if %ERRORLEVEL% == 9 goto crystalguard6

:crystalguard0
set SeasonID="Y6S3"
set depotregion="4859695099882698284"
set depotrus="5161489294178683219"
set depotmain="6526531850721822265"
goto download

:crystalguard1
set SeasonID="Y6S3v1"
set depotregion="1274392175470321430"
set depotrus="7663731303706966837"
set depotmain="7581842284043607458"
goto download

:crystalguard2
set SeasonID="Y6S3v2"
set depotregion="1005948007474998698"
set depotrus="2971024497593287699"
set depotmain="8428201830297292155"
goto download

:crystalguard3
set SeasonID="Y6S3v3"
set depotregion="7360698834668311541"
set depotrus="2183476425199113317"
set depotmain="7561655390691627373"
goto download

:crystalguard4
set SeasonID="Y6S3v4"
set depotregion="5504413283951022370"
set depotrus="515505727615365546"
set depotmain="8165093018527800646"
goto download

:crystalguard5
set SeasonID="Y6S3v5"
set depotregion="6797102132611024733"
set depotrus="525110313056577404"
set depotmain="5338107857083725813"
goto download

:crystalguard6
set SeasonID="Y6S3v6"
set depotregion="9055328556991635819"
set depotrus="4405065504084928682"
set depotmain="1030120416124554825"
goto download

:highcalibre
MODE 69,14
Title Selecting High Calibre Version...
echo ---------------------------------------------------------------------
echo ^| Click on the Version of High Calibre (Y6S4) you want to download. ^|
echo ---------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y6S4  | 2021/11/30" "  Y6S4.1 | 2021/12/14" "  Y6S4.2 | 2022/01/13" "  Y6S4.3 | 2022/01/25" "  Y6S4.4 | 2022/02/10"
set SeasonName="HighCalibre"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto highcalibre
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto highcalibre0
if %ERRORLEVEL% == 4 goto highcalibre1
if %ERRORLEVEL% == 5 goto highcalibre2
if %ERRORLEVEL% == 6 goto highcalibre3
if %ERRORLEVEL% == 7 goto highcalibre4

:highcalibre0
set SeasonID="Y6S4"
set depotregion="8409625851700028918"
set depotrus="5061986605226254108"
set depotmain="3114441751565500630"
goto download

:highcalibre1
set SeasonID="Y6S4v1"
set depotregion="9108176962637231352"
set depotrus="3213926339178367530"
set depotmain="5546525557232475661"
goto download

:highcalibre2
set SeasonID="Y6S4v2"
set depotregion="1123019850551445176"
set depotrus="2173526654018053164"
set depotmain="6106804289522683252"
goto download

:highcalibre3
set SeasonID="Y6S4v3"
set depotregion="2637055726475611418"
set depotrus="2074678920289758165"
set depotmain="8627214406801860013"
goto download

:highcalibre4
set SeasonID="Y6S4v4"
set depotregion="6482567692134571221"
set depotrus="6511150352559463656"
set depotmain="264051984542035389"
goto download

:demonveil
MODE 67,13
Title Selecting Demon Veil Version...
echo -------------------------------------------------------------------
echo ^| Click on the Version of Demon Veil (Y7S1) you want to download. ^|
echo -------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y7S1  | 2022/03/15" "  Y7S1.1 | 2022/03/31" "  Y7S1.2 | 2022/04/19" "  Y7S1.3 | 2022/05/10"
set SeasonName="DemonVeil"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto demonveil
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto demonveil0
if %ERRORLEVEL% == 4 goto demonveil1
if %ERRORLEVEL% == 5 goto demonveil2
if %ERRORLEVEL% == 6 goto demonveil3

:demonveil0
set SeasonID="Y7S1"
set depotregion="8202326812371523904"
set depotrus="8391138239196594960"
set depotmain="6747574794058562328"
goto download

:demonveil1
set SeasonID="Y7S1v1"
set depotregion="5228174545070174044"
set depotrus="7493698072024022783"
set depotmain="7502618000955728686"
goto download

:demonveil2
set SeasonID="Y7S1v2"
set depotregion="8323869632165751287"
set depotrus="1970003626423861715"
set depotmain="2178080523228113690"
goto download

:demonveil3
set SeasonID="Y7S1v3"
set depotregion="6003717934209927520"
set depotrus="8227415212110883667"
set depotmain="8545522898454376018"
goto download

:vectorglare
MODE 69,15
Title Selecting Vector Glare Version...
echo ---------------------------------------------------------------------
echo ^| Click on the Version of Vector Glare (Y7S2) you want to download. ^|
echo ---------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y7S2   | 2022/06/14" "  Y7S2.0.1 | 2022/06/22" "   Y7S2.1  | 2022/06/27" "   Y7S2.2  | 2022/07/21" "   Y7S2.3  | 2022/07/26" "   Y7S2.4  | 2022/08/09"
set SeasonName="VectorGlare"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto vectorglare
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto vectorglare0
if %ERRORLEVEL% == 4 goto vectorglare1
if %ERRORLEVEL% == 5 goto vectorglare2
if %ERRORLEVEL% == 6 goto vectorglare3
if %ERRORLEVEL% == 7 goto vectorglare4
if %ERRORLEVEL% == 8 goto vectorglare5

:vectorglare0
set SeasonID="Y7S2"
set depotregion="1459563372969474412"
set depotrus="4315406868076491395"
set depotmain="4551281097381151823"
goto download

:vectorglare1
set SeasonID="Y7S2v0_1"
set depotregion="1459563372969474412"
set depotrus="4315406868076491395"
set depotmain="6933828118264794638"
goto download

:vectorglare2
set SeasonID="Y7S2v1"
set depotregion="7882358573934544027"
set depotrus="4534816805528962229"
set depotmain="6291681544844822550"
goto download

:vectorglare3
set SeasonID="Y7S2v2"
set depotregion="768289351892348843"
set depotrus="5011496065339905958"
set depotmain="4850930997822081695"
goto download

:vectorglare4
set SeasonID="Y7S2v3"
set depotregion="841487225024176097"
set depotrus="4653408180622432606"
set depotmain="6132039961651867721"
goto download

:vectorglare5
set SeasonID="Y7S2v4"
set depotregion="1363132201391540345"
set depotrus="4500117484519539380"
set depotmain="133280937611742404"
goto download

:brutalswarm
MODE 69,16
Title Selecting Brutal Swarm Version...
echo ---------------------------------------------------------------------
echo ^| Click on the Version of Brutal Swarm (Y7S3) you want to download. ^|
echo ---------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y7S3  | 2022/09/06" "  Y7S3.1 | 2022/09/20" "  Y7S3.2 | 2022/10/05" "  Y7S3.3 | 2022/10/12" "  Y7S3.4 | 2022/10/18" "  Y7S3.5 | 2022/11/08" "  Y7S3.6 | 2022/11/16"
set SeasonName="BrutalSwarm"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto brutalswarm
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto brutalswarm0
if %ERRORLEVEL% == 4 goto brutalswarm1
if %ERRORLEVEL% == 5 goto brutalswarm2
if %ERRORLEVEL% == 6 goto brutalswarm3
if %ERRORLEVEL% == 7 goto brutalswarm4
if %ERRORLEVEL% == 8 goto brutalswarm5
if %ERRORLEVEL% == 9 goto brutalswarm6

:brutalswarm0
set SeasonID="Y7S3"
set depotregion="7237312990637311737"
set depotrus="409976093577464915"
set depotmain="2819814171857109524"
goto download

:brutalswarm1
set SeasonID="Y7S3v1"
set depotregion="3851014658147128944"
set depotrus="9054270150869785586"
set depotmain="6933828118264794638"
goto download

:brutalswarm2
set SeasonID="Y7S3v2"
set depotregion="2970669836615472934"
set depotrus="3360321487518267679"
set depotmain="2337940412549540408"
goto download

:brutalswarm3
set SeasonID="Y7S3v3"
set depotregion="8182200355912207096"
set depotrus="564816423757605683"
set depotmain="601848105167344545"
goto download

:brutalswarm4
set SeasonID="Y7S3v4"
set depotregion="2980095381061233054"
set depotrus="3743862260714192780"
set depotmain="1810562607052868964"
goto download

:brutalswarm5
set SeasonID="Y7S3v5"
set depotregion="4437947645277067316"
set depotrus="2285175662180403006"
set depotmain="5335823972771551962"
goto download

:brutalswarm6
set SeasonID="Y7S3v6"
set depotregion="6425223567680952075"
set depotrus="4623590620762156001"
set depotmain="5906302942203575464"
goto download

:solarraid
MODE 67,15
Title Selecting Solar Raid Version...
echo -------------------------------------------------------------------
echo ^| Click on the Version of Solar Raid (Y7S4) you want to download. ^|
echo -------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y7S4   | 2022/12/06" "  Y7S4.0.1 | 2022/12/07" "   Y7S4.1  | 2022/12/13" "   Y7S4.2  | 2023/01/18" "   Y7S4.3  | 2023/01/24" "   Y7S4.4  | 2023/02/07"
set SeasonName="SolarRaid"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto solarraid
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto solarraid0
if %ERRORLEVEL% == 4 goto solarraid1
if %ERRORLEVEL% == 5 goto solarraid2
if %ERRORLEVEL% == 6 goto solarraid3
if %ERRORLEVEL% == 7 goto solarraid4
if %ERRORLEVEL% == 8 goto solarraid5

:solarraid0
set SeasonID="Y7S4"
set depotregion="7230114585543057702"
set depotrus="7521959681577153172"
set depotmain="6951346539339147841"
goto download

:solarraid1
set SeasonID="Y7S4v0_1"
set depotregion="7230114585543057702"
set depotrus="7521959681577153172"
set depotmain="4256285638666187587"
goto download

:solarraid2
set SeasonID="Y7S4v1"
set depotregion="243124852401862802"
set depotrus="3890339845597712254"
set depotmain="7135086280049054195"
goto download

:solarraid3
set SeasonID="Y7S4v2"
set depotregion="1888247323826199507"
set depotrus="8180498488491085046"
set depotmain="2972792585960656670"
goto download

:solarraid4
set SeasonID="Y7S4v3"
set depotregion="476280383248415420"
set depotrus="6520256030383063085"
set depotmain="7908758142082872329"
goto download

:solarraid5
set SeasonID="Y7S4v4"
set depotregion="4466027729495813039"
set depotrus="5107849703917033235"
set depotmain="1819898955518120444"
goto download

:commandingforce
MODE 73,17
Title Selecting Commanding Force Version...
echo -------------------------------------------------------------------------
echo ^| Click on the Version of Commanding Force (Y8S1) you want to download. ^|
echo -------------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y8S1   | 2023/03/07" "   Y8S1.1  | 2023/03/14" "   Y8S1.2  | 2023/03/21" "   Y8S1.3  | 2023/03/30" "  Y8S1.3.1 | 2023/04/05" "   Y8S1.4  | 2023/04/11" "   Y8S1.5  | 2023/04/27" "   Y8S1.6  | 2023/05/09"
set SeasonName="CommandingForce"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto commandingforce
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto commandingforce0
if %ERRORLEVEL% == 4 goto commandingforce1
if %ERRORLEVEL% == 5 goto commandingforce2
if %ERRORLEVEL% == 6 goto commandingforce3
if %ERRORLEVEL% == 7 goto commandingforce4
if %ERRORLEVEL% == 8 goto commandingforce5
if %ERRORLEVEL% == 8 goto commandingforce6
if %ERRORLEVEL% == 8 goto commandingforce7

:commandingforce0
set SeasonID="Y8S1"
set depotregion="9170399840050601760"
set depotrus="2746788015456800690"
set depotmain="2374032323426576007"
goto download

:commandingforce1
set SeasonID="Y8S1v1"
set depotregion="4736447165561380682"
set depotrus="7521959681577153172"
set depotmain="4256285638666187587"
goto download

:commandingforce2
set SeasonID="Y8S1v2"
set depotregion="5293927270946595336"
set depotrus="7868212818278896395"
set depotmain="5407300833322336728"
goto download

:commandingforce3
set SeasonID="Y8S1v3"
set depotregion="7239278944344235"
set depotrus="8334595444615090964"
set depotmain="924059071912767915"
goto download

:commandingforce4
set SeasonID="Y8S1v3_1"
set depotregion="6759032199089821465"
set depotrus="8334595444615090964"
set depotmain="5829708722075296536"
goto download

:commandingforce5
set SeasonID="Y8S1v4"
set depotregion="6246696696733964703"
set depotrus="5325173717527482405"
set depotmain="5905901478000134596"
goto download

:commandingforce6
set SeasonID="Y8S1v5"
set depotregion="3592409553401515510"
set depotrus="2933538572843857684"
set depotmain="5439734544745338815"
goto download

:commandingforce7
set SeasonID="Y8S1v6"
set depotregion="3275824905781062648"
set depotrus="6130917224459224462"
set depotmain="5863062164463920572"
goto download


:dreadfactor
MODE 69,15
Title Selecting Dread Factor Version...
echo ---------------------------------------------------------------------
echo ^| Click on the Version of Dread Factor (Y8S2) you want to download. ^|
echo ---------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y8S2  | 2023/05/30" "  Y8S2.1 | 2023/06/13" "  Y8S2.2 | 2023/06/27" "  Y8S2.3 | 2023/07/11" "  Y8S2.4 | 2023/07/20" "  Y8S2.5 | 2023/08/03"
set SeasonName="DreadFactor"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto dreadfactor
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto dreadfactor0
if %ERRORLEVEL% == 4 goto dreadfactor1
if %ERRORLEVEL% == 5 goto dreadfactor2
if %ERRORLEVEL% == 6 goto dreadfactor3
if %ERRORLEVEL% == 7 goto dreadfactor4
if %ERRORLEVEL% == 8 goto dreadfactor5

:dreadfactor0
set SeasonID="Y8S2"
set depotregion="843782376305692682"
set depotrus="2319443315999860736"
set depotmain="6906800513071723222"
goto download

:dreadfactor1
set SeasonID="Y8S2v1"
set depotregion="3050554908913191669"
set depotrus="4293396692730784956"
set depotmain="1575870740329742681"
goto download

:dreadfactor2
set SeasonID="Y8S2v2"
set depotregion="3558972082517836520"
set depotrus="4977529482832011357"
set depotmain="6182924905506801391"
goto download

:dreadfactor3
set SeasonID="Y8S2v3"
set depotregion="4313757428310343948"
set depotrus="8084684403658838038"
set depotmain="5581702357198571389"
goto download

:dreadfactor4
set SeasonID="Y8S2v4"
set depotregion="8859316100779131995"
set depotrus="1242978990616012443"
set depotmain="4888808183249472475"
goto download

:dreadfactor5
set SeasonID="Y8S2v5"
set depotregion="949667897851762910"
set depotrus="4023905693858871729"
set depotmain="7569655503672867080"
goto download

:heavymettle
MODE 69,15
Title Selecting Heavy Mettle Version...
echo ---------------------------------------------------------------------
echo ^| Click on the Version of Heavy Mettle (Y8S3) you want to download. ^|
echo ---------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y8S3  | 2023/08/29" "  Y8S3.1 | 2023/09/12" "  Y8S3.2 | 2023/09/26" "  Y8S3.3 | 2023/10/10" "  Y8S3.4 | 2023/11/02" "  Y8S3.5 | 2023/11/14"
set SeasonName="HeavyMettle"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto heavymettle
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto heavymettle0
if %ERRORLEVEL% == 4 goto heavymettle1
if %ERRORLEVEL% == 5 goto heavymettle2
if %ERRORLEVEL% == 6 goto heavymettle3
if %ERRORLEVEL% == 7 goto heavymettle4
if %ERRORLEVEL% == 8 goto heavymettle5

:heavymettle0
set SeasonID="Y8S3"
set depotregion="7845616952346988253"
set depotrus="763230360674893467"
set depotmain="7492642056657673136"
goto download

:heavymettle1
set SeasonID="Y8S3v1"
set depotregion="6457147965398437152"
set depotrus="2941701039157774660"
set depotmain="880129301833738029"
goto download

:heavymettle2
set SeasonID="Y8S3v2"
set depotregion="3646961589063744028"
set depotrus="744495362009733283"
set depotmain="4687217675313436213"
goto download

:heavymettle3
set SeasonID="Y8S3v3"
set depotregion="2068160275622519212"
set depotrus="2579928666708989224"
set depotmain="3005637025719884427"
goto download

:heavymettle4
set SeasonID="Y8S3v4"
set depotregion="259882257527286012"
set depotrus="1495427291215366492"
set depotmain="7834975795756188323"
goto download

:heavymettle5
set SeasonID="Y8S3v5"
set depotregion="1631698455772913813"
set depotrus="7022135161141853550"
set depotmain="8261172581406753170"
goto download

:deepfreeze
MODE 68,14
Title Selecting Deep Freeze Version...
echo --------------------------------------------------------------------
echo ^| Click on the Version of Deep Freeze (Y8S4) you want to download. ^|
echo --------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y8S4  | 2023/12/06" "  Y8S4.1 | 2023/12/12" "  Y8S4.2 | 2023/12/14" "  Y8S4.3 | 2024/01/23" "  Y8S4.4 | 2024/02/15"
set SeasonName="DeepFreeze"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto deepfreeze
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto deepfreeze0
if %ERRORLEVEL% == 4 goto deepfreeze1
if %ERRORLEVEL% == 5 goto deepfreeze2
if %ERRORLEVEL% == 6 goto deepfreeze3
if %ERRORLEVEL% == 7 goto deepfreeze4

:deepfreeze0
set SeasonID="Y8S4"
set depotregion="2093813998586373710"
set depotrus="4119310491656912980"
set depotmain="4120012700594876112"
goto download

:deepfreeze1
set SeasonID="Y8S4v1"
set depotregion="5568275881151188827"
set depotrus="1395063113531833284"
set depotmain="2864858815171190508"
goto download

:deepfreeze2
set SeasonID="Y8S4v2"
set depotregion="7221654846420332492"
set depotrus="5249804607170034320"
set depotmain="7924714545170578579"
goto download

:deepfreeze3
set SeasonID="Y8S4v3"
set depotregion="4126275877143756858"
set depotrus="7437817957854286612"
set depotmain="4574383586964654724"
goto download

:deepfreeze4
set SeasonID="Y8S4v4"
set depotregion="7646647065987620875"
set depotrus="8339919149418587132"
set depotmain="4957295777170965935"
goto download

:deadlyomen
MODE 68,16
Title Selecting Deadly Omen Version...
echo --------------------------------------------------------------------
echo ^| Click on the Version of Deadly Omen (Y9S1) you want to download. ^|
echo --------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "    Y9S1   | 2024/03/12" "   Y9S1.1  | 2024/03/26" "   Y9S1.2  | 2024/04/03" "   Y9S1.3  | 2024/04/09" "   Y9S1.4  | 2024/05/02" "  Y9S1.4.1 | 2024/05/09" "   Y9S1.5  | 2024/05/16"
set SeasonName="DeadlyOmen"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto deadlyomen
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto deadlyomen0
if %ERRORLEVEL% == 4 goto deadlyomen1
if %ERRORLEVEL% == 5 goto deadlyomen2
if %ERRORLEVEL% == 6 goto deadlyomen3
if %ERRORLEVEL% == 7 goto deadlyomen4
if %ERRORLEVEL% == 8 goto deadlyomen5
if %ERRORLEVEL% == 9 goto deadlyomen6

:deadlyomen0
set SeasonID="Y9S1"
set depotregion="8365108768748296788"
set depotrus="1297387496617362606"
set depotmain="6892428288436295143"
goto download

:deadlyomen1
set SeasonID="Y9S1v1"
set depotregion="3137542268473557442"
set depotrus="6048047216750850402"
set depotmain="2949326465428447508"
goto download

:deadlyomen2
set SeasonID="Y9S1v2"
set depotregion="442246768829543819"
set depotrus="3544056315428387054"
set depotmain="4837329640546956494"
goto download

:deadlyomen3
set SeasonID="Y9S1v3"
set depotregion="1959067516419454682"
set depotrus="1619182300337183882"
set depotmain="1140469899661941149"
goto download

:deadlyomen4
set SeasonID="Y9S1v4"
set depotregion="3387963394541885910"
set depotrus="7655767711761693893"
set depotmain="6601110544975304146"
goto download

:deadlyomen5
set SeasonID="Y9S1v4_1"
set depotregion="3387963394541885910"
set depotrus="7655767711761693893"
set depotmain="4946940118375225438"
goto download

:deadlyomen6
set SeasonID="Y9S1v5"
set depotregion="8794878936242596014"
set depotrus="7784960559590205809"
set depotmain="5303531353161590457"
goto download

:newblood
MODE 66,17
Title Selecting New Blood Version...
echo ------------------------------------------------------------------
echo ^| Click on the Version of New Blood (Y9S2) you want to download. ^|
echo ------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y9S2  | 2024/06/11" "  Y9S2.1 | 2024/06/20" "  Y9S2.2 | 2024/06/27" "  Y9S2.3 | 2024/07/09" "  Y9S2.4 | 2024/07/11" "  Y9S2.5 | 2024/07/18" "  Y9S2.6 | 2024/07/25" "  Y9S2.7 | 2024/08/08"
set SeasonName="NewBlood"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto newblood
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto newblood0
if %ERRORLEVEL% == 4 goto newblood1
if %ERRORLEVEL% == 5 goto newblood2
if %ERRORLEVEL% == 6 goto newblood3
if %ERRORLEVEL% == 7 goto newblood4
if %ERRORLEVEL% == 8 goto newblood5
if %ERRORLEVEL% == 9 goto newblood6
if %ERRORLEVEL% == 10 goto newblood7

:newblood0
set SeasonID="Y9S2"
set depotregion="6874184890918352263"
set depotrus="3648252944070415883"
set depotmain="2171250367116101899"
goto download

:newblood1
set SeasonID="Y9S2v1"
set depotregion="8949928956457266431"
set depotrus="4578762644044750845"
set depotmain="7821036241692084810"
goto download

:newblood2
set SeasonID="Y9S2v2"
set depotregion="903528572328769603"
set depotrus="1522866985903551211"
set depotmain="7665238273042555028"
goto download

:newblood3
set SeasonID="Y9S2v3"
set depotregion="6991154312394124173"
set depotrus="6028698194279798157"
set depotmain="2706351920608738000"
goto download

:newblood4
set SeasonID="Y9S2v4"
set depotregion="2412729856404400875"
set depotrus="724759938396479564"
set depotmain="8555409684644170228"
goto download

:newblood5
set SeasonID="Y9S2v5"
set depotregion="7269451890189868134"
set depotrus="1144851955999569822"
set depotmain="6591359844945053366"
goto download

:newblood6
set SeasonID="Y9S2v6"
set depotregion="8160812118480939262"
set depotrus="2207285510020603118"
set depotmain="3303120421075579181"
goto download

:newblood7
set SeasonID="Y9S2v7"
set depotregion="7689842505177747464"
set depotrus="3111982345570843978"
set depotmain="2675939506491900002"
goto download

:twinshells
MODE 68,16
Title Selecting Twin Shells Version...
echo --------------------------------------------------------------------
echo ^| Click on the Version of Twin Shells (Y9S3) you want to download. ^|
echo --------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y9S3  | 2024/09/10" "  Y9S3.1 | 2024/09/17" "  Y9S3.2 | 2024/09/24" "  Y9S3.3 | 2024/10/08" "  Y9S3.4 | 2024/10/22" "  Y9S3.5 | 2024/10/29" "  Y9S3.6 | 2024/11/07"
set SeasonName="TwinShells"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto twinshells
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto twinshells0
if %ERRORLEVEL% == 4 goto twinshells1
if %ERRORLEVEL% == 5 goto twinshells2
if %ERRORLEVEL% == 6 goto twinshells3
if %ERRORLEVEL% == 7 goto twinshells4
if %ERRORLEVEL% == 8 goto twinshells5
if %ERRORLEVEL% == 9 goto twinshells6

:twinshells0
set SeasonID="Y9S3"
set depotregion="2624390684942642488"
set depotrus="2516062419656754967"
set depotmain="2158552647424644920"
goto download

:twinshells1
set SeasonID="Y9S3v1"
set depotregion="6011190649112101649"
set depotrus="7402403618782963630"
set depotmain="3788743983128078934"
goto download

:twinshells2
set SeasonID="Y9S3v2"
set depotregion="3302983497400042777"
set depotrus="5034970110211942864"
set depotmain="3383016205961109901"
goto download

:twinshells3
set SeasonID="Y9S3v3"
set depotregion="5816726871362159063"
set depotrus="7772727680631325965"
set depotmain="7742730770579262328"
goto download

:twinshells4
set SeasonID="Y9S3v4"
set depotregion="8926827989940409373"
set depotrus="998027973859501008"
set depotmain="7955634378093246497"
goto download

:twinshells5
set SeasonID="Y9S3v5"
set depotregion="8352794897141392011"
set depotrus="7803807171790398224"
set depotmain="3589224011265405234"
goto download

:twinshells6
set SeasonID="Y9S3v6"
set depotregion="4296569502001540403"
set depotrus="3038245830342960035"
set depotmain="825321500774263546"
goto download

:collisionpoint
MODE 72,15
Title Selecting Collision Point Version...
echo ------------------------------------------------------------------------
echo ^| Click on the Version of Collision Point (Y9S4) you want to download. ^|
echo ------------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y9S4  | 2024/12/03" "  Y9S4.1 | 2024/12/12" "  Y9S4.2 | 2024/12/18" "  Y9S4.3 | 2025/01/21" "  Y9S4.4 | 2025/02/05" "  Y9S4.5 | 2025/02/18"
set SeasonName="CollisionPoint"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto collisionpoint
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto collisionpoint0
if %ERRORLEVEL% == 4 goto collisionpoint1
if %ERRORLEVEL% == 5 goto collisionpoint2
if %ERRORLEVEL% == 6 goto collisionpoint3
if %ERRORLEVEL% == 7 goto collisionpoint4
if %ERRORLEVEL% == 8 goto collisionpoint5

:collisionpoint0
set SeasonID="Y9S4"
set depotregion="8414898648214096265"
set depotrus="441213005374680682"
set depotmain="4931174465904319625"
goto download

:collisionpoint1
set SeasonID="Y9S4v1"
set depotregion="495899793734499198"
set depotrus="7480114091428837596"
set depotmain="7951658600792911707"
goto download

:collisionpoint2
set SeasonID="Y9S4v2"
set depotregion="6840279147368146710"
set depotrus="8231516252971960333"
set depotmain="5696856315741981946"
goto download

:collisionpoint3
set SeasonID="Y9S4v3"
set depotregion="9207916394092784817"
set depotrus="6303744364362141965"
set depotmain="3039751959139581613"
goto download

:collisionpoint4
set SeasonID="Y9S4v4"
set depotregion="7684058120163063592"
set depotrus="3988767596968967716"
set depotmain="2666276619654974788"
goto download


:collisionpoint5
set SeasonID="Y9S4v5"
set depotregion="5125290594808998300"
set depotrus="4991874048978630569"
set depotmain="4642385321366227870"
goto download

:prepphase
MODE 68,15
Title Selecting Prep Phase Version...
echo --------------------------------------------------------------------
echo ^| Click on the Version of Prep Phase (Y10S1) you want to download. ^|
echo --------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Season Menu" "" "   Y10S1  | 2025/03/04" "  Y10S1.1 | 2025/03/24" "  Y10S1.2 | 2025/04/01" "  Y10S1.3 | 2025/04/15" "  Y10S1.4 | 2025/04/16" "  Y10S1.5 | 2025/05/08"
set SeasonName="PrepPhase"
set crack="Y6S4-Y8SX"
echo.
if %ERRORLEVEL% == 1 goto seasonmenu
if %ERRORLEVEL% == 2 goto prepphase
set /p username="Enter Steam Username:"
if %ERRORLEVEL% == 3 goto prepphase0
if %ERRORLEVEL% == 4 goto prepphase1
if %ERRORLEVEL% == 5 goto prepphase2
if %ERRORLEVEL% == 6 goto prepphase3
if %ERRORLEVEL% == 7 goto prepphase4
if %ERRORLEVEL% == 8 goto prepphase5

:prepphase0
set SeasonID="Y10S1"
set depotregion="6764165128845305373"
set depotrus="5834248758473369633"
set depotmain="8542711540144632540"
goto download

:prepphase1
set SeasonID="Y10S1v1"
set depotregion="3395384768729933920"
set depotrus="1989825888079212267"
set depotmain="1124664615834747603"
goto download

:prepphase2
set SeasonID="Y10S1v2"
set depotregion="5364283617704741131"
set depotrus="2261137557446399051"
set depotmain="1501131478465634136"
goto download

:prepphase3
set SeasonID="Y10S1v3"
set depotregion="7768653600209628225"
set depotrus="9202937183148111219"
set depotmain="4314737994484415168"
goto download

:prepphase4
set SeasonID="Y10S1v4"
set depotregion="8382986432868135995"
set depotrus="3364322644809414267"
set depotmain="2619322944995294928"
goto download

:prepphase5
set SeasonID="Y10S1v5"
set depotregion="1638713000513694780"
set depotrus="9055105948811185747"
set depotmain="8316097480525415272"
goto download

:download
MODE 120,50
Title Downloading %SeasonName% (%SeasonID%)...
if %region% == 0 (
dotnet Resources\DepotDownloader.dll -app 359550 -depot 377237 -manifest %depotregion% -username %username% -remember-password -dir "Downloads\\%SeasonID%_%SeasonName%"  -validate -max-servers %maxspeed% -max-downloads %maxspeed%
)
if %region% == 1 (
dotnet Resources\DepotDownloader.dll -app 359550 -depot 377238 -manifest %depotrus% -username %username% -remember-password -dir "Downloads\\%SeasonID%_%SeasonName%"  -validate -max-servers %maxspeed% -max-downloads %maxspeed%
)
dotnet Resources\DepotDownloader.dll -app 359550 -depot 359551 -manifest %depotmain% -username %username% -remember-password -dir "Downloads\\%SeasonID%_%SeasonName%" -validate -max-servers %maxspeed% -max-downloads %maxspeed%
pause
Robocopy "Resources\Plazas\\%crack%" "Downloads\\%SeasonID%_%SeasonName%"
goto downloadcomplete

:downloadcomplete
MODE 70,6
Title Download Complete
cls
echo ----------------------------------------------------------------------
echo ^|                         Download Complete!                         ^|
echo ----------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "                               Continue"
echo.
echo.
if %ERRORLEVEL% == 1 goto mainmenu

:guidefaq
Title Installation Guide and FAQ
cls
MODE 41,10
echo -----------------------------------------
echo ^| Click on what you would like to read. ^|
echo -----------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Main Menu" "" "  Installation Guide" "  FAQ"
if %ERRORLEVEL% == 1 goto mainmenu
if %ERRORLEVEL% == 2 goto guidefaq
if %ERRORLEVEL% == 3 goto guide
if %ERRORLEVEL% == 4 goto faq

:guide
Title Installation Guide
cls
MODE 134,17
echo --------------------------------------------------------------------------------------------------------------------------------------
echo ^| 1) In the main menu of the downloader, select 'Game Downloader' and choose which version you want to download.                     ^|
echo ^|    Enter the username and password for the Steam account you have a copy of Rainbow Six Siege on. The download should start.       ^|
echo ^|   (If you want to download 4K textures or extra languages, follow the same steps,                                                  ^|
echo ^|    and you can enable 4K textures / select different languages in-game).                                                           ^|
echo ^|                                                                                                                                    ^|
echo ^| 2) Once you have that done just launch the game by double-clicking RainbowSix.exe in the 'Downloads' folder where the downloader   ^|
echo ^|    is located. If the RainbowSixGame.exe exist start that ^!                                                                        ^|
echo ^|                                                                                                                                    ^|
echo ^| 3) Please DONT Use this Tool on your OneDrive! You will probably get errors! Also, dont run the tool inside of any ZIP viewer      ^|
echo ^|                                                                                                                                    ^|
echo --------------------------------------------------------------------------------------------------------------------------------------
echo ^| Note : To play with other people, download Radmin Server at https://radmin-vpn.com/ then create or join a private network.         ^|
echo ^| Then create or join a local custom game and wait for other people to join.                                                         ^|
echo --------------------------------------------------------------------------------------------------------------------------------------
echo.
Resources\cmdMenuSel f870 "  <- Back to Guide and FAQ"
if %ERRORLEVEL% == 1 goto guidefaq

:faq
Title FAQ
cls
Mode 137,36
echo -----------------------------------------------------------------------------------------------------------------------------------------
echo ^|   Q: Is it safe to enter my password?                                                                                                 ^|
echo ^| # A: Yes it is. You can view the source code for Depot Downloader here: https://github.com/SteamRE/DepotDownloader/                   ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Why do I get 'Invalid Password' after entering my Steam credentials?                                                             ^|
echo ^| # A: You are supposed to enter your LEGACY Steam username, not your profile name (the username you normally use to login to Steam)    ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Why does it say 'Download Complete' immediately after entering a download option?                                                ^|
echo ^| # A: You need to download .NET Core from the #game-downloads in the Operation Throwback Discord server before you run the downloader  ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Why can't I see my password while I'm typing?                                                                                    ^|
echo ^| # A: Your password is being entered as invisible                                                                                      ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Where can I change my name?                                                                                                      ^|
echo ^| # A: In the Codex.ini file line 28 "UserName=CODEX"                                                                                   ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Why is my game crashing at the start screen?                                                                                     ^|
echo ^| # A: In the Codex.ini file line 20 "GameName=RainbowSixSiege" change it to something else                                             ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Why am I getting "Encountered unexpected error downloading chunk xxxxxxxxxxxx: The operation was canceled." errors?              ^|
echo ^| # A: Getting errors while downloading is normal                                                                                       ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Why am I getting the error 'Missing steam_api64.dll'                                                                             ^|
echo ^| # A: Blacklist the files in your antivirus so the crack files aren't deleted                                                          ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Why does the steam version of the game launch when I try to run RainbowSix.exe?                                                  ^|
echo ^| # A: Same answer as above                                                                                                             ^|
echo ^|                                                                                                                                       ^|
echo ^|   Q: Why is my download stuck at X percent?                                                                                           ^|
echo ^| # A: The last few files in a build are larger than the rest and may take longer to download, please be patient.                       ^|
echo ^|      Best way to tell if it's still working is to check if it's using your network in task manager.                                   ^|
echo -----------------------------------------------------------------------------------------------------------------------------------------
echo                        Any CPlay / UPCR1/2 / Lumaplay error/fail , please contact SlejmUr or other helpers!
echo.
Resources\cmdMenuSel f870 "  <- Back to Guide and FAQ"
if %ERRORLEVEL% == 1 goto guidefaq