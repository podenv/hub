let OpenVPN =
          ../functions/mkSimpleEnv.dhall "openvpn" "VPN solutions"
      //  { syscaps = Some [ "NET_ADMIN", "SYS_RESOURCE" ]
          , packages = Some [ "openvpn", "iproute" ]
          , work-dir = Some "/root"
          , capabilities = (../schemas/Caps)::{
            , network = Some True
            , root = Some True
            , tun = Some True
            , seccomp = Some False
            , terminal = Some True
            , setuid = Some True
            }
          }

in  OpenVPN
