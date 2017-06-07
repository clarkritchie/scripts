#!/bin/bash
# a quick and dirty script to delete old/stale git branches both
# locally and on my remote
# always skips master!


git checkout master
branches=()
eval "$(git for-each-ref --shell --format='branches+=(%(refname))' refs/heads/)"
for branch in "${branches[@]}"; do
	branch=$(basename $branch)
	if [[ $branch == "master" ]]
	then
		echo "**************************************************";
		echo "                 Skipping master";
		echo "**************************************************";
	else
		read -p "Delete $branch " -n 1 -r
		echo # (optional) move to anew line
		if [[ $REPLY =~ ^[Qq]$ ]]
		then
			exit
		else
			if [[ $REPLY =~ ^[Yy]$ ]]
			then
				git branch -D $branch
				git push origin :$branch
   			else
    			echo "Skipping $branch..."
			fi
		fi
	fi
done
exit