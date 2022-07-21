-- | The environment display:
-- Host: the localhost display
-- Headless: a virtual display
-- HostHeadless: a virtual display, shared with the host
< Host
| Headless : (./Application.dhall).Type
| HostHeadless : (./Application.dhall).Type
>
