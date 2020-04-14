{ Devel =
        (../runtimes/centos/create.dhall).Devel ./shell.dhall
    //  { name = "centos-devel"
        , user = None (../Podenv.dhall).Types.User
        , mounts = Some
          [ ../functions/mkMount.dhall
              "/var/cache/dnf"
              "~/.cache/podenv/dnf-centos"
          ]
        }
}
