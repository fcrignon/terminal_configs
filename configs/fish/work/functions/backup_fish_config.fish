function backup_fish_config --description "Sauvegarde config.fish vers workspace"
    set backup_path ~/workspace/configs_backup/fish_config_backup.conf
    mkdir -p (dirname $backup_path)
    cp ~/.config/fish/config.fish $backup_path
    echo "✓ Config sauvegardé vers $backup_path"
end
