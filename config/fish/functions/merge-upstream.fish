function merge-upstream --argument-names branch
	set url (basename (pwd))
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
