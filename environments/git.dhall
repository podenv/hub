let Git =
          ../functions/mkSimpleEnv.dhall "git" "Git command line"
      //  { capabilities =
              (../schemas/Caps)::{
              , editor = Some True
              , git = Some True
              , mount-cwd = Some True
              , terminal = Some True
              }
          }

let Pull =
          ../functions/capNetssh.dhall Git
      //  { name = "git-pull", command = Some [ "git", "pull" ] }

let PullRequest =
          ../functions/addPackages.dhall [ "git-pull-request" ] Pull
      //  { name = "git-pull-request"
          , description = Some "Submit github/pagure PR"
          , command = Some [ "git-pull-request", "--no-comment-on-update" ]
          }

let Review =
          ../functions/addPackages.dhall [ "git-review" ] Pull
      //  { name = "git-review"
          , description = Some "Submit gerrit CR"
          , command = Some [ "git-review" ]
          }

in  { Git = Git, Pull = Pull, PullRequest = PullRequest, Review = Review }
