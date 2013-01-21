
function fish_prompt
    set_color blue
    whoami
    set_color yellow
    echo -n "@"
    set_color red
    hostname|cut -d . -f 1
    set_color yellow
    echo -n ":"
    set_color $fish_color_cwd
    if test (prompt_pwd);
        prompt_pwd;
    else;
        echo -n "/";
    end;
    set_color normal
    echo -n '> '
end
