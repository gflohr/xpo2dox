/** xpo2dox generated namespace for all classes. */ namespace AX { // Exportfile for AOT version 1.0 or later
    Formatversion: 1
    //
    ***Element: CLS
    //
    ; Microsoft Dynamics Class: HelloWorld nicht geladen
    ; --------------------------------------------------------------------------------
      CLSVERSION 1
      
      CLASS #HelloWorld
        Id 42000
        PROPERTIES
          Name                #HelloWorld
          Extends             #
          RunOn               #Called from
        ENDPROPERTIES
        
        METHODS
          Version: 3
          SOURCE #classDeclaration
    /**
     * Say "hello" to the world.
     */
    public class HelloWorld
    {
    }
          ENDSOURCE
          SOURCE #hello
    /**
     * This is a javadoc like documentation comment.
     *
     * This entire comment counts as 6 lines,
     * because it has two lines in the long description.
     */
    public string hello()
    {
        // This is comment line #7. The next line should be counted as an empty line.
    //
        return "Hello World!"; /* This comment is not counted, because it is not a line of its own.
                                  This counts as comment #8
                                  And this is comment #9 */
    //
        // Comment #10. Two more empty lines - one above this line, one below.
    //
    }
          ENDSOURCE
        ENDMETHODS
      ENDCLASS
    //
} // ***Element: END
