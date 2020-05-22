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
, Devel7 =
        (../runtimes/centos/create.dhall).DevelBase 7 ./shell.dhall
    //  { name = "centos-7-devel"
        , user = None (../Podenv.dhall).Types.User
        , mounts = Some
          [ ../functions/mkMount.dhall
              "/var/cache/yum"
              "~/.cache/podenv/yum-centos"
          ]
        }
}
