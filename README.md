# scripts
Miscellaneous scripts for this, that.

- `git-br-del.sh` -- used to cleanup old, stale Git branches
- `eb-cp-env.sh [from enviromnent] [to enviromnent]` -- outputs the `eb` command you can execute to copy all env vars from one Elastic Beanstalk environment to another, note: does not actually execute the command, excludes `SECRET_KEY_BASE`
- `eb-dump-env.sh` to be run from the root of an ElasticBeanstalk project, prints out the environment variables for each Elastic Beanstalk environments to files named in the convention `[environment].env` -- can be useful when juggling _a lot_ of environments, each with _a lot_ of variables

### not really mine

- `aws-security.sh` is minor riff off of [this](https://gist.github.com/niraj-shah/567da4146fe2912bb6b4626bc71471ea#file-aws-security-sh) script, but with the CloudFlare IPs plucked dynamically (also a riff from [aws_security_group_update](https://github.com/swoodford/aws/blob/master/vpc-sg-import-rules-cloudflare.sh)), ever so slighly modified to a) get the Cludflare IPs dynamically and b) take the security group and port via argument, so you could do something like this:
```
#!/bin/bash
export SG="sg-02ecd4898470d576d"
./aws-security.sh $SG 80
./aws-security.sh $SG 443
# etc...
```
