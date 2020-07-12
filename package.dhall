{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:92d087d99465b995b6ab01a5ebc4d0f658110d6a81dbb62b6ebb51f2b03842a7
    : List
        ./types/Env sha256:15158bc7fa55c3d293875215bafb7d496e93453c1bd1cf945fe06dbb597e0876
, Environments =
    ./environments.dhall sha256:76250f751e7180dba058c70f8689fcffb8e154213a71023325b5a92d62434f7a
, Functions =
    ./functions.dhall sha256:693ac71377a8c6be904a81c52c23da04faf113a6408020653db8b500866e73fa
, Runtimes =
    ./runtimes.dhall sha256:2ea6b14f6e912ab51ef8eda4f7df9b8ce28c2cd0a3b5f78be22f293e0e20d71e
, Prelude =
    ./Prelude.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e
}
