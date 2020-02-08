let Node =
      ../functions/addCap.dhall
        (     \(env : ../types/Env)
          ->  env.capabilities // { terminal = Some True, network = Some True }
        )
        (../functions/mkSimpleEnv.dhall "node" "JavaScript runtime environment")

let Npm =
      ../functions/addCap.dhall
        (     \(env : ../types/Env)
          ->  env.capabilities // { mount-cwd = Some True, uidmap = Some True }
        )
        (     Node
          //  { name = "npm"
              , description = Some "JavaScript package manager"
              , command = Some [ "npm" ]
              }
        )

let Yarn = Npm // { name = "yarn", command = Some [ "yarn" ] }

let ReactScripts =
          ../functions/addCap.dhall
            (     \(env : ../types/Env)
              ->      env.capabilities
                  //  { network = Some False
                      , large-shm = Some True
                      , x11 = Some True
                      }
            )
            Yarn
      //  { name = "react-scripts"
          , description = Some "JavaScript development runtime"
          , syscaps = Some [ "NET_ADMIN" ]
          , pre-tasks = Some
              [ (../schemas/Task)::{
                , command = Some "ip a a 127.0.0.1/32 dev lo; ip link set lo up"
                }
              ]
          }

in  { Node = Node, Npm = Npm, Yarn = Yarn, ReactScripts = ReactScripts }
