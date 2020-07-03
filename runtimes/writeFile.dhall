{- Generates a one-line command to write a multi-line content to a file
-}
let Podenv = ../../Podenv.dhall

let Prelude = ../../Prelude.dhall

let writeFile
    : forall (dest : Text) -> forall (content : List Text) -> Text
    = \(dest : Text) ->
      \(content : List Text) ->
        let first = ../optionalText.dhall (Prelude.List.head Text content) ""

        let rest = Prelude.List.drop 1 Text content

        in  Prelude.Text.concatSep
              " && "
              (   [ "echo '${first}' > ${dest}" ]
                # Prelude.List.map
                    Text
                    Text
                    (\(next : Text) -> "echo '${next}' >> ${dest}")
                    rest
              )

let example0 =
        assert
      :     writeFile "/test" [ "a", "b" ]
        ===  "echo 'a' > /test && echo 'b' >> /test"

in  writeFile
