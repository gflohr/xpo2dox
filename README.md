# xpo2dox

A Microsoft Dynamics AX 4.0 [XPO file](https://docs.microsoft.com/en-us/dynamicsax-2012/developer/how-to-export-application-objects-by-using-the-aot?redirectedfrom=MSDN) preprocessor for [Doxygen](https://www.doxygen.nl/helpers.html)

## Status

This is a proof of concept.

The code in this repository is experimental. In preliminary tests it worked sufficiently well to proof that the idea works.

Before adding more features, the scripts in this repository should be implemented in a suitable high level programming language. The features should be tested automatically. Otherwise I suspect the code complexity to rise and bugs creep in.

Please keep this in mind when forking and creating pull requests. I might decline or delay merging.

## About

[Doxygen](https://www.doxygen.nl) generates source code documentation from annotated source code files. It supports multiple programming languages. However, Microsoft Dynamics AX 4.0 has been missing until today.

The script [aot2dox](aot2dox) converts all recognized `.xpo` files from a git
repository and converts them into something, that [Doxygen](https://www.doxygen.nl) can interpret as C# code for documentation purpose.

## Requirements

You need [perl](https://www.perl.org/) which is most probably pre-installed
on your machine and [git](https://git-scm.com/).

You also need the Perl module [Git](https://metacpan.org/pod/Git) which is
installed with `git`. If not, try `cpanm Git` or `perl -MCPAN install Git`.

## Build and Install

There is no need to install this module. If you cannot help, then go like this:

```shell
$ perl Build
$ perl Build install
```

## Running

```shell
$ perl -Ilib aot2dox /path/to/ax40/checkout output-cs
```

If you have installed the module, you can do like this:

```shell
$ aot2dox /path/to/ax40/checkout output-cs
```

## Testing

### Basics

These commands do more or less the same:

```shell
$ prove -l
$ prove -l t/01xpo2dox.t # Run an individual test
$ perl Build test
$ perl -Ilib t/01xpo2dox.t # Run an individual test
```

### Coverage

Install the Perl module `Devel::Cover`.  Then:

```shell
$ cover -t
```

## Usage

Try `./aot2dox --help` for basic usage information or `perldoc ./aot2dox`
for extensive usage documentation.

## Thanks

Thanks to Dimitri van Heesch and all the contributors for maintaining [Doxygen](https://www.doxygen.nl) since 1997. Your tool has brought so much value to me for many many years! ❤️

## Create Code Documentation With Doxygen

If you have `doxygen` on your search path, then you can just enter

```shell
doxygen
```

in the cloned working directory.

This will run doxygen on the files in the [test](test) folder. Output will be generated in a new folder called `html`. Open `html/index.html` to check the generated documentation. Look into [Doxyfile](Doxyfile) to see how this script is configured. See the configuration parameters `INPUT_FILTER` and `EXTENSION_MAPPING`.

## Note

[xpo2dox](xpo2dox) is not a converter. The output is not valid C# code. The goal is to generate documentation from XPO files.

## Links

- [Doxygen](https://www.doxygen.nl) ([Github Repository](https://github.com/doxygen/doxygen))
- [XPO file](https://docs.microsoft.com/en-us/dynamicsax-2012/developer/how-to-export-application-objects-by-using-the-aot?redirectedfrom=MSDN)
- [Awk](https://www.grymoire.com/Unix/Awk.html) - an awk tutorial.
- [The GNU Awk User’s Guide](https://www.gnu.org/software/gawk/manual/gawk.html) - the official user guide for GNU awk.
