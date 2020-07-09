{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:f1dd05446c5d9aac6fb805af6ba076ba8f282fe72a1b019c574c2ba1220a9ff7
    : List
        ./types/Env sha256:9b693282e67cb6b033e0156e7722bd022dca4c4bee3591c5d77222efe1d15b8e
, Environments =
    ./environments.dhall sha256:d1cbd08849b37fbf11ba65f20f237d1531e435c5e4a40b1d0a28a7216e70a987
, Functions =
    ./functions.dhall sha256:e021820dbfda6b95f28395ad9b1aeb59bcbdb54307ffc703606309ecd86ebfda
, Runtimes =
    ./runtimes.dhall sha256:494714b1bc15b6e7bce5791397c64711506138bd8213c6d94e67058698e944fe
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
