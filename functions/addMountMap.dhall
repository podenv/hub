let addMountMap =
          \(mountPoint : Text)
      ->  ./addMount.dhall
            { host-path = mountPoint, container-path = mountPoint }

in  addMountMap
