{- Converts a List Text to a container-file List Task
-}
let fromTextList
    : forall (list : List Text) -> Optional (List ../types/Task)
    =     \(list : List Text)
      ->  Some
            ( (../Prelude.dhall).List.map
                Text
                ../types/Task
                (\(elem : Text) -> (../schemas/Task)::{ command = Some elem })
                list
            )

in  fromTextList
