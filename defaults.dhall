{- The list of environments that can be used as-is
-}

let Envs = ./environments.dhall

let FedoraEnvs =
      ./functions/mapEnv.dhall
        (\(env : ./types/Env) -> (./runtimes/fedora/create.dhall).Latest env)

in  FedoraEnvs
      [ Envs.Shell
      , Envs.Pavucontrol
      , Envs.Xeyes
      , Envs.Mupdf
      , Envs.Feh
      , Envs.Inkscape
      , Envs.Mumble
      , Envs.PythonHTTPServer.Default
      , Envs.Ssh.Client
      , Envs.Git.Git
      , Envs.Git.PullRequest
      , Envs.Git.Review
      , Envs.Emacs.Nox
      , Envs.Emacs.IDE
      , Envs.Codium
      , Envs.Firefox.Minimal
      , (./runtimes/fedora/create.dhall).Fusion Envs.Firefox.WithCodecs
      , Envs.StreamTuner
      ]