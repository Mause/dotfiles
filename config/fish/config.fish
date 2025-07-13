function sshn
    sudo shutdown -h now
end

if status --is-interactive
	direnv hook fish | source
	git town completions fish | source
end

