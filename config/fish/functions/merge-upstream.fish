function merge-upstream
	set url (basename (pwd))
	set url "/repos/Mause/$url/merge-upstream"
	echo $url
	gh api \
		--method POST \
		-H "Accept: application/vnd.github+json" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		$url \
		-f branch='main'
end
