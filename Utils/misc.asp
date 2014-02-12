<%

Public Function iif(psdStr, trueStr, falseStr)
  if psdStr then
    iif = trueStr
  else

    iif = falseStr
  end if
End Function

Public Function if_then_else(psdStr, trueStr, falseStr)
	if_then_else = iif(psdStr, trueStr, falseStr)
End Function

Public Function IsNothing(var)
   if(IsObject(var)) then
      IsNothing = (var is nothing) or IsEmpty(var) or IsNull(var)
   else
      IsNothing = IsEmpty(var) or IsNull(var)
   end if
End Function

Public Function StringFormat(ByVal SourceString , Arguments() )

   Dim objRegEx 'As RegExp  ' regular expression object
   Dim objMatch 'As Match   ' regular expression match object
   Dim strReturn 'As String ' the string that will be returned

   Set objRegEx = New RegExp
   objRegEx.Global = True
   objRegEx.Pattern = "(\{)(\d)(\})"

   strReturn = SourceString
   For Each objMatch In objRegEx.Execute(SourceString)
      strReturn = Replace(strReturn, objMatch.Value, Arguments(CInt(objMatch.SubMatches(1))))
   Next

   StringFormat = strReturn

End Function

 Function PrepareVariables(args())

	dim keyPairs, keyPair, key, keyValue

	Set results = Server.CreateObject("Scripting.Dictionary")

   if not IsArray(args) then
	  args = Split(args, ",")
   end if

	for each keyPair in args
		keyPairs = Split(keyPair,"=")
		if UBound(keyPairs) = 1 then
			key = Trim(keyPairs(0))
			keyValue = Trim(keyPairs(1))
			if InStr(1,"controller, action, partial",key,1)=0 Then
				results.Add key,keyValue

			End If
		End If
	next
	if results.Count=0 Then
		Set PrepareVariables = Nothing
	else

		Set PrepareVariables = results
	End If
End Function

Function CreateGUID
  Dim TypeLib
  Set TypeLib = CreateObject("Scriptlet.TypeLib")
  CreateGUID = Mid(TypeLib.Guid, 2, 36)
  Set TypeLib = Nothing
End Function

Const blackPattern = "(?:\'|is\s+null|--|=|%|values|where|count|\sand\s|\sor\s|;|\slike\s|,|\/\*|\*\/|@@|\s@|\schar|nchar|varchar|nvarchar|alter|begin|cast|create\s|cursor|declare|database|delete|drop|end|exec|execute|fetch|from|insert|kill|open|select|sys|sysobjects|syscolumns|table|update|values|xp_cmdshell)"

Function detectInjection(strtoclean)
  Set absoluteNoValidator = New RegExp
  absoluteNoValidator.Pattern = blackPattern
  absoluteNoValidator.IgnoreCase = True
  If absoluteNoValidator.Test(strtoclean) Then
      detectInjection = True
      Exit Function
  End If
  detectInjection = False
End Function

Function RegTest(ByVal s, ByVal p)
  If (IsNull(s) or s="") Then RegTest = False : Exit Function
  Dim regEx
  Set regEx = New Regexp
  regEx.Global = True
  regEx.IgnoreCase = True
  regEx.Pattern = p
  RegTest= regEx.Test(s)
  Set regEx = Nothing
End Function

Function RegMatch(strTarget,strPattern)
  Set regEx = New RegExp
  regEx.Pattern = strPattern
  regEx.Global = true
  Set RegMatch = regEx.Execute(strTarget)
  Set regEx = Nothing
End Function

Function RegMatchOne(strTarget,strPattern)
  Set matchs = RegMatch(strTarget,strPattern)
  For Each m In matchs
    RegMatchOne = m
    Exit For
  Next
End Function

Function CreateUrl(controller,action,params)
  if (params<>"") and Left(params,1)<>"?" then
    params = "?"& params
  End if
  CreateUrl = "/"&controller&"/"&action&params
End Function

Function Redirect(controller,action,params)
  Response.Redirect(CreateUrl(controller,action,params))
End Function

Function Querystring(str)
  Querystring = QuerystringAll().Item(LCase(str))
End Function


Function QuerystringAll()
  Dim i,results,arrResults,ma,a
  Set results = Server.CreateObject("Scripting.Dictionary")
  i = 0
  for each key in Request.Querystring
      keyValue = Request.Querystring(key)
      If i = 0 Then
        If RegTest(key,"[\?&]([^=]+)$") Then
          set arrResults = RegMatch(key,"[\?&]([^=]+)$")
          For each result in arrResults
            key = result.Submatches(0)
          Next
          results.Add LCase(key),keyValue
        End If
      Else
        results.Add LCase(key),keyValue
      End If
       i = i + 1
  next
  Set QuerystringAll = results
End Function
%>