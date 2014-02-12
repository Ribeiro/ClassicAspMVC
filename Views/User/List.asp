List Users
<%=Html.ActionLink("Create new User", "User", "Create" , "") %>

<table>
	<tr>

		<td>FirstName</td>

		<td>LastName</td>

		<td>UserName</td>

		<td>ProjectID</td>

		<td></td>
	</tr>

	<%
    if  IsNothing(Model) then
        %>
	<tr>
		<td colspan="4">No records</td>
	</tr>
	<%
    Else
        Dim obj
        For each obj in Model.Items
        %>

	<tr>

		<td>
			<%=Html.Encode(obj.FirstName) %></td>

		<td>
			<%=Html.Encode(obj.LastName) %></td>

		<td>
			<%=Html.Encode(obj.UserName) %></td>

		<td>
			<%=Html.Encode(obj.ProjectID) %></td>

		<td>
			<%=Html.ActionLink("Edit", "User", "Edit" , "id=" + CStr(obj.Id)) %>
			|
			<%=Html.ActionLink("Delete", "User", "Delete" , "id=" + CStr(obj.Id)) %>
			|
			<%=Html.ActionLink("Details", "User", "Details" , "id=" + CStr(obj.Id)) %></td>
	</tr>
	<%
        Next
     End If
     %>
</table>