{- Unfolds Optional (List Text)
-}
let getPackages
    : forall (packages : Optional (List Text)) -> List Text
    = \(packages : Optional (List Text)) ->
        merge
          { None = [] : List Text, Some = \(some : List Text) -> some }
          packages

in  getPackages
