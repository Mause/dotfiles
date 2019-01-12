# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


function fish_prompt
    # display the status of the last run command
    if [ "$status" = "0" ]
        set_color green
    else
        set_color red
    end
    echo -n "•"
    set_color normal

    echo -n "<"

    # username
    set_color blue
    echo -n (whoami)

    set_color yellow
    echo -n "@"

    # hostname
    set_color red
    echo -n (hostname|cut -d . -f 1)

    set_color yellow
    echo -n ":"

    # current working directory
    set_color $fish_color_cwd
    if test (prompt_pwd);
        echo -n (prompt_pwd);
    else
        echo -n "/";
    end


    # git branch
    set_color normal
    printf '%s ' (__fish_git_prompt)
    echo -n '> '
end
