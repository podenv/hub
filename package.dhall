{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:1ef557bd6479a12eaabc3674a18c3a1ac6f258633bd18dd30d7f2255acd96de4
    : List
        ./types/Env sha256:9b693282e67cb6b033e0156e7722bd022dca4c4bee3591c5d77222efe1d15b8e
, Environments =
    ./environments.dhall sha256:822b4c16d57ad4455d4cf2fea6c10cc046a53f0fecae7307f72f0d4b5e0fb44c
, Functions =
    ./functions.dhall sha256:ef90e9f57b1be9e3ae2bdafdddcbbe817500626b18eb0c694dd61473c16d5ec8
, Runtimes =
    ./runtimes.dhall sha256:09f7dd85b273fa62985005c7747edc0f328075f8c2edaf4fe5ac61ee4b7e00c1
, Prelude =
    ./Prelude.dhall sha256:aea6817682359ae1939f3a15926b84ad5763c24a3740103202d2eaaea4d01f4c
}
