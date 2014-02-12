
      <!--#include file="HomeController.asp" -->

        <!--#include file="UserController.asp" -->

        <!--#include file="ProjectController.asp" -->

      <%
      Public Controllers : Set Controllers = Server.CreateObject("Scripting.Dictionary")
        Controllers.Add "HomeController", ""

        Controllers.Add "UserController", ""

        Controllers.Add "ProjectController", ""

      %>

    