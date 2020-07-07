{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:44a38cc3ff6a54fdecbc731db1ae0f709057c45cc7b0fd3be8076942328a7039
    : List
        ./types/Env sha256:9b693282e67cb6b033e0156e7722bd022dca4c4bee3591c5d77222efe1d15b8e
, Environments =
    ./environments.dhall sha256:c1da67204486e7a7be964f4745a0ded14f2d30152b4c68b102935cd4b1019d73
, Functions =
    ./functions.dhall sha256:2e3b9907ee9d63bf5e3b76ad6e042c749a924a5e6bd72d7f2570951cb762f1f2
, Runtimes =
    ./runtimes.dhall sha256:b9cf5fc66ba2e6248ad7cc38537b80bbe57ee8c27f031fad0a054232e7152875
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
