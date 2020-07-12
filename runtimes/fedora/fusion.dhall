{- A task to install the rpmfusion repository
-}
\(variant : Text) ->
\(version : Text) ->
  (../../schemas/Task)::{
  , name = Some "Install rpmfusion repository"
  , shell = Some
      "dnf install -y https://download1.rpmfusion.org/${variant}/fedora/rpmfusion-${variant}-release-${version}.noarch.rpm"
  }
