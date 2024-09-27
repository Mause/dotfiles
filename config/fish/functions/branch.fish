function branch
    git switch -c (echo $argv | sed -E 's/[[:space:]]+/-/g')
end
