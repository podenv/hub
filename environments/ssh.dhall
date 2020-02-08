let Client =
          ../functions/capNetssh.dhall
            (../functions/mkSimpleTerminalEnv.dhall "ssh" "OpenSSH client")
      //  { packages = Some [ "openssh-clients" ] }

let Task = (../Podenv.dhall).Schemas.Task

let Vpn =
          \(local-ip : Text)
      ->  \(remote-ip : Text)
      ->  \(remote-tun : Natural)
      ->  \(remote-user : Text)
      ->  \(remote-host : Text)
      ->      Client
          //  { description = Some
                  "Point-To-Point ssh tunel with ${remote-host}"
              , name = "sshvpn"
              , capabilities = (../schemas/Caps)::(     Client.capabilities
                                                    //  { tun = Some True }
                                                  )
              , syscaps = Some [ "NET_ADMIN", "SYS_RESOURCE" ]
              , add-hosts = Some [ { Name = remote-host, IP = remote-ip } ]
              , pre-tasks =
                  let tun = "tun${Natural/show remote-tun}"

                  in  Some
                        [ Task::{
                          , name = Some "Creating local tun"
                          , unless = Some "ip link show tun1"
                          , shell = Some
                              ''
                              ip tuntap add dev tun1 mode tun user fedora;
                              ip addr add ${local-ip}/30 dev tun1;
                              ip link set tun1 mtu 9000 up
                              ''
                          }
                        , Task::{
                          , name = Some "Creating remote tun"
                          , unless = Some
                              "ssh ${remote-user}@${remote-host} /sbin/ip link show ${tun}"
                          , shell = Some
                              ''
                              ssh -t ${remote-user}@${remote-host} "
                                if ! sudo grep -q 'PermitTunnel\syes' /etc/ssh/sshd_config; then
                                    echo 'PermitTunnel yes' | sudo tee -a /etc/ssh/sshd_config;
                                    sudo systemctl restart sshd;
                                fi;
                                sudo ip tuntap add dev ${tun} mode tun user ${remote-user};
                                sudo ip addr add ${remote-ip}/30 dev ${tun};
                                sudo ip link set ${tun} mtu 9000 up"
                              ''
                          }
                        ]
              , network = Some remote-host
              , packages = Some
                  (   ../runtimes/getPackages.dhall Client.packages
                    # [ "iproute" ]
                  )
              , command = Some
                  [ "ssh"
                  , "-w"
                  , "1:${Natural/show remote-tun}"
                  , "${remote-user}@${remote-host}"
                  ]
              }

let VpnTemplates = { Slot1 = Vpn "172.30.1.1" "172.30.1.2" 1 }

in  { Vpn =
        { Create = Vpn
        , Slot1 = VpnTemplates.Slot1
        , CentOS = VpnTemplates.Slot1 "centos"
        , Fedora = VpnTemplates.Slot1 "fedora"
        }
    , Client = Client
    }
