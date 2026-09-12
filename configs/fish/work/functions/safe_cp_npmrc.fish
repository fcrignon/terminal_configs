function safe_cp_npmrc --description "Copie le .npmrc DOTT si on est dans un projet npm"
    if test -d "./node_modules"
        cp ~/workspace/Kering/dott/.npmrc .
        echo "✓ .npmrc copié avec succès"
    else
        echo "⚠ Attention : ce ne semble pas être un projet npm !"
        return 1
    end
end
