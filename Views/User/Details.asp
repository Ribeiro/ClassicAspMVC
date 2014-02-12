

      Details on User

      <table>
        <tr>
          <td>id</td>
          <td>
            <%=Html.Encode(Model.Id)%>
          </td>
        </tr>

        <tr>
          <td>
            FirstName
          </td>
          <td>
            <%=Html.Encode(Model.FirstName)%>
          </td>
        </tr>

        <tr>
          <td>
            LastName
          </td>
          <td>
            <%=Html.Encode(Model.LastName)%>
          </td>
        </tr>

        <tr>
          <td>
            UserName
          </td>
          <td>
            <%=Html.Encode(Model.UserName)%>
          </td>
        </tr>

        <tr>
          <td>
            ProjectID
          </td>
          <td>
            <%=Html.Encode(Model.ProjectID)%>
          </td>
        </tr>

      </table>
      <%=Html.ActionLink("Back to list", "User", "List" , "") %> <br/>

    