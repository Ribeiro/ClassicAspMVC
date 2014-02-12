

      List Projects

      <%=Html.ActionLink("Create new Project", "Project", "Create" , "") %>

      <table>
        <tr>

          <td>
            ProjectName
          </td>

          <td>
            Active
          </td>

          <td>
            POP3Address
          </td>

          <td></td>
        </tr>

        <%
    if  IsNothing(Model) then
        %> <tr>
          <td colspan="4">No records</td>
        </tr><%
    Else
        Dim obj
        For each obj in Model.Items
        %>

        <tr>

          <td>
            <%=Html.Encode(obj.ProjectName) %>
          </td>

          <td>
            <%=Html.Encode(obj.Active) %>
          </td>

          <td>
            <%=Html.Encode(obj.POP3Address) %>
          </td>

          <td>
            <%=Html.ActionLink("Edit", "Project", "Edit" , "id=" + CStr(obj.Id)) %> |
            <%=Html.ActionLink("Delete", "Project", "Delete" , "id=" + CStr(obj.Id)) %> |
            <%=Html.ActionLink("Details", "Project", "Details" , "id=" + CStr(obj.Id)) %>

          </td>
        </tr>
          <%

        Next
     End If
     %>
      </table>

    