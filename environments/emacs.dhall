let Dhall = (./dhall.dhall).Commands

let Emacs =
      ../functions/addPackages.dhall
        [ "findutils", "grep" ]
        ( ../functions/capFs.dhall
            ( ../functions/mkSimpleTerminalEnv.dhall
                "emacs"
                "Extensible text editor"
            )
        )

let Graphic = ../functions/capGraphics.dhall Emacs

let IDE =
          ../functions/addPackages.dhall
            [ "make"
            , "git"
            , "cmake"
            , "gcc"
            , "gcc-c++"
            , "openssl-devel"
            , "libssh2-devel"
            , "glibc-common"
            ]
            Emacs
      //  { capabilities = (../schemas/Caps)::{
            , x11 = Some True
            , terminal = Some True
            , network = Some True
            , git = Some True
            , ssh = Some True
            }
          }

let {- A simple standalone environment to edit dhall file
    -} DhallEditor =
      let build-cache = "~/.cache/podenv/buildStore"

      let dhall-mode =
            { name = "dhall-mode"
            , url = "https://github.com/psibi/dhall-mode"
            , commit = "ef4d33debe224c6ba37e51a29b9dc8b74f20f1c2"
            , dest = "/usr/local/share/emacs/dhall-mode"
            }

      let reformatter =
            { name = "reformatter"
            , url = "https://github.com/purcell/reformatter.el"
            , commit = "6c5e7f64c5ac1178dff5ca28d9809c08398fb3e6"
            , dest = "/usr/local/share/emacs/reformatter"
            }

      in  (../schemas/Env)::{
          , name = "dhall-editor"
          , description = Some "Emacs dhall editor"
          , command = Some
            [ "emacs", "--no-splash", "--load", "~/.emacs.d/init.el" ]
          , capabilities = (../schemas/Caps)::{
            , x11 = Some True
            , terminal = Some True
            , network = Some True
            , hostfiles = Some True
            }
          , mounts = Some [ ../functions/mkMountMap.dhall "~/.cache/dhall" ]
          , user = Some { name = "user", uid = 1000, home = "/home/user" }
          , build-env = Some
              ( ../runtimes/mkBuildEnv.dhall
                  [ ../functions/mkMountMap.dhall build-cache
                  , ../functions/mkMount.dhall
                      "/var/cache/dnf"
                      "~/.cache/podenv/dnf"
                  ]
              )
          , container-file =
              ../runtimes/fromTextList.dhall
                [ "FROM registry.fedoraproject.org/fedora:latest"
                , "RUN dnf install -y emacs git bzip2"
                ,     "RUN useradd -u 1000 -m user && "
                  ++  "mkdir /home/user/.cache /home/user/.config && chown -R user /home/user"
                , Dhall.`1.33`.base
                , Dhall.`1.33`.json
                , Dhall.cache.Prelude "v17.0.0"
                , ../runtimes/downloadGit.dhall build-cache dhall-mode
                , ../runtimes/downloadGit.dhall build-cache reformatter
                ]
          , volumes = Some
            [ { name = "dhall-editor-config"
              , container-path = "~/.emacs.d/"
              , files = Some
                [ { name = "init.el", content = ./emacs-dhall.el as Text } ]
              }
            ]
          }

let ConfigEditor =
          ../functions/addEnviron.dhall
            ( toMap
                { PODENV_HUB = "~/git/github.com/podenv/hub/package.dhall"
                , PODENV_PRELUDE =
                    "~/git/github.com/podenv/podenv/podenv/dhall/package.dhall"
                }
            )
            ( ../functions/addMountMap.dhall
                "~/git/github.com/podenv"
                (../functions/addMountMap.dhall "~/.config/podenv" DhallEditor)
            )
      //  { command = Some
            [ "emacs"
            , "--no-splash"
            , "--load"
            , "~/.emacs.d/init.el"
            , "~/.config/podenv/config.dhall"
            ]
          }

in  { Nox =
            Emacs
        //  { name = "emacs-nox"
            , description = Some
                "Extensible text editor (minimal terminal mode)"
            , command = Some [ "emacs", "-nw" ]
            }
    , Graphic
    , IDE
    , DhallEditor
    , ConfigEditor
    }
