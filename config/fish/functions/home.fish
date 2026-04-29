function home
    git stash
    git switch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    git pull
    git stash pop
end
