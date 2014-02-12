<!--#include file="utils/utils.asp" -->
<!--#include file="models/models.asp" -->
<!--#include file="controllers/controllers.asp" -->
<%
Const defaultController = "Home"
Const defaultAction = "Index"


Function ContentPlaceHolder()
    If not Route () then
        result = RouteDebug ()
    End If
End Function

Function Route ()

    Dim controller, action , vars , arrResults ,arrTest
    controller  = Trim (CStr(QueryString("controller")))
    action      = actionClean (Trim (CStr(QueryString("action"))))
    set vars        = CollectVariables()
    Route = False
    'Response.Write Request.QueryString
    If InStr(Request.QueryString,"404;") And RegTest(Request.QueryString, "\/([^/]+)\/([^?/]+)(?:\?.+)?$") Then ' 404获取 controller 和 action
        Set arrResults = RegMatch(Request.QueryString, "\/([^/]+)\/([^?/]+)(?:\?.+)?$")
        'In your pattern the answer is the first group, so all you need is'
        For each result in arrResults
            controller = result.Submatches(0)
            action = result.Submatches(1)
        Next
    End If


    If IsEmpty(controller) or IsNull(controller) or (controller="") then
        controller = defaultController
    End If

    If IsEmpty(action) or IsNull(action) or (action="") then
        action = defaultAction
    End If

    Dim controllerName
    controllerName = controller + "Controller"
    if Not (Controllers.Exists(controllerName)) Then
        Response.Clear
        Response.Status="401 Unauthorized"
        Response.Write(response.Status)
        Response.End
    End if

    Dim controllerInstance

    Set controllerInstance = Eval ( " new " +  controllerName)
    Dim actionCallString

    If (Instr(1,action,"Post",1)>0) then
        actionCallString = " controllerInstance." + action + "(Request.Form)"
    ElseIf Not (IsNothing(vars)) then
        actionCallString = " controllerInstance." + action + "(vars)"
    Else
        actionCallString = " controllerInstance." + action + "()"
    End If
    'Response.Write actionCallString
    Eval (actionCallString)
    Route = true
End Function

Function RouteDebug ()
    Dim controller, action , vars
    controller  = QueryString("controller")
    action      = QueryString("action")

    dim key, keyValue
    for each key in Request.Querystring
        keyValue = Request.Querystring(key)
        'ignore service keys
        if InStr(1,"controller, action, partial",key,1)=0 Then
            Response.Write( key + " = " + keyValue )
        End If
    next
end function

Function CollectVariables
    dim key, keyValue
    Set results = QuerystringAll()
    'Response.Write results.Count
    if results.Count=0 Then
        Set CollectVariables = Nothing
    else
        Set CollectVariables = results
    End If
End Function

Function actionClean(strtoclean)
    Dim objRegExp, outputStr
    Set objRegExp = New RegExp
    outputStr = strtoclean
    objRegExp.IgnoreCase = True
    objRegExp.Global = True
    objRegExp.Pattern = "\W"
    outputStr = objRegExp.Replace(outputStr, "")
    actionClean = outputStr
End Function

    partial     = QueryString("partial")

    If Not(IsEmpty(partial) or IsNull(partial))  Then
        If not Route () then
            result = RouteDebug ()
        End If
    else
        %> <!--#include file="views/shared/Site.htmltemplate" --> <%
    End If

 %>
