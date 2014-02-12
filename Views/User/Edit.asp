Edit User
<form action='<%=Html.Url("User","EditPost","")%>' id="EditPost" method="post">
	<table>
		<tr>
			<td>id</td>
			<td>
				<%=Html.Encode(Model.Id)%>
				<%=Html.Hidden("id",Model.Id) %></td>
		</tr>

		<tr>
			<td>FirstName</td>
			<td>

				<%=Html.TextBox("FirstName", Model.FirstName)%>
				<!--Html.TextArea("FirstName", Model.FirstName, 60, 15)-->
				<!--Html.TextBox("FirstName", Model.FirstName)-->
				<!--Html.CheckBox("FirstName", Model.FirstName)-->
				<!--Html.DropDownList("FirstName", Model.FirstName, new FirstNameHelper.SelectAll().Items, "Id", "FirstNameName")-->
				<!--String-->

			</td>
		</tr>

		<tr>
			<td>LastName</td>
			<td>

				<%=Html.TextBox("LastName", Model.LastName)%>
				<!--Html.TextArea("LastName", Model.LastName, 60, 15)-->
				<!--Html.TextBox("LastName", Model.LastName)-->
				<!--Html.CheckBox("LastName", Model.LastName)-->
				<!--Html.DropDownList("LastName", Model.LastName, new LastNameHelper.SelectAll().Items, "Id", "LastNameName")-->
				<!--String-->

			</td>
		</tr>

		<tr>
			<td>UserName</td>
			<td>

				<%=Html.TextBox("UserName", Model.UserName)%>
				<!--Html.TextArea("UserName", Model.UserName, 60, 15)-->
				<!--Html.TextBox("UserName", Model.UserName)-->
				<!--Html.CheckBox("UserName", Model.UserName)-->
				<!--Html.DropDownList("UserName", Model.UserName, new UserNameHelper.SelectAll().Items, "Id", "UserNameName")-->
				<!--String-->

			</td>
		</tr>

		<tr>
			<td>ProjectID</td>
			<td>

				<%=Html.DropDownList("ProjectID", Model.ProjectID, new ProjectHelper.SelectAll().Items, "Id", "ProjectName")%></td>
		</tr>

	</table>
	<button type="submit">Submit</button>
	<%=Html.ActionLink("Back to list", "User", "List" , "") %>
	<br/>

</form>