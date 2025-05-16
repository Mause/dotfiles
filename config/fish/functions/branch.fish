function branch
    git town append (echo $argv | sed -E 's/[[:space:]]+/-/g')
end
