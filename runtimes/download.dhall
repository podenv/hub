{- Renders a list of python statement to install a remote file locally
-}
let Podenv = ../Podenv.dhall

let RemoteObject
    : Type
    = { url : Text, hash : Text, dest : Text, archive : Optional Text }

let downloadCode
    : forall (cacheDir : Text) -> forall (obj : RemoteObject) -> List Text
    =     \(cacheDir : Text)
      ->  \(obj : RemoteObject)
      ->  let extract =
                Optional/fold
                  Text
                  obj.archive
                  (List Text)
                  (     \(archive : Text)
                    ->  [ "from subprocess import Popen, PIPE"
                        , "p = Popen(\"tar -xf - ${archive} -C\".split() + [str(output)], stdin=PIPE)"
                        , "p.communicate(data)"
                        , "fail(u + \": failed to extract\") if p.wait() else True"
                        ]
                  )
                  [ "output.parent.mkdir(parents=True, exist_ok=True)"
                  , "output.write_bytes(data)"
                  ]

          in    [ "import pathlib, urllib.request;from hashlib import sha256"
                , "fail = lambda s: (print(s), exit(1))"
                , "u, h = \"${obj.url}\", \"${obj.hash}\""
                , "output = pathlib.Path(\"${obj.dest}\").expanduser()"
                , "local = pathlib.Path(\"${cacheDir}\").expanduser() / h"
                , "notLocal = not local.exists() or sha256(local.read_bytes()).hexdigest() != h"
                , "print(u + \": downloading\") if notLocal else True"
                , "req = urllib.request.urlopen(u) if notLocal else True"
                , "data = req.read() if notLocal else local.read_bytes()"
                , "digest = sha256(data).hexdigest()"
                , "fail(u + \": expected \" + h + \"got \" + digest) if digest != h else True"
                , "local.parent.mkdir(parents=True, exist_ok=True)"
                , "local.write_bytes(data) if notLocal else True"
                , "print(u + \": extracted to \" + str(output))"
                ]
              # extract

let download =
          \(cacheDir : Text)
      ->  \(obj : RemoteObject)
      ->      "RUN python3 -c '"
          ++  (../Prelude.dhall).Text.concatSep ";" (downloadCode cacheDir obj)
          ++  "'"

in  download
