{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:0a89a64d7237b3da87abeba7127dccb552bcb151b76b3efc7671fb155f2550a0
    : List
        ./types/Env sha256:9b693282e67cb6b033e0156e7722bd022dca4c4bee3591c5d77222efe1d15b8e
, Environments =
    ./environments.dhall sha256:b5f3a2e8a5c7c5e0be78132d8c2ded2d747a3eb8efdd77a18792a02b0f453613
, Functions =
    ./functions.dhall sha256:2e3b9907ee9d63bf5e3b76ad6e042c749a924a5e6bd72d7f2570951cb762f1f2
, Runtimes =
    ./runtimes.dhall sha256:fa9a613ed70d90ab07b9cba16910f7f8fbe33605995efd206b34e13f268d85d4
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
