
function fish_prompt
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
    echo -n '> '
end
