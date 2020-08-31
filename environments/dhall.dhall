{- Some shell instruction to setup dhall-haskell in container -}

let Containerfile =
        env:DHALL_CONTAINERFILE sha256:9ee58096e7ab5b30041c2a2ff0cc187af5bff6b4d7a6be8a6d4f74ed23fe7cdf
      ? ~/src/softwarefactory-project.io/software-factory/dhall-containerfile/package.dhall sha256:9ee58096e7ab5b30041c2a2ff0cc187af5bff6b4d7a6be8a6d4f74ed23fe7cdf
      ? https://raw.githubusercontent.com/softwarefactory-project/dhall-containerfile/0.1.0/package.dhall sha256:9ee58096e7ab5b30041c2a2ff0cc187af5bff6b4d7a6be8a6d4f74ed23fe7cdf

let Text/concatSep = (../Prelude.dhall).Text.concatSep

let Package =
      { Type =
          { url : Text
          , version : Text
          , name : Text
          , env : Text
          , package : Text
          }
      }

let sfPackage =
      \(name : Text) ->
      \(upper-name : Text) ->
        { url = "https://github.com/softwarefactory-project/dhall-${name}"
        , version = "master"
        , name
        , env = "DHALL_${upper-name}"
        , package = "package.dhall"
        }

let Packages =
      { Prelude =
          \(version : Text) ->
            { url = "https://github.com/dhall-lang/dhall-lang"
            , version
            , name = "dhall-lang"
            , env = "DHALL_PRELUDE"
            , package = "Prelude/package.dhall"
            }
      , Kubernetes =
          \(version : Text) ->
            { url = "https://github.com/dhall-lang/dhall-kubernetes"
            , version
            , name = "dhall-kubernetes"
            , env = "DHALL_KUBERNETES"
            , package = "package.dhall"
            }
      , Podenv =
        { url = "https://github.com/podenv/hub"
        , version = "master"
        , name = "hub"
        , env = "DHALL_PODENV"
        , package = "package.dhall"
        }
      , Prometheus =
        { url = "https://github.com/TristanCacqueray/dhall-prometheus"
        , version = "master"
        , name = "dhall-prometheus"
        , env = "DHALL_PROMETHEUS"
        , package = "package.dhall"
        }
      , Ansible = sfPackage "ansible" "ANSIBLE"
      , Containerfile = sfPackage "containerfile" "CONTAINERFILE"
      , Zuul = sfPackage "zuul" "ZUUL"
      , Nodepool = sfPackage "nodepool" "NODEPOOL"
      , SoftwareFactory = sfPackage "software-factory" "SOFTWARE_FACTORY"
      }

let PackagesStatements =
      let mkStatements =
            \(pkg : Package.Type) ->
              let pkg-path = "/usr/share/${pkg.name}"

              in  { install =
                        Containerfile.run
                          "Cache ${pkg.name}"
                          [ "git clone --branch ${pkg.version} --depth 1 ${pkg.url} ${pkg-path}"
                          , "mkdir -p /root/.cache"
                          , "dhall hash <<< ${pkg-path}/${pkg.package}"
                          ]
                      # Containerfile.env
                          [ { mapKey = pkg.env
                            , mapValue = "/usr/share/${pkg.name}/${pkg.package}"
                            }
                          ]
                  }

      in  { Prelude =
              \(version : Text) -> mkStatements (Packages.Prelude version)
          , Kubernetes =
              \(version : Text) -> mkStatements (Packages.Kubernetes version)
          , Podenv = mkStatements Packages.Podenv
          , Prometheus = mkStatements Packages.Prometheus
          , Ansible = mkStatements Packages.Ansible
          , Containerfile = mkStatements Packages.Containerfile
          , Zuul = mkStatements Packages.Zuul
          , Nodepool = mkStatements Packages.Nodepool
          , SoftwareFactory = mkStatements Packages.SoftwareFactory
          }

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
                    [ "RUN curl -OL ${gh-url}/${version}/${dhall-name}-x86_64-linux.tar.bz2"
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
          , `1.34` =
            { json =
                DhallInstallCommand
                  "json-"
                  "1.34.1"
                  "1.7.1"
                  "37a7df3c0f1073cf58c0b28c13454f113a5a9af63913b9faf2a8928aa9d88293"
            , yaml =
                DhallInstallCommand
                  "yaml-"
                  "1.34.0"
                  "1.2.1"
                  "ecbc24e1e42c55a1681e5e7a1d69aa20603662bda4aee50dc019324a0866ba25"
            , docs = DhallInstallCommand "docs-" "1.34.0" "1.0.0" ""
            , base =
                DhallInstallCommand
                  ""
                  "1.34.0"
                  "1.34.0"
                  "962c53b7b9f55f5155aa1f309b26e065a51b027bb7bfb16965439dbdde94c458"
            }
          , cache =
              let DhallCacheCommand =
                    \(repo : Text) ->
                    \(tag : Text) ->
                    \(dest : Text) ->
                    \(env-name : Text) ->
                    \(env-val : Text) ->
                          "RUN git clone --branch ${tag} --depth 1 ${repo} /usr/share/${dest} && "
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
                  , Kubernetes =
                      \(version : Text) ->
                        DhallCacheCommand
                          "https://github.com/dhall-lang/dhall-kubernetes"
                          version
                          "dhall-kubernetes"
                          "DHALL_KUBERNETES"
                          "package.dhall"
                  , Podenv =
                      DhallCacheCommand
                        "https://github.com/podenv/hub"
                        "master"
                        "hub"
                        "DHALL_PODENV"
                        "package.dhall"
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

in  { Commands, Packages, PackagesStatements }
