{- Returns the pip3 install task
-}
    \(packages : List Text)
->  (../../schemas/Task)::{
    , name = Some "Install packages"
    , shell =
        let packages = (../../Prelude.dhall).Text.concatSep " " packages

        in  Some "python3 -m pip install --upgrade ${packages}"
    }
