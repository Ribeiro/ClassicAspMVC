<%

class UserController
Dim Model
Dim ViewData
Dim Log

private sub Class_Initialize()
    Set ViewData = Server.CreateObject("Scripting.Dictionary")
    Set Log = new logger
end sub

private sub Class_Terminate()
    Set Log = nothing
end sub

public Sub List()
    Dim u
    set u = new UserHelper
    set Model = u.SelectAll
    %>
<!--#include file="../views/User/List.asp" -->
<%
End Sub

public Sub Create()
    Log.log("[ClassicAspMvc]")
    set Model = new User
    
    %>
<!--#include file="../views/User/Create.asp" -->
<%
End Sub

public Sub CreatePost(args)
    Dim obj, objh
    set objh = new UserHelper
    set obj = new User
          obj.FirstName = args("FirstName")

          obj.LastName = args("LastName")

          obj.UserName = args("UserName")

          obj.ProjectID = args("ProjectID")

    'form values should be cleaned from injections
    'checkboxes shoud use the syntax: obj.booleanProperty = (args("checkboxname") = "on")
    result = objh.Insert(obj)
    Call Redirect("User","List","")
    
End Sub

public Sub Edit(vars)

    Dim u
    set u = new UserHelper
    set Model = u.SelectById(vars("id"))

    %>
<!--#include file="../views/User/Edit.asp" -->
<%
End Sub

public Sub EditPost(args)
    Dim obj, objh
    set objh = new UserHelper
    set obj = objh.SelectById(args("id"))

          obj.FirstName = args("FirstName")

          obj.LastName = args("LastName")

          obj.UserName = args("UserName")

          obj.ProjectID = args("ProjectID")

    'form values should be cleaned from injections
    'checkboxes shoud use the syntax: obj.booleanProperty = (args("checkboxname") = "on")
    objh.Update(obj)
    Call Redirect("User","List","")
    
End Sub

public Sub Delete(vars)
    Dim u
    set u = new UserHelper
    set Model = u.SelectById(vars("id"))
    %>
<!--#include file="../views/User/Delete.asp" -->
<%
End Sub

public Sub DeletePost(args)
    Dim res, objh
    set objh = new UserHelper
    res = objh.Delete(args("id"))
    if  res then
      
      Call Redirect("User","List","")
    else
      
      Call Redirect("User","Delete","id="&CStr(args("id")))
    end if
End Sub

public Sub Details(vars)
    Dim u
    set u = new UserHelper
    set Model = u.SelectById(vars("id"))

    %>
<!--#include file="../views/User/Details.asp" -->
<%
End Sub

End Class

%>