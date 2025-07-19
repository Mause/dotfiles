function merge-upstream --argument-names branch
	set url (basename (git remote get-url origin))
 	if string match '*.git' -q $url
 	 	set url (string sub -e -4 $url)
 	end
	set url "/repos/Mause/$url/merge-upstream"
	echo $url
    set -q branch[1]; or set branch main
	gh api \
		--method POST \
		-H "Accept: application/vnd.github+json" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		$url \
        -f branch=$branch
end
