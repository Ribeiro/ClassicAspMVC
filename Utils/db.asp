<%
const adCmdText =1
const adCmdStoredProc = 4
const adCmdUnknown = 8

dim oConn

set oConn = Nothing

public function DbOpenConnection()
   if oConn is nothing then
      set oConn = CreateObject("ADODB.Connection")
      oConn.Mode = 3
      oConn.ConnectionString = connectionString
      oConn.Open
   end if
   set DbOpenConnection = oConn
end function

public function DbCloseConnection()
   if not oConn is nothing Then
      oConn.Close
      set oConn = nothing
   End If
   set DbCloseConnection = oConn
end function

public function DbExecute(sql)
   dim oConnection
   set oConnection = DbOpenConnection()
   set DbExecute = oConnection.execute(sql)
end function

Public function DbAddParameters( ByRef objCommand,  values)
	'set objCommand=Server.CreateObject("ADODB.command")

	If Not IsArray( values) Then
	    DbAddParameters = False
		Exit Function
	End If

	if objCommand.Parameters.Count = UBound (values)+1 Then
	    For i=0 to objCommand.Parameters.Count -1
	        'objCommand.Parameters(i) = values(i)
	        objCommand.Parameters(i) = DBSafeValue  (objCommand.Parameters(i), values(i))
	    Next
	    DbAddParameters = True
	Else
	    DbAddParameters = False
		Exit Function
	End If

End Function

Function DBSafeValue(param, value)
    if  NOT TypeName(param) = "Parameter" Then
        Exit Function
    End If

    If IsNothing(value)or (value = "")  Then
        DBSafeValue = null
    else
        select case param.Type
            case 129,130,200,201,202,203:
                if (param.Size<>-1) and (Len(CStr(value))> param.Size) Then
                     Err.Raise 8, "db utilites: DBSafeAssign ", "string is too long(" & value & ")"
                End If
                DBSafeValue = CStr(value)
            case 72:
                DBSafeValue = CStr(value)
            case  7,135:
                DBSafeValue = CDate(value)
            case 20,3,131,2,17 :
                DBSafeValue = CLng(value)
            case 4,5,14,6 :
                DBSafeValue = CDbl(value)
            case 11:
                DBSafeValue = CBool(value)
            case else:
              Err.Raise 8, "db utilites: DBSafeAssign ", "unsupported type(" & param.Type & ") of database field"
        End select
    End If

End Function

%>