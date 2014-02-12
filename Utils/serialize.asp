<%

Public Function serialize (obj)
	Dim xmlStr

	If IsNothing(obj) then
		serialize = ""
		Exit Function
	End If

	If IsObject(obj) then
		If (TypeName(obj) = "Dictionary" ) then
			xmlStr = xmlStr & "<Dictionary>" & VbCrLf
			For Each key in obj.Keys
				xmlStr = xmlStr & "<Item>" & VbCrLf
				xmlStr = xmlStr & "<Key>" & key & "</Key>" & VbCrLf
				xmlStr = xmlStr & "<Value>" & serialize (obj.Item(key)) & "</Value>" & VbCrLf
				xmlStr = xmlStr & "</Item>" & VbCrLf
			Next
			xmlStr = xmlStr & "</Dictionary>" & VbCrLf
		ElseIf  (TypeName(obj) = "IRequestDictionary") then
			xmlStr = xmlStr & "<Dictionary>" & VbCrLf
			For Each key in obj
				xmlStr = xmlStr & "<Item>" & VbCrLf
				xmlStr = xmlStr & "<Key>" & key & "</Key>" & VbCrLf
				xmlStr = xmlStr & "<Value>" & serialize (obj(key)) & "</Value>" & VbCrLf
				xmlStr = xmlStr & "</Item>" & VbCrLf
			Next
			xmlStr = xmlStr & "</Dictionary>" & VbCrLf
		ElseIf (TypeName(obj) = "IStringList")or (TypeName(obj) = "ArrayList")  Then
			If obj.Count = 1 Then 'convert one-item lists to simple values
				xmlStr = serialize (obj(1))
			Else
				xmlStr = xmlStr & "<Array>" & VbCrLf
					For Each listItem in obj
						xmlStr = xmlStr & "<Item>" & serialize (listItem) & "</Item>" & VbCrLf
					Next
				xmlStr = xmlStr & "</Array>" & VbCrLf
			End If
		Else

			xmlStr = "<" & TypeName(obj) & ">" & VbCrLf
			'For each property in metadata (obj)
			For each property in metadata(obj)
				If LCase(property)<>"metadata" then
					xmlStr = xmlStr & vbTab & "<" & property & ">" &  Eval ("obj." & property) & "</" & property & ">" & VbCrLf
				End If
			Next

			xmlStr = xmlStr & "</" & TypeName(obj) & ">"
		End If
	ElseIf IsArray(obj) Then

			If Ubound(obj) = 0 Then 'convert one-item array to simple values
				xmlStr = serialize (obj(0))
			Else
				xmlStr = xmlStr & "<Array>" & VbCrLf
					For Each arrayItem in obj
						xmlStr = xmlStr & "<Item>" & serialize (arrayItem) & "</Item>" & VbCrLf
					Next
				xmlStr = xmlStr & "</Array>" & VbCrLf
			End If
	Else 'it is not an Object, just a simple type
		xmlStr = CStr(obj)
	End If

		serialize = xmlStr

End Function

Public Function deserialize (xmlStr)
	if IsNothing(xmlStr) then
		Set deserialize = Nothing
		Exit Function
	End If

	Dim obj, xmlDoc, elRoot, elChild, objName
	Set xmlDoc =  CreateObject("Microsoft.XMLDOM")

	xmlDoc.LoadXML(xmlStr)
	Set elRoot = xmlDoc.documentElement
	objName = elRoot.nodeName
	set deserialize = deserializeObject(objName, elRoot.XML)
End Function

Function deserializeObject(objName, xmlStr)
	Dim xmlDoc, Key, Value, ValueEl
	Dim retValue
	Set retValue = Nothing
	Set xmlDoc =  CreateObject("Microsoft.XMLDOM")

	xmlDoc.LoadXML(xmlStr)

	'cast objName as object

	If (objName = "Dictionary") Then
		Set retValue = Server.CreateObject("Scripting.Dictionary")
		set Items = xmlDoc.documentElement.childNodes 'getElementsByTagName("Item")
		For Each Item in Items
			If Item.nodeName = "Item" Then
				Key = Item.getElementsByTagName("Key")(0).nodeTypedValue
				Set ValueEl = Item.getElementsByTagName("Value")(0)
				'NO value in the Value tag
				If ValueEl.childNodes.Length = 0 Then
					Set Value = Nothing
				Else

					'if complex type inside
					If ValueEl.firstChild.childNodes.Length>1 Then
						Set Value = deserialize (ValueEl.firstChild.xml)
					Else

						Value = Item.getElementsByTagName("Value")(0).nodeTypedValue
					End If
				End If
				'retValue.Add Key, Value
				assignValue retValue, Key, Value
			End If
		Next
		Set deserializeObject = retValue
	ElseIf (objName = "Array") Then
		Set retValue = Server.CreateObject("System.Collections.ArrayList")

		Set Items = xmlDoc.documentElement.childNodes 'getElementsByTagName("Item")
			For Each Item in Items
				if Item.childNodes.Length = 0 Then
					Set Value = Nothing
				Else

					'if complex type inside
					If Item.firstChild.childNodes.Length>1 Then
						Set Value = deserialize (Item.firstChild.xml)
					Else

						Value = Item.nodeTypedValue
					End If
				End If
				assignValue retValue, Nothing, Value
			Next
		'TODO code to set values if list
		Set deserializeObject = retValue
	Else
		On Error Resume Next
		Set retValue = Eval( "new " + objName)

		set Items = xmlDoc.documentElement.childNodes
		For Each Item in Items

			'if complex type inside
			If Item.firstChild.childNodes.Length>1 Then
				Set Value = deserialize (ValueEl.firstChild.xml)
			Else
				Value = Item.nodeTypedValue
			End If
			assignValue retValue, Item.NodeName,  Value
		Next
		Set deserializeObject = retValue
	End If
	Set xmlDoc = Nothing
End Function

Sub assignValue( ByRef obj, ByVal propName, ByVal propValue)
	If IsObject(obj) then

		If (TypeName(obj) = "Dictionary" ) then
			obj.Add propName, propValue
		ElseIf (TypeName(obj) = "Array" )or (TypeName(obj) ="ArrayList") then
			obj.Add propValue
		Else
			On Error Resume Next
			if IsNumeric(propValue) Then
				expression = "obj." + propName + "=" + propValue
			Else

				expression = "obj." + propName + "=""" + propValue + """"
			End If
			Execute expression
		End If
	Else
			obj = propValue 'simple variable assignment, ignore the property name
	End If
End Sub

Function metadata(ByRef obj)
    Dim names : names = listPropertyNames(obj)
    names = Left(names, Len(names)-1)

	metadata = Split (names,"|")
End Function

%>

<script language="jscript" runat="server">

// List PropertyNames

function listPropertyNames(Obj) {

 var Names = "";

 for (var I in Obj) { Names +=  I + "|"; }

 return Names;

}

</script>

