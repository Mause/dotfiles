function cls
    clear
end

function sshn
    sudo shutdown -h now
end

set PATH /home/dominic/.google_appengine $PATH
set fish_git_dirty_color red
set fish_git_clean_color green

function parse_git_status
     git diff --quiet HEAD ^&-
     if test $status = 1
          set_color $fish_git_dirty_color
     else
          set_color $fish_git_clean_color
     end
     echo -n (git branch | sed -rn 's/\* (\w+)/\1/p')
     set_color normal
end


function git_folder_status
     if test -d .git
          echo -n "["(parse_git_status)"]"
     end
end

