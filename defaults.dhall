{- The list of environments that can be used as-is
-}

let Envs = ./environments.dhall

let DebianEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/debian/create.dhall).Latest env)

let FedoraEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/fedora/create.dhall).Latest env)

let FedoraFusionEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/fedora/create.dhall).Fusion env)

let NodeEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/node/create.dhall).Latest env)

let PythonEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/python/create.dhall).Latest env)

in    [ Envs.Emacs.DhallEditor
      , ./runtimes/fedora/env.dhall
      , ./runtimes/centos/env.dhall
      , ./runtimes/debian/env.dhall
      , Envs.Fedora.Devel
      , Envs.Centos.Devel
      , Envs.Centos.Devel7
      ]
    # NodeEnvs
        [ Envs.Node.Node
        , Envs.Node.Npm
        , Envs.Node.Yarn
        , Envs.Node.ReactScripts
        ]
    # PythonEnvs [ Envs.Reno, Envs.Git.PullRequest ]
    # [     (./runtimes/nixos/create.dhall).Default Envs.Shell
        //  { name = "nix-shell" }
      ]
    # DebianEnvs [ Envs.Gworldclock ]
    # FedoraEnvs
        [ Envs.Shell
        , Envs.Audacity
        , Envs.Pavucontrol
        , Envs.Xeyes
        , Envs.Mupdf
        , Envs.Electrum
        , Envs.Feh
        , Envs.Hugo
        , Envs.Inkscape
        , Envs.Kigo
        , Envs.Libreoffice
        , Envs.Librecad
        , Envs.Linphone
        , Envs.Mumble
        , Envs.Openvpn
        , Envs.PythonHttpServer.Default
        , Envs.Maim
        , Envs.Tor.Browser
        , Envs.Ssh.Client
        , Envs.Gimp
        , Envs.Git.Git
        , Envs.Git.Review
        , Envs.Emacs.Nox
        , Envs.Emacs.IDE
        , Envs.Chromium
        , Envs.Firefox.Minimal
        , Envs.Streamtuner
        , Envs.YoutubeDl
        , Envs.VirtViewer
        , Envs.Zeal
        , Envs.Pass
        ]
    # FedoraFusionEnvs [ Envs.Obs, Envs.Firefox.WithCodecs, Envs.Mplayer ]
    # [ Envs.Code.FedoraRuntime Envs.Code.Free
      , Envs.Code.FedoraRuntime Envs.Code.Non-Free
      , (./runtimes/fedora/create.dhall).FusionNonFree Envs.Steam
      , Envs.Vcv
      ]
