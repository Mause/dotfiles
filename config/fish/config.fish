function cls
    clear
end

set fish_git_dirty_color red

function parse_git_dirty
    git diff --quiet HEAD ^&-
    if test $status = 1
        echo -n (set_color $fish_git_dirty_color)"Δ"(set_color normal)
    end
end

function parse_git_branch
     echo -n (parse_git_dirty) (git branch | sed -rn 's/\* (\w+)/\1/p')
end


function git_folder_status
     if test -d .git
          echo -n "["(parse_git_branch)"]"
     end
end
