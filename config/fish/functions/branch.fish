function branch
    git switch -c (echo $argv | sed "s/\s/-/g")
end
