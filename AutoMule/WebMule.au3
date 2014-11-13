
#include <GDIPlus.au3>
#include <File.au3>
#include <Array.au3>
#include <FTP.au3>
#include <Date.au3>
#include <FileConstants.au3>


Global $sDir, $hSearch, $sFilename, $sNewestFilename, $sNewestDate, $sDir2

;THE FOLLLOWING ARE THE PATHS USED TO UPLOAD TO FTP
Local Const $sSource1 = (@ScriptDir & "\logs\account.txt") ;File to be uploaded
Local Const $sDestination1 = "account.txt" ;ftp path
Local Const $sSource2 = (@ScriptDir & "\logs\archive.txt") ;File to be uploaded
Local Const $sDestination2 = "archive.txt" ;ftp path
Local Const $sSource3 = (@ScriptDir & "\logs\freetime.txt") ;File to be uploaded
Local Const $sDestination3 = "freetime.txt" ;ftp path
Local Const $sSource4 = (@ScriptDir & "\logs\time.txt") ;File to be uploaded
Local Const $sDestination4 = "time.txt" ;ftp path

;THE FOLLOWING ARE PATHS USED FOR THE AUTOMULE
Local Const $sSource5 = "C:\Users\default.default-PC\Desktop\d2\nmchantbkup\d2bot-with-kolbot-master\d2bot-with-kolbot-master\images\image.png"
Local Const $sDestination5 = "image.png"
$sDir = "C:\Users\default.default-PC\Desktop\d2\nmchantbkup\d2bot-with-kolbot-master\d2bot-with-kolbot-master\images\"
$sDir2 = "C:\Users\default.default-PC\Desktop\d2\nmchantbkup\d2bot-with-kolbot-master\d2bot-with-kolbot-master\images\image.png"
$size = "" ;filesize var
$File1 = "C:\Users\default.default-PC\Desktop\d2\nmchantbkup\d2bot-with-kolbot-master\d2bot-with-kolbot-master\d2bs\kolbot\libs\AutoMule.js" ;automule path

;THE FOLLOWING ARE PATHS TO LOG FILES THAT KEEP CURRENT ACCOUNT, TIME, COUNT ETC..
$File2 = (@ScriptDir &"\logs\log.txt")
$File3 = (@ScriptDir &"\logs\count.txt")
$File4 = (@ScriptDir &"\logs\account.txt")  ;current account file
$File5 = (@ScriptDir &"\logs\archive.txt")  ;main archive file
$File6 = (@ScriptDir &"\logs\freetime.txt") ;file to log time left before post
$fileA = @ScriptDir & "\mule.png"  ;Mule Running not in use


ReadFtpINI() ;READS FTP INI YOU NEED TO EDIT THE CONFIG WITH YOUR FTP INFO


Local $hTimer = TimerInit() ; STARTS INITIAL TIMER


While 1
   Local $rtime = $ptime * 86400000 ;PTIME IS IN THE CONFIG FILE MULTIPLED BY 1 DAY SO IF YOU SET 1 ITS EVERY DAY .5 ITS EVERY 12 HRS 2 ITS 2 DAYS AND SO ON...
   Local $fDiff = TimerDiff($hTimer) ;LOADS TIME NOW INTO VAR
   Local $ctime = $rtime - $fDiff    ;SUBTRACTS TOTAL TIME FROM CURRENT TIME
	  if $fDiff > $rtime Then        ;IF TIMENOW IS GREATER THAN TOTAL TIME POST
		 GetnPost() ;RUNS POSTING FUNCTION
		 ToolTip("posting!!!!",0,0)
		 Sleep(5000)
		 Local $hTimer = TimerInit() ;RESTARTS TIMER
	  Else ;IF THE ABOVE STATEMENT ISNT TRUE THEN WE DO THIS!
		 ToolTip("TIMELEFT: " & _Convert($ctime) & "", 0, 0) ;SHOW TIME LEFT IN TOP LEFT CORNER
		 Local $sFilePath3 = $File6 ;LOADS TIMELEFT FILE
		 Local $hFileOpen3 = FileOpen($sFilePath3, $FO_OVERWRITE)
		 FileWriteLine($hFileOpen3, _Convert($ctime)) ;WRITES TIME LEFT TO THE FILE
		 FileClose($hFileOpen3) ;CLOSES FILE
		 sleep(1000)
		 ToFtp($sSource3,$sDestination3) ;UPLOADS FILE TO FTP.
		 sleep(1000)
	  EndIf
	   sleep(60000)
	   ChkLastImage() ;RUNS CHKLASTIMAGE FUNCTION1!
	   sleep(3000)

WEnd


Func ChkLastImage()
   if FileGetSize($sDir2) == $size Then ;CHECKS FILESIZE OF LAST FILE
	  ToolTip("No New file",0,0)
   Else
	  ToolTip("New file",0,0) ;IF FILE SIZE CHANGED THEN
	  Local $sFilePath6 = $sSource4 ;LOADS FILE
	  Local $hFileOpen6 = FileOpen($sFilePath6, $FO_OVERWRITE) ;OPENS LAST ITEM FOUND TIME FILE
	  FileWriteLine($hFileOpen6, "[" & _now() & "]") ;WRITES CURRENT TIME TO FILE
	  FileClose($hFileOpen3) ;CLOSES FILE
	  ToFtp($sSource4,$sDestination4) ;UPLOADS TIME FILE OT FTP
	  sleep(100)
	  ToFtp($sSource5,$sDestination5) ;UPLOADS IMAGE FILE TO FTP
   EndIf
   
   $size = FileGetSize($sDir2) ;GETS NEW FILESIZE
   If StringRight($sDir, 1) <> "\" Then $sDir &= "\"
	  $hSearch = FileFindFirstFile($sDir & "*.png")
	  If $hSearch = -1 Then
		  ;MsgBox(0, "Error", "No .pdf files were found.")
		  Exit
	  EndIf
   While 1
	   $sFilename = FileFindNextFile($hSearch)
	   If @error Then ExitLoop
	   $sTemp = FileGetTime($sDir & $sFilename, 0, 1)
	   If $sTemp > $sNewestDate Then
		   $sNewestDate = $sTemp
		   $sNewestFilename = $sFilename
	   EndIf
   WEnd
   $sFileOld = ($sDir & $sNewestFilename)
   $sFileRenamed = $sDir2
   FileMove($sFileOld, $sFileRenamed,1)
EndFunc


Func GetnPost()
   $line = FileReadLine($file1,5)
   $string1 = StringInStr($line,'"')+1
   $string2 = StringInStr($line,'",')
   $stringcount = $string2 - $string1
   $string3 = StringMid($line,$string1,$stringcount)
   ToolTip($string3 & "1")
   sleep(5000)
   $tcount = FileReadLine($file3,1)
   Logs("Posting Account :" & $string3 & "1")
   $postmsg1 = (@MON & "/" & @MDAY & "/" & @YEAR & ": Free Account #" & $tcount & " Account Name: " & $string3 & "1")
   $postmsg2 = ("Free Account #" & $tcount)
   $postmsg3 = ("Account Name : " & $string3 & "1")
   $postmsg4 = ("Account Pass : asd1234")
   Sleep(1000)
   Local Const $sFilePath = $File4
   Local $hFileOpen = FileOpen($sFilePath, $FO_OVERWRITE)
   FileWriteLine($hFileOpen, $postmsg2)
   FileWriteLine($hFileOpen, $postmsg3)
   FileWriteLine($hFileOpen, $postmsg4)
   FileClose($hFileOpen)
   Local Const $sFilePath5 = $File5
   Local $hFileOpen5 = FileOpen($sFilePath5, $FO_APPEND)
   FileWriteLine($hFileOpen5, $postmsg1 & @CRLF )
   FileClose($hFileOpen5)
   sleep(1000)
   ToFtp($sSource1,$sDestination1)
   sleep(1000)
   ToFtp($sSource2,$sDestination2)
   sleep(1000)
   UpdateCount()
   sleep(1000)
   NewMule()
EndFunc

Func UpdateCount()
   $lines = FileReadLine($file3,1)
   $newlines = $lines + 1
   ToolTip($newlines)
   Sleep(1000)
   $TextFileName = $File3
   $FindText = $lines
   $ReplaceText = $newlines
   $FileContents = FileRead($TextFileName)
   $FileContents = StringRegExpReplace($FileContents,$FindText,$ReplaceText, 1)
   $hFile = FileOpen($TextFileName, 2)
   FileWrite($hFile, $FileContents)
   FileClose($hFile)
EndFunc

Func _Convert($ms)
   Local $day, $hour, $min, $sec
   _TicksToTime($ms, $hour, $min, $sec)
   If $hour > 24 Then
       $day = $hour/24
       $hour = Mod($hour, 24)
   EndIf
   Return StringFormat("%02iD/%02iH/%02iM/%02iS", $day, $hour, $min, $sec)
EndFunc

Func NewMule()
Global $aFile
   $line = FileReadLine($file1,5)
   $string1 = StringInStr($line,'"')+1
   $string2 = StringInStr($line,'",')
   $stringcount = $string2 - $string1
   $string3 = StringMid($line,$string1,$stringcount)
   $pwd = ""
   Dim $aSpace[3]
   $digits = 10
   For $i = 1 To $digits
	   $aSpace[0] = Chr(Random(65, 90, 1)) ;A-Z
	   $aSpace[1] = Chr(Random(97, 122, 1)) ;a-z
	   $aSpace[2] = Chr(Random(48, 57, 1)) ;0-9
	   $pwd &= $aSpace[Random(0, 2, 1)]
   Next
   ConsoleWrite("New Account (" & $digits & " digits): " & $pwd & @CRLF)
   Logs("Creatjng Account :" & $pwd & "1")
   $TextFileName = $File1
   $FindText = $string3
   $ReplaceText = $pwd
   $FileContents = FileRead($TextFileName)
   $FileContents = StringRegExpReplace($FileContents,$FindText,$ReplaceText, 1)
   $hFile = FileOpen($TextFileName, 2)
   FileWrite($hFile, $FileContents)
   FileClose($hFile)
EndFunc


Func CloseAll()
   WinActivate("D2Bot #")
   sleep(3000)
   MouseMove(555,384)
   MouseClick("left",555,384)
   sleep(100)
   Send("{SHIFT DOWN}")
   SEND("{DOWN}")
   SLEEP(100)
   SEND("{DOWN}")
   SLEEP(100)
   SEND("{DOWN}")
   SLEEP(100)
   Send("{SHIFT UP}")
   SLEEP(100)
   MouseClick("Left",521,341)
   sleep(1000)
EndFunc

Func StartAll()
   WinActivate("D2Bot #")
   sleep(3000)
   MouseMove(555,384)
   MouseClick("left",555,384)
   sleep(100)
   Send("{SHIFT DOWN}")
   SEND("{DOWN}")
   SLEEP(100)
   SEND("{DOWN}")
   SLEEP(100)
   SEND("{DOWN}")
   SLEEP(100)
   Send("{SHIFT UP}")
   SLEEP(100)
   MouseClick("Left",496,337)
   sleep(1000)
EndFunc

Func Logs($dat)
   Local $hFileOpen = FileOpen($File2, $FO_APPEND)
   FileWriteLine($hFileOpen, @MON & "/" & @MDAY & "/" & @YEAR & ": " & $dat & @CRLF)
   FileClose($hFileOpen)
EndFunc


Func ToFtp($source,$destination)
   $Open = _FTPOpen('MyFTP Control')
   $Conn = _FTPConnect($Open, $server, $username, $pass)
   $Ftpp = _FtpPutFile($Conn,$source , $destination)
   $Ftpc = _FTPClose($Open)
EndFunc

Func ReadFtpINI()
   Global $server = IniRead(@ScriptDir & "\Config.ini", "FTP", "Server", "Default Value") ;FTP SERVER
   Global $username = IniRead(@ScriptDir & "\Config.ini", "FTP", "UserName", "Default Value") ;FTP USERNAME
   Global $pass = IniRead(@ScriptDir & "\Config.ini", "FTP", "Password", "Default Value")     ;FTP PASS
   Global $ptime = IniRead(@ScriptDir & "\Config.ini", "GENERAL", "PostTime", "Default Value") ;post evert
EndFunc






























