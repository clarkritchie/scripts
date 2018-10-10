# scripts
Miscellaneous scripts for this, that.

- `git-br-del.sh` -- used to cleanup old, stale Git branches
- `eb-cp-env.sh [from enviromnent] [to enviromnent]` -- outputs the `eb` command you can execute to copy all env vars from one ElasticBeanstalk environment to another, note: does not actually execute the command, excludes `SECRET_KEY_BASE`
