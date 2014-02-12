

      Delete User

      <form action='<%=Html.Url("User","DeletePost","")%>' id="DeletePost" method="post">
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
        <button type="submit">Submit</button>
         <%=Html.ActionLink("Back to list", "User", "List" , "") %> <br/>
      </form>

    