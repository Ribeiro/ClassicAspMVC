<%

      '
      ' This files defines the Project model
      '
class Project

      private mMetadata

      '=============================
      'Private properties
      private mId

        private  mProjectName
        private  mActive
        private  mPOP3Address
      private sub Class_Initialize()
          mMetadata = Array("Id",  "ProjectName"  ,  "Active"  ,  "POP3Address" )
      end sub

      private sub Class_Terminate()
      end sub

      '=============================
      'public properties

      public property get Id()
      Id = mId
      end property

      public property let Id(val)
      mId = val
      end property

      public property get ProjectName()
      ProjectName = mProjectName
      end property

      public property let ProjectName(val)
      mProjectName = val
      end property

      public property get Active()
      Active = mActive
      end property

      public property let Active(val)
      mActive = val
      end property

      public property get POP3Address()
      POP3Address = mPOP3Address
      end property

      public property let POP3Address(val)
      mPOP3Address = val
      end property

      public property get metadata()
      metadata = mMetadata
      end property

end class 'Project

      '======================
class ProjectHelper

      Dim selectSQL

      private sub Class_Initialize()
      selectSQL = " SELECT * FROM [Project] "
      end sub

      private sub Class_Terminate()
      end sub

      '=============================
      'public Functions

      ' Create a new Project.
      ' true - if successful, false otherwise
      public function Insert(ByRef obj)
        Dim strSQL , execResult
        strSQL=   " Insert into [Project] ( ProjectName , Active , POP3Address)" & _
        " Values (?  , ?  , ? ); "

        set objCommand=Server.CreateObject("ADODB.command")

        objCommand.ActiveConnection=DbOpenConnection()
        objCommand.NamedParameters = False
        objCommand.CommandText = strSQL
        objCommand.CommandType = adCmdText

        if DbAddParameters(objCommand, Array( obj.ProjectName ,  obj.Active ,  obj.POP3Address )) then
          objCommand.Execute
          Insert = true
        Else
          Insert = false
        End If
      end  function

      ' Update the Project
      public function Update(obj)
        Dim strSQL
        strSQL= "Update [Project] set ProjectName=?  , Active=?  , POP3Address=?  Where Id = ? "

        set objCommand=Server.CreateObject("ADODB.command")

        objCommand.ActiveConnection=DbOpenConnection()
        objCommand.NamedParameters = False
        objCommand.CommandText = strSQL
        objCommand.CommandType = adCmdText
      if DbAddParameters(objCommand, Array(obj.ProjectName, obj.Active, obj.POP3Address,  obj.Id)) then
        objCommand.Execute
        Update = true
      Else
        Update = false
      End If

      end function

      ' Delete the Project
      public function Delete(Id)
      Dim strSQL
          strSQL= "DELETE FROM [Project] WHERE Id = ?"
          set objCommand=Server.CreateObject("ADODB.command")
          objCommand.ActiveConnection=DbOpenConnection()
          objCommand.NamedParameters = False
          objCommand.CommandText = strSQL
          objCommand.CommandType = adCmdText
          if DbAddParameters(objCommand, array(Id)) Then
            objCommand.Execute
            Delete = true
          else
            Delete = false
          End If
      end function

      ' Select the Project by ID
      ' return Project object - if successful, Nothing otherwise
      public function SelectById(id)
          Dim record
          set objCommand=Server.CreateObject("ADODB.command")
          objCommand.ActiveConnection=DbOpenConnection()
          objCommand.NamedParameters = False
          objCommand.CommandText = selectSQL + " Where id=?"
          objCommand.CommandType = adCmdText

          If DbAddParameters(objCommand, array(Id)) Then
              set record = objCommand.Execute
              Set SelectById = PopulateObjectFromRecord(record)
              record.Close
              set record = nothing
          Else
              Set SelectById = Nothing
          End If

      end function

      ' Select all Projects into a Dictionary
      ' return a Dictionary of Project objects - if successful, Nothing otherwise
      public function SelectAll()
          Dim records
          set objCommand=Server.CreateObject("ADODB.command")
          objCommand.ActiveConnection=DbOpenConnection()
          objCommand.NamedParameters = False
          objCommand.CommandText = selectSQL
          objCommand.CommandType = adCmdText
          set records = objCommand.Execute
          if records.eof then
          Set SelectAll = Nothing
          else
          Dim results, obj, record
          Set results = Server.CreateObject("Scripting.Dictionary")
          while not records.eof
            'Response.Write records
          set obj = PopulateObjectFromRecord(records)
          results.Add obj.Id, obj
          records.movenext
          wend
          set SelectAll = results
          records.Close
          End If
          set records = nothing
      end function

      ' Select all Projects into a Dictionary
      ' return a Dictionary of Project objects - if successful, Nothing otherwise
      public function SelectByField(fieldName, value)
          Dim records
          set objCommand=Server.CreateObject("ADODB.command")
          objCommand.ActiveConnection=DbOpenConnection()
          objCommand.NamedParameters = False
          objCommand.CommandText = selectSQL + " where " + fieldName + "=?"
          objCommand.CommandType = adCmdText
          If DbAddParameters(objCommand, array(value)) Then
              set records = objCommand.Execute
              if records.eof then
                  Set SelectByField = Nothing
              else
                  Dim results, obj, record
                  Set results = Server.CreateObject("Scripting.Dictionary")
                  while not records.eof
                      set obj = PopulateObjectFromRecord(records)
                      results.Add obj.Id, obj
                      records.movenext
                  wend
                  set SelectByField = results
                  records.Close
              End If
                set records = nothing
          Else
              set SelectByField = Nothing
          End If
      end function

      private function PopulateObjectFromRecord(record)
        if record.eof then
            Set PopulateObjectFromRecord = Nothing
        else
            Dim obj
            set obj = new Project
            obj.Id = record("Id")

              obj.ProjectName = record("ProjectName")
              obj.Active = record("Active")
              obj.POP3Address = record("POP3Address")
              set PopulateObjectFromRecord = obj
      end if
    end function

end class 'ProjectHelper
%>