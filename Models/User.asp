
      <%

      '
      ' This files defines the User model
      '
class User

      private mMetadata

      '=============================
      'Private properties
      private mId

        private  mFirstName
        private  mLastName
        private  mUserName
        private  mProjectID
      private sub Class_Initialize()
          mMetadata = Array("Id",  "FirstName"  ,  "LastName"  ,  "UserName"  ,  "ProjectID" )
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

      public property get FirstName()
      FirstName = mFirstName
      end property

      public property let FirstName(val)
      mFirstName = val
      end property

      public property get LastName()
      LastName = mLastName
      end property

      public property let LastName(val)
      mLastName = val
      end property

      public property get UserName()
      UserName = mUserName
      end property

      public property let UserName(val)
      mUserName = val
      end property

      public property get ProjectID()
      ProjectID = mProjectID
      end property

      public property let ProjectID(val)
      mProjectID = val
      end property

      public property get metadata()
      metadata = mMetadata
      end property

end class 'User

      '======================
class UserHelper

      Dim selectSQL

      private sub Class_Initialize()
      selectSQL = " SELECT * FROM [User] "
      end sub

      private sub Class_Terminate()
      end sub

      '=============================
      'public Functions

      ' Create a new User.
      ' true - if successful, false otherwise
      public function Insert(ByRef obj)
        Dim strSQL , execResult
        strSQL=   " Insert into [User] ( FirstName , LastName , UserName , ProjectID)" & _
        " Values (?  , ?  , ?  , ? ); "
        set objCommand=Server.CreateObject("ADODB.command")

        objCommand.ActiveConnection=DbOpenConnection()
        objCommand.NamedParameters = False
        objCommand.CommandText = strSQL
        objCommand.CommandType = adCmdText

        if DbAddParameters(objCommand, Array( obj.FirstName ,  obj.LastName ,  obj.UserName ,  obj.ProjectID )) then
          objCommand.Execute
          Insert = true
        Else
          Insert = false
        End If
      end  function

      ' Update the User
      public function Update(obj)
        Dim strSQL
        strSQL= "Update [User] set FirstName=?  , LastName=?  , UserName=?  , ProjectID=?  Where Id = ? "

        set objCommand=Server.CreateObject("ADODB.command")

        objCommand.ActiveConnection=DbOpenConnection()
        objCommand.NamedParameters = False
        objCommand.CommandText = strSQL
        objCommand.CommandType = adCmdText

      if DbAddParameters(objCommand, Array(obj.FirstName, obj.LastName, obj.UserName, obj.ProjectID,  obj.Id)) then
        objCommand.Execute
        Update = true
      Else
	       Update = false
      End If

      end function

      ' Delete the User
      public function Delete(Id)
      Dim strSQL
          strSQL= "DELETE FROM [User] WHERE Id = ?"
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

      ' Select the User by ID
      ' return User object - if successful, Nothing otherwise
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

      ' Select all Users into a Dictionary
      ' return a Dictionary of User objects - if successful, Nothing otherwise
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
          set obj = PopulateObjectFromRecord(records)
          results.Add obj.Id, obj
          records.movenext
          wend
          set SelectAll = results
          records.Close
          End If
          set records = nothing
      end function

      ' Select all Users into a Dictionary
      ' return a Dictionary of User objects - if successful, Nothing otherwise
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
            set obj = new User
            obj.Id = record("Id")
            obj.FirstName = record("FirstName")
            obj.LastName = record("LastName")
            obj.UserName = record("UserName")
            obj.ProjectID = record("ProjectID")
            set PopulateObjectFromRecord = obj
      end if
    end function

end class 'UserHelper
%>
    