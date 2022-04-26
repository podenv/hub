-- | A podenv nix runtime description:
--
-- - `nixpkgs` is an optional pin for the main package set
--   when set, this is added to the nix command: ["--override-input" "nixpkgs" "${nixpkgs}"]
--   so that installables inputs share the same set.
--   This is necessary for nixGL, see: https://github.com/guibou/nixGL/pull/97
-- - `installables` is a list of nix flakes,
--   see: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix.html#installables
--
{ Type = { nixpkgs : Optional Text, installables : List Text }
, default.nixpkgs = None Text
}
