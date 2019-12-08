{- Unfolds Optional (List Text)
-}
let getPackages
    : forall (packages : Optional (List Text)) -> List Text
    =     \(packages : Optional (List Text))
      ->  Optional/fold
            (List Text)
            packages
            (List Text)
            (\(some : List Text) -> some)
            ([] : List Text)

in  getPackages
