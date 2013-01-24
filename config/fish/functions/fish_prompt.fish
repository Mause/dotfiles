
function fish_prompt
    if test $status = 0
        set_color green
    else
        set_color red
    end
    echo -n "•"
    set_color normal
    echo -n "<"
    set_color blue
    echo -n (whoami)
    set_color yellow
    echo -n "@"
    set_color red
    echo -n (hostname|cut -d . -f 1)
    set_color yellow
    echo -n ":"
    set_color $fish_color_cwd
    if test (prompt_pwd);
        echo -n (prompt_pwd);
    else;
        echo -n "/";
    end;
    set_color normal
    echo -n (git_folder_status)
    echo -n '> '
end
