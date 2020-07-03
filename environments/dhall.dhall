{- Some shell instruction to setup dhall-haskell in container -}

let Text/concatSep = (../Prelude.dhall).Text.concatSep

let Commands =
      let DhallInstallCommand =
            \(sub-name : Text) ->
            \(version : Text) ->
            \(sub-version : Text) ->
            \(sub-hash : Text) ->
              let gh-url =
                    "https://github.com/dhall-lang/dhall-haskell/releases/download"

              let dhall-name = "dhall-${sub-name}${sub-version}"

              in  Text/concatSep
                    " && "
                    [ "curl -OL ${gh-url}/${version}/${dhall-name}-x86_64-linux.tar.bz2"
                    , "echo '${sub-hash}  ${dhall-name}-x86_64-linux.tar.bz2' | sha256sum -c"
                    , "tar -xf ${dhall-name}-x86_64-linux.tar.bz2 --strip-components=2 -j --mode='a+x' -C /usr/bin"
                    , "rm ${dhall-name}-x86_64-linux.tar.bz2"
                    ]

      in  { `1.30` =
            { json =
                DhallInstallCommand
                  "json-"
                  "1.30.0"
                  "1.6.2"
                  "ea37627c4e19789af33def099d4cb145b874c03b4d5b98cb33ce06be1debf4f3"
            , yaml =
                DhallInstallCommand
                  "yaml-"
                  "1.30.0"
                  "1.0.2"
                  "2e45c42e572aecbfce21198e7fc8697f82ddb63786f7a5f0bd78dec35e090059"
            , base =
                DhallInstallCommand
                  ""
                  "1.30.0"
                  "1.30.0"
                  "6845421de9c3cc40f4140a1278c408df8ef49bf8086ee7f37730d2eda8ce9402"
            }
          , `1.33` =
            { json =
                DhallInstallCommand
                  "json-"
                  "1.33.1"
                  "1.7.0"
                  "cc9fc70e492d35a3986183b589a435653e782f67cda51d33a935dff1ddd15aec"
            , yaml =
                DhallInstallCommand
                  "yaml-"
                  "1.33.1"
                  "1.2.0"
                  "4637cd9e3bd8b06875e3730edc4b07eac9035bc7632cc6840d3b0de497b1d856"
            , base =
                DhallInstallCommand
                  ""
                  "1.33.1"
                  "1.33.1"
                  "6e1073e4fb22e9f0663d71f977c4cd13d3635997988289f2c7604a0def84f609"
            }
          , cache =
              let DhallCacheCommand =
                    \(repo : Text) ->
                    \(tag : Text) ->
                    \(dest : Text) ->
                    \(env-name : Text) ->
                    \(env-val : Text) ->
                          "git clone --branch ${tag} --depth 1 ${repo} /usr/share/${dest} && "
                      ++  "mkdir -p /root/.cache && "
                      ++  ''
                          dhall hash <<< '/usr/share/${dest}/${env-val}'
                          ''
                      ++  "ENV ${env-name}=/usr/share/${dest}/${env-val}"

              in  { Prelude =
                      \(version : Text) ->
                        DhallCacheCommand
                          "https://github.com/dhall-lang/dhall-lang"
                          version
                          "dhall-lang"
                          "DHALL_PRELUDE"
                          "Prelude/package.dhall"
                  , Prometheus =
                      DhallCacheCommand
                        "https://github.com/TristanCacqueray/dhall-prometheus"
                        "master"
                        "dhall-prometheus"
                        "DHALL_PROMETHEUS"
                        "package.dhall"
                  , Ansible =
                      DhallCacheCommand
                        "https://github.com/TristanCacqueray/dhall-ansible"
                        "master"
                        "dhall-ansible"
                        "DHALL_ANSIBLE"
                        "package.dhall"
                  }
          }

in  { Commands }
