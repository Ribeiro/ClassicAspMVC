

      Details on Project

      <table>
        <tr>
          <td>id</td>
          <td>
            <%=Html.Encode(Model.Id)%>
          </td>
        </tr>

        <tr>
          <td>
            ProjectName
          </td>
          <td>
            <%=Html.Encode(Model.ProjectName)%>
          </td>
        </tr>

        <tr>
          <td>
            Active
          </td>
          <td>
            <%=Html.Encode(Model.Active)%>
          </td>
        </tr>

        <tr>
          <td>
            POP3Address
          </td>
          <td>
            <%=Html.Encode(Model.POP3Address)%>
          </td>
        </tr>

      </table>
      <%=Html.ActionLink("Back to list", "Project", "List" , "") %> <br/>

    