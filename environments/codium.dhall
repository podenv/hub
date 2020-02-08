(../runtimes/fedora/create.dhall).Base
  "31"
  [ (../schemas/Task)::{
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
  ]
  (../schemas/Env)::{
  , name = "codium"
  , description = Some "Open Source Binaries of VSCode"
  , command = Some [ "codium" ]
  , capabilities = (../schemas/Caps)::{
    , x11 = Some True
    , foreground = Some True
    , large-shm = Some True
    }
  , packages = Some [ "vscodium", "which" ]
  }
