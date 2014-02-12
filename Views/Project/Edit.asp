

      Edit Project

      <form action='<%=Html.Url("Project","EditPost","")%>' id="EditPost" method="post">
        <table>
          <tr>
            <td>id</td>
            <td>
              <%=Html.Encode(Model.Id)%>
              <%=Html.Hidden("id",Model.Id) %>
            </td>
          </tr>

          <tr>
            <td>
              ProjectName
            </td>
            <td>

                <%=Html.TextBox("ProjectName", Model.ProjectName)%>
                <!--Html.TextArea("ProjectName", Model.ProjectName, 60, 15)-->
                <!--Html.TextBox("ProjectName", Model.ProjectName)-->
                <!--Html.CheckBox("ProjectName", Model.ProjectName)-->
                <!--Html.DropDownList("ProjectName", Model.ProjectName, new ProjectNameHelper.SelectAll().Items, "Id", "ProjectNameName")-->
                <!--String-->

            </td>
          </tr>

          <tr>
            <td>
              Active
            </td>
            <td>

                <%=Html.CheckBox("Active", Model.Active)%>

            </td>
          </tr>

          <tr>
            <td>
              POP3Address
            </td>
            <td>

                <%=Html.TextBox("POP3Address", Model.POP3Address)%>
                <!--Html.TextArea("POP3Address", Model.POP3Address, 60, 15)-->
                <!--Html.TextBox("POP3Address", Model.POP3Address)-->
                <!--Html.CheckBox("POP3Address", Model.POP3Address)-->
                <!--Html.DropDownList("POP3Address", Model.POP3Address, new POP3AddressHelper.SelectAll().Items, "Id", "POP3AddressName")-->
                <!--String-->

            </td>
          </tr>

        </table>
        <button type="submit">Submit</button>
        <%=Html.ActionLink("Back to list", "Project", "List" , "") %> <br/>

      </form>

    