if test $TERM "xterm" then
    if test $COLORTERM then
        if test $XTERM_VERSION then
            echo "Warning: Terminal wrongly calling itself 'xterm'.";
        else
            switch $XTERM_VERSION
                case "XTerm(256)"
                    set TERM "xterm-256color"
                case "XTerm(88)"
                    set TERM "xterm-88color"
                case "XTerm"
                case *
                    echo "Warning: Unrecognized XTERM_VERSION: $XTERM_VERSION"
            end
        end
    else
        switch $COLORTERM
            case gnome-terminal
                # Those crafty Gnome folks require you to check COLORTERM,
                # but don't allow you to just *favor* the setting over TERM.
                # Instead you need to compare it and perform some guesses
                # based upon the value. This is, perhaps, too simplistic.
                set TERM "gnome-256color";
            case *
                echo "Warning: Unrecognized COLORTERM: $COLORTERM";
        end
    end
end

set PATH /home/dominic/.google_appengine $PATH
set fish_git_dirty_color red
set fish_git_clean_color green
set fish_greeting ""

function cls
    clear
end

function sshn
    sudo shutdown -h now
end

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

