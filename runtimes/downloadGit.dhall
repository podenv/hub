let RemoteGit
    : Type
    = { name : Text, url : Text, commit : Text, dest : Text }

let downloadGit
    : forall (cacheDir : Text) -> forall (git : RemoteGit) -> List Text
    =     \(cacheDir : Text)
      ->  \(git : RemoteGit)
      ->  let git-dir = "${cacheDir}/${git.name}"

          in  [ "mkdir -p ${git-dir}"
              ,     "test -d ${git-dir}/refs "
                ++  "&& git --git-dir ${git-dir} fetch --all "
                ++  "|| git clone --bare ${git.url} ${git-dir}"
              , "mkdir -p ${git.dest}"
              , "git clone ${git-dir} ${git.dest}"
              , "cd ${git.dest}; git checkout ${git.commit}"
              ]

let download =
          \(cacheDir : Text)
      ->  \(git : RemoteGit)
      ->      "RUN bash -c '"
          ++  (../Prelude.dhall).Text.concatSep
                " && "
                (downloadGit cacheDir git)
          ++  "'"

in  download
