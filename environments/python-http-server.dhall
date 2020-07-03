let Server =
      \(port : Natural) ->
        (../schemas/Env)::{
        , name = "python-http-server"
        , description = Some "Expore current directory over HTTP"
        , capabilities = (../schemas/Caps)::{
          , mount-cwd = Some True
          , network = Some True
          }
        , environ = Some (toMap { PYTHONUNBUFFERED = "1" })
        , packages = Some [ "python3" ]
        , ports = Some [ "${Natural/show port}:8000" ]
        , command = Some [ "python3", "-m", "http.server" ]
        }

in  { Server, Default = Server 8000 }
