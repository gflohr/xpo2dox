/** xpo2dox generated namespace for all classes. */ namespace AX { // Exportfile for AOT version 1.0 or later
    Formatversion: 1
    //
    ***Element: JOB
    //
    ; Microsoft Dynamics Job: AKA_Temp_updateInventTrans nicht geladen
    ; --------------------------------------------------------------------------------
/** xpo2dox generated wrapper class for all jobs. */ partial class Jobs { //   JOBVERSION 1
          
          SOURCE #someJob
        /**
         * For exported job files, the indentation is only 4 whitespaces.
         *
         * I have to admit that I have never seen a source file mixing these two different
         * indentation styles. This is only for the test case.
         *
         * \callgraph
         */
        static void someJob(Args args)
        {
            HelloWorld hello = new HelloWorldDecorator();
            IPrinter printer = new ParallelPortPrinter();
            ;
        //
            printer.print(hello.hello());
        }
    } //   ENDSOURCE
    //
} // ***Element: END
