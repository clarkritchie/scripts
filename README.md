# scripts
Miscellaneous scripts for this, that.

- `git-br-del.sh` -- used to cleanup old, stale Git branches
- `eb-cp-env.sh [from enviromnent] [to enviromnent]` -- outputs the `eb` command you can execute to copy all env vars from one Elastic Beanstalk environment to another, note: does not actually execute the command, excludes `SECRET_KEY_BASE`
- `eb-dump-env.sh` to be run from the root of an ElasticBeanstalk project, prints out the environment variables for each Elastic Beanstalk environments to files named in the convention `[environment].env` -- can be useful when juggling _a lot_ of environments, each with _a lot_ of variables
