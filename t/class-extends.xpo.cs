/** xpo2dox generated namespace for all classes. */ namespace AX { // Exportfile for AOT version 1.0 or later
    Formatversion: 1
    //
    ***Element: CLS
    //
    ; Microsoft Dynamics Class: HelloWorldDecorator nicht geladen
    ; --------------------------------------------------------------------------------
      CLSVERSION 1
      
      CLASS #HelloWorldDecorator
        Id 42000
        PROPERTIES
          Name                #HelloWorldDecorator
          Extends             #
          RunOn               #Called from
        ENDPROPERTIES
        
        METHODS
          Version: 3
          SOURCE #classDeclaration
    /**
     * A decorator inheriting from \ref HelloWorld.
     */
    class HelloWorldDecorator : HelloWorld
    {
        //}
              ENDSOURCE
              SOURCE #hello
        public string hello()
        {
            return null;
        }
              ENDSOURCE
            ENDMETHODS
          ENDCLASS
        //
} // ***Element: END
