{- The list of environments that can be used as-is
-}

let Envs = ./environments.dhall

let FedoraEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/fedora/create.dhall).Latest env)

in    [ Envs.Emacs.DhallEditor, ./runtimes/fedora/env.dhall ]
    # FedoraEnvs
        [ Envs.Shell
        , Envs.Pavucontrol
        , Envs.Xeyes
        , Envs.Mupdf
        , Envs.Feh
        , Envs.Inkscape
        , Envs.Libreoffice
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
