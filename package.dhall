{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:e7a42f72a89fd0dd0189da78c7a8d8296aadef4b9b79dbf80f9faa89a301c880
    : List
        ./types/Env sha256:15158bc7fa55c3d293875215bafb7d496e93453c1bd1cf945fe06dbb597e0876
, Environments =
    ./environments.dhall sha256:43c7310e9fe4a945b9da37c9bf0cc5234bb1e519ebaf0d63e5b3ccac11577cef
, Functions =
    ./functions.dhall sha256:693ac71377a8c6be904a81c52c23da04faf113a6408020653db8b500866e73fa
, Runtimes =
    ./runtimes.dhall sha256:570f1d0a5e001a6dc52c8932b8783399557b9e24f30ad385020c95f0480256e8
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
