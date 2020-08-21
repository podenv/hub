{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:f2815851bf2737af80d27808279b9cef33923f9482be6292ac3d16af831965e8
    : List
        ./types/Env sha256:15158bc7fa55c3d293875215bafb7d496e93453c1bd1cf945fe06dbb597e0876
, Environments =
    ./environments.dhall sha256:565e1e89dbfb190aeec5e0225d23eb1524bf59f71638e6ca6cf53346050f8525
, Functions =
    ./functions.dhall sha256:693ac71377a8c6be904a81c52c23da04faf113a6408020653db8b500866e73fa
, Runtimes =
    ./runtimes.dhall sha256:570f1d0a5e001a6dc52c8932b8783399557b9e24f30ad385020c95f0480256e8
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
