

      Delete Project

      <form action='<%=Html.Url("Project","DeletePost","")%>' id="DeletePost" method="post">
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
        <button type="submit">Submit</button>
         <%=Html.ActionLink("Back to list", "Project", "List" , "") %> <br/>
      </form>

    