 #include <FileConstants.au3>
#include <MsgBoxConstants.au3>

;Local $LogPath = "C:\Users\d2mainserver\Desktop\d2bot-with-kolbot-Temp\d2bot-with-kolbot-Temp\d2bs\kolbot\logs\webserver"
;Local $WebPath = "\\MAINSHARE\d2\WebServer"


Local Const $sSource1 = "C:\Users\default.default-PC\Desktop\d2\nmchantbkup\d2bot-with-kolbot-master\d2bot-with-kolbot-master\d2bs\kolbot\logs\webserver\nmcscount.txt", _
            $sDestination1 = "\\MAINSHARE\d2\WebServer\nmcscount.txt"
Local Const $sSource2 = "C:\Users\default.default-PC\Desktop\d2\nmchantbkup\d2bot-with-kolbot-master\d2bot-with-kolbot-master\d2bs\kolbot\logs\webserver\NMcsPlayers.txt", _
            $sDestination2 = "\\MAINSHARE\d2\WebServer\nmcsPlayers.txt"
Local Const $sSource3 = "C:\Users\default.default-PC\Desktop\d2\nmchantbkup\d2bot-with-kolbot-master\d2bot-with-kolbot-master\d2bs\kolbot\logs\webserver\nmcsgame.txt", _
            $sDestination3 = "\\MAINSHARE\d2\WebServer\nmcsgame.txt"
Local Const $sSource4 = "C:\Users\default.default-PC\Desktop\d2\nmchantbkup\d2bot-with-kolbot-master\d2bot-with-kolbot-master\d2bs\kolbot\logs\webserver\nmcsstate.txt", _
            $sDestination4 = "\\MAINSHARE\d2\WebServer\nmcsstate.txt"



while 1
FileMove($sSource1, $sDestination1, $FC_OVERWRITE)
 Sleep(500)
FileMove($sSource2, $sDestination2, $FC_OVERWRITE)
 Sleep(500)
FileMove($sSource3, $sDestination3, $FC_OVERWRITE)
 Sleep(500)
FileMove($sSource4, $sDestination4, $FC_OVERWRITE)
 Sleep(500)

 WEnd
