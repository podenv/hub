{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults =
      ./defaults.dhall sha256:4d6ebc7a1e2ef161d4af8e64c8432340f5866ad34b8167de3a4cc079e56ce7c8
    : List
        ./types/Env sha256:9b693282e67cb6b033e0156e7722bd022dca4c4bee3591c5d77222efe1d15b8e
, Environments =
    ./environments.dhall sha256:9795cadcb5c15eee7ff10ce13481fbabe83289a837842c21b66918429e5bc952
, Functions =
    ./functions.dhall sha256:ef90e9f57b1be9e3ae2bdafdddcbbe817500626b18eb0c694dd61473c16d5ec8
, Runtimes =
    ./runtimes.dhall sha256:73ee826171c415f320aaebdc8fe8f0d488a25e3800574262ce8d64f5785a23ba
, Prelude =
    ./Prelude.dhall sha256:aea6817682359ae1939f3a15926b84ad5763c24a3740103202d2eaaea4d01f4c
}
