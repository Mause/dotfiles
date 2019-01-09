# Defined in - @ line 1
function gettoken
	kubectl -n kube-system get secret (kubectl -n kube-system get secret | grep admin-user | grep kuber | awk '{print $1}') -o json | jq '.data.token' -r
end
