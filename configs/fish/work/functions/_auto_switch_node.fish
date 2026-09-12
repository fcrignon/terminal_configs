function _auto_switch_node --on-variable PWD --description "Switch node version via .nvmrc"
    # Guard : nvm doit être disponible
    if not functions -q nvm
        return
    end
    set dir $PWD
    while test -n "$dir"
        if test -f "$dir/.nvmrc"
            set _nvmrc_version (string trim (cat "$dir/.nvmrc") | string replace -r '[^0-9.]' '')
            if test -n "$_nvmrc_version"
                nvm use $_nvmrc_version 2>/dev/null
            end
            return
        end
        set dir (dirname "$dir")
        if test "$dir" = "/"
            break
        end
    end
end
