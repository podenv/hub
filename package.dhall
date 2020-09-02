{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:9ab7e9887b26220d5b89fc6cbbaf1c8c5f015b1c83571c25ba4bb8865dd4ec8d
    : List
        ./types/Env sha256:15158bc7fa55c3d293875215bafb7d496e93453c1bd1cf945fe06dbb597e0876
, Environments =
    ./environments.dhall sha256:0b36ce701829c5be05812febb4c66f648e5cdf866233b405210eaf0cd108b77b
, Functions =
    ./functions.dhall sha256:693ac71377a8c6be904a81c52c23da04faf113a6408020653db8b500866e73fa
, Runtimes =
    ./runtimes.dhall sha256:570f1d0a5e001a6dc52c8932b8783399557b9e24f30ad385020c95f0480256e8
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
