{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:512c8eb8dd3e749ccc4d6893af6dbbb14c2a2a76b8967d631e68b8dd5022d027
    : List
        ./types/Env sha256:9b693282e67cb6b033e0156e7722bd022dca4c4bee3591c5d77222efe1d15b8e
, Environments =
    ./environments.dhall sha256:b8ec722695af11ac06165825008e557ef5c1e1418c7f445d415c61cd4a2652c6
, Functions =
    ./functions.dhall sha256:ef90e9f57b1be9e3ae2bdafdddcbbe817500626b18eb0c694dd61473c16d5ec8
, Runtimes =
    ./runtimes.dhall sha256:8342ce8da1ea5a0c778986ff8a6a9ca32ab24cec6818572144d9f4e8d463c2f0
, Prelude =
    ./Prelude.dhall sha256:aea6817682359ae1939f3a15926b84ad5763c24a3740103202d2eaaea4d01f4c
}
