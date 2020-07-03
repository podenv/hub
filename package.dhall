{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:9c95065a5a1e96118d71d10e36f041929701bcfe1e71a41d05b2507cec1a066e
    : List
        ./types/Env sha256:9b693282e67cb6b033e0156e7722bd022dca4c4bee3591c5d77222efe1d15b8e
, Environments =
    ./environments.dhall sha256:61a8118fc5482292ae720adba36127c8944a426d1684dd14f8ad873c8efd90e9
, Functions =
    ./functions.dhall sha256:2e3b9907ee9d63bf5e3b76ad6e042c749a924a5e6bd72d7f2570951cb762f1f2
, Runtimes =
    ./runtimes.dhall sha256:fa9a613ed70d90ab07b9cba16910f7f8fbe33605995efd206b34e13f268d85d4
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
