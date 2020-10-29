(../schemas/Env)::{
, name = "spice-gtk"
, description = Some "Spice client"
, url = Some "https://www.spice-space.org"
, packages = Some [ "spice-gtk3", "spice-gtk-tools" ]
, command = Some
  [ "sh"
  , "-c"
  ,     "mkdir -p ~/.config/spicy && echo W2dlbmVyYWxdCmdyYWIta2V5Ym9hcmQ9dHJ1ZQpncmFiLW1vdXNlPWZhbHNlCnNjYWxpbmc9ZmFsc2UKYXV0by1jb"
    ++  "GlwYm9hcmQ9ZmFsc2UKc3luYy1tb2RpZmllcnM9ZmFsc2UKcmVzaXplLWd1ZXN0PWZhbHNlCgpbdWldCnRvb2xiYXI9ZmFsc2UKc3RhdHVzYmFyPXRydWUK"
    ++  " | base64 -d > ~/.config/spicy/settings && spicy \$*"
  , "bash"
  ]
, capabilities = (../schemas/Caps)::{ x11 = Some True, network = Some True }
}
