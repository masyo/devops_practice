# elk

COOKBOOK for ELK Stack

TODO: Fix license issue 
workaround:

FIRST RUN ONLY 
1) `kitchen create`
2) `kitchen converge` 
3) `kitchen login`
4) `chef-solo`
5) accept license by typing yes and hitting enter
6) `exit`
7) `kitchen converge`
8) `kitchen verify`

Eeach following run unless you destroy VM.
1) `kitchen converge`
2) `kitchen verify`
