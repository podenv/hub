let capabilities =
      (../schemas/Caps)::{
      , x11 = Some True
      , foreground = Some True
      , large-shm = Some True
      }

let free-repo =
      (../schemas/Task)::{
      , name = Some "Install extra repo"
      , copy = Some
        { dest = "/etc/yum.repos.d/vscodium.repo"
        , content =
            ''
            [gitlab.com_paulcarroty_vscodium_repo]
            name=gitlab.com_paulcarroty_vscodium_repo
            baseurl=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/rpms/
            enabled=1
            gpgcheck=1
            repo_gpgcheck=1
            gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
            ''
        }
      }

let non-free-repo =
      (../schemas/Task)::{
      , name = Some "Install extra repo"
      , copy = Some
        { dest = "/etc/yum.repos.d/code.repo"
        , content =
            ''
            [code]
            name=Visual Studio Code
            baseurl=https://packages.microsoft.com/yumrepos/vscode
            enabled=1
            gpgcheck=1
            gpgkey=https://packages.microsoft.com/keys/microsoft.asc
            ''
        }
      }

let common-pkgs = [ "libX11-xcb", "which", "gdouros-symbola-fonts" ]

let Infos =
      { Free =
        { Repo = free-repo
        , Env = (../schemas/Env)::{
          , name = "codium"
          , description = Some "Open Source Binaries of VSCode"
          , command = Some [ "codium" ]
          , capabilities
          , packages = Some ([ "codium" ] # common-pkgs)
          }
        }
      , Non-Free =
        { Repo = non-free-repo
        , Env = (../schemas/Env)::{
          , name = "code"
          , description = Some "Binaries of VSCode"
          , command = Some [ "code" ]
          , capabilities
          , packages = Some ([ "code" ] # common-pkgs)
          }
        }
      }

in      Infos
    //  { FedoraRuntime =
            \(info : { Repo : ../types/Task, Env : ../types/Env }) ->
              (../runtimes/fedora/create.dhall).Base
                (../runtimes/fedora/create.dhall).LatestVersion
                [ info.Repo ]
                info.Env
        }
