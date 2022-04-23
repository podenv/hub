-- | The application runtime:
-- Image: an existing image ref
-- Nix: a nix expression
-- Container: a static container build
-- Rootfs: a local directory
< Image : Text
| Nix : Text
| Container : (./ContainerBuild.dhall).Type
| Rootfs : Text
>
