/** xpo2dox generated namespace for all classes. */ namespace AX { // Exportfile for AOT version 1.0 or later
    Formatversion: 1
    //
    ***Element: CLS
    //
    ; Microsoft Dynamics Class: IPrinter nicht geladen
    ; --------------------------------------------------------------------------------
      CLSVERSION 1
      
      INTERFACE #IPrinter
        Id 42000
        PROPERTIES
          Name                #IPrinter
          Extends             #
          RunOn               #Called from
        ENDPROPERTIES
        
        METHODS
          Version: 3
          SOURCE #classDeclaration
    interface IPrinter
    {
        //}
              ENDSOURCE
              SOURCE #print
        void print(string message)
        {
        }
              ENDSOURCE
            ENDMETHODS
          ENDCLASS
        //
} // ***Element: END