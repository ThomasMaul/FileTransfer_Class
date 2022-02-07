//%attributes = {}
#DECLARE($ID : Text; $message : Text; $value : Integer)
// called from cs.FileTransfer if callback is set via .useCallback()

MESSAGE:C88($id+" - "+$message+" - "+String:C10($value))
