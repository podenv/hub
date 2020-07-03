{- A task to install the rpmfusion repository
-}
\(version : Text) ->
  (../../schemas/Task)::{
  , name = Some "Install rpmfusion repository"
  , shell = Some
      "dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${version}.noarch.rpm"
  }
