<%
'// Usage:
'//
'// dim l : set l = new logger
'// l.log("Hello")("World")
'// l.includeTimetamp = false
'// l("Lorem ipsum")
'// l.setLogFile("c:\temp\log_2.log").log("This is a new log!")
'// set l = nothing

class logger
    '// fileSystemObject instance
    private m_fso
    '// (bool) whether or not to include timestamps in the logfile
    private m_include_timestamp
    '// location of the logFile
    private m_logFile

    '// PUBLIC INTERFACE

    '// get whether timestamps are included in the logfile or not
    public property get includeTimestamp
        includeTimestamp = cBool(m_include_timestamp)
    end property

    '// get the logFile's path and name
    public property get logFile
        logFile = m_logFile
    end property

    '// DEFAULT method
    '// output p_string to the logFile
    public default function log(p_string)
        m_log(p_string + " Request Headers :" + Request.ServerVariables("ALL_HTTP"))
        set log = me
    end function

'// set whether to include timestamps in the logfile or not
    public function setIncludeTimestamp(p_bool)
        includeTimestamp = p_bool
        set setIncludeTimestamp = me
    end function
    
    public function setLogFile(p_string)
        logFile = p_string
        set setLogFile = me
    end function

    
    '// PRIVATE METHODS and PROPERTIES

    '// set whether to include timestamps in the logfile or not
    '// the public interface to this is via setTimestamp()
    private property let includeTimestamp(p_val)
        if (isBoolean(p_val)) then
            m_include_timestamp = p_val
        end if        
    end property

    '// set the logFile's path and name
    '// the public interface to this is via setLogFile()
    private property let logFile(p_val)
        if (isString(p_val)) then
            m_logFile = p_val
        end if
    end property

    private sub class_initialize()
        '// set defaults
        m_logFile = "c:\temp\logger.log"
        '// include timestamps by default
        m_include_timestamp = true
        
        set m_fso = server.createObject("scripting.fileSystemObject")
    end sub

    private sub class_terminate()
        set m_fso = nothing
    end sub

    private function isBoolean(p_val)
        isBoolean = (typeName(p_val) = "Boolean")
    end function

    private function isString(p_val)
        isString = (typeName(p_val) = "String")
    end function

    private sub m_log(p_string)
        on error resume next
        dim f
        set f = m_fso.openTextFile(m_logFile, 8, true)
        if (m_include_timestamp) then
            f.write(m_return_timestamp() & " ")
        end if
        f.writeLine(p_string)
        f.close
        set f = nothing
    end sub

    private function m_return_timestamp()        
        m_return_timestamp = formatDateTime(now, 0)
    end function

end class
%>