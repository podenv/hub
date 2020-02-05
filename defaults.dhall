{- The list of environments that can be used as-is
-}

let Envs = ./environments.dhall

let FedoraEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/fedora/create.dhall).Latest env)

let NodeEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/node/create.dhall).Latest env)

let PythonEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/python/create.dhall).Latest env)

in    [ Envs.Emacs.DhallEditor, ./runtimes/fedora/env.dhall ]
    # NodeEnvs
        [ Envs.Node.Node
        , Envs.Node.Npm
        , Envs.Node.Yarn
        , Envs.Node.ReactScripts
        ]
    # PythonEnvs [ Envs.Reno ]
    # [     (./runtimes/nixos/create.dhall).Default Envs.Shell
        //  { name = "nix-shell" }
      ,     (./runtimes/fedora/create.dhall).Devel Envs.Shell
        //  { name = "fedora-devel"
            , user = None (./Podenv.dhall).Types.User
            , mounts = Some
                [ ./functions/mkMount.dhall
                    "/var/cache/dnf"
                    "~/.cache/podenv/dnf-rawhide"
                ]
            }
      ]
    # FedoraEnvs
        [ Envs.Shell
        , Envs.Pavucontrol
        , Envs.Xeyes
        , Envs.Mupdf
        , Envs.Feh
        , Envs.Hugo
        , Envs.Inkscape
        , Envs.Libreoffice
        , Envs.Linphone
        , Envs.Mumble
        , (./runtimes/fedora/create.dhall).Fusion Envs.Obs
        , Envs.OpenVPN
        , Envs.PythonHTTPServer.Default
        , Envs.Tor.Browser
        , Envs.Ssh.Client
        , Envs.Git.Git
        , Envs.Git.PullRequest
        , Envs.Git.Review
        , Envs.Emacs.Nox
        , Envs.Emacs.IDE
        , Envs.Codium
        , Envs.Chromium
        , Envs.Firefox.Minimal
        , (./runtimes/fedora/create.dhall).Fusion Envs.Firefox.WithCodecs
        , (./runtimes/fedora/create.dhall).Fusion Envs.Mplayer
        , Envs.StreamTuner
        , Envs.YoutubeDL
        ]
