{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:0d1c662f572f6f677c5e2e13ccb0606a87a724a9cfe13b540a8dd715a10036e0
    : List
        ./types/Env sha256:9b693282e67cb6b033e0156e7722bd022dca4c4bee3591c5d77222efe1d15b8e
, Environments =
    ./environments.dhall sha256:cd0acd984a4224d7dc2687ec7da13010a2bb276f23029a69d7073d41c44f18fe
, Functions =
    ./functions.dhall sha256:e021820dbfda6b95f28395ad9b1aeb59bcbdb54307ffc703606309ecd86ebfda
, Runtimes =
    ./runtimes.dhall sha256:494714b1bc15b6e7bce5791397c64711506138bd8213c6d94e67058698e944fe
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
