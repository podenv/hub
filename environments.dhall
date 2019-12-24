{- A collection of environment templates.

   To be usable by podenv these records need an image or container-file attribute.

   Some environments, such as the PythonHTTPServer.Server, are functions that
   require parameters to be used.
-}
{ Chromium = ./environments/chromium.dhall
, Shell = ./environments/shell.dhall
, Pavucontrol = ./environments/pavucontrol.dhall
, Xeyes = ./environments/xeyes.dhall
, Mupdf = ./environments/mupdf.dhall
, Feh = ./environments/feh.dhall
, Inkscape = ./environments/inkscape.dhall
, Libreoffice = ./environments/libreoffice.dhall
, Mplayer = ./environments/mplayer.dhall
, Mumble = ./environments/mumble.dhall
, Node = ./environments/node.dhall
, Obs = ./environments/obs.dhall
, OpenVPN = ./environments/openvpn.dhall
, PythonHTTPServer = ./environments/python-http-server.dhall
, Tor = ./environments/tor.dhall
, Git = ./environments/git.dhall
, Emacs = ./environments/emacs.dhall
, Codium = ./environments/codium.dhall
, StreamTuner = ./environments/streamtuner.dhall
, Ssh = ./environments/ssh.dhall
, Firefox = ./environments/firefox.dhall
, YoutubeDL = ./environments/youtube-dl.dhall
}
