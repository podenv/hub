# hub: a podenv collection of applications and functions

> Please note that this is a work in progress,
> the structure maybe subject to change.

Entrypoint is the `package.dhall` file.

## Howto add a new default environment

* First create an environment file, for example:

```dhall
{- ./environments/my-new-env.dhall -}
(../schemas/Env)::{
    name = "my-new-env"
}
```

* Then add it to the `environments.dhall` file, for example:

```dhall
{ ...
, ...
, MyNewEnv = ./environments/my-new-env.dhall
}
```

* And adds to the `defaults.dhall` list:

```dhall
[ ...
, ./functions/Fedora.dhall Envs.MyNewEnv
]
```
