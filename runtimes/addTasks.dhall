let addTasks
    :     forall (tasks : Optional (List ../types/Task))
      ->  forall (new-tasks : List ../types/Task)
      ->  Optional (List ../types/Task)
    =     \(tasks : Optional (List ../types/Task))
      ->  \(new-tasks : List ../types/Task)
      ->  Some
            (   ../functions/optionalTaskList.dhall
                  tasks
                  ([] : List ../types/Task)
              # new-tasks
            )

in  addTasks
