#!/bin/bash

# Déclaration des variables
# Ajustez ces chemins selon votre environnement Linux
work_dir="$(pwd)"  # Répertoire actuel du projet
web_apps="/home/timain/Documents/Bosse2/M.Tahina/tomcat/tomcat/webapps"  # Chemin vers le répertoire webapps de Tomcat (ajustez si nécessaire)
war_name="gestion-compagnie-aerienne"

echo "Déploiement de $war_name vers Tomcat..."

# Aller au répertoire du projet (si nécessaire, mais on suppose que le script est exécuté depuis là)
cd "$work_dir"

# Nettoyer les builds précédents
echo "Nettoyage des builds précédents..."
mvn clean

# Compiler et créer le WAR
echo "Compilation et création du WAR..."
mvn package -DskipTests

# Vérifier si la compilation a réussi
if [ $? -ne 0 ]; then
    echo "Erreur lors de la compilation Maven."
    read -p "Appuyez sur Entrée pour continuer..."
    exit 1
fi

# Supprimer l'ancien WAR et son dossier dans Tomcat si existants
echo "Suppression des anciens fichiers dans Tomcat..."
if [ -f "$web_apps/$war_name.war" ]; then
    rm -f "$web_apps/$war_name.war"
fi
if [ -d "$web_apps/$war_name" ]; then
    rm -rf "$web_apps/$war_name"
fi

# Copier le nouveau WAR vers le répertoire webapps de Tomcat
echo "Copie du WAR vers Tomcat..."
if [ -f "target/$war_name.war" ]; then
    cp "target/$war_name.war" "$web_apps/"
    echo "WAR déployé avec succès: $web_apps/$war_name.war"
else
    echo "Erreur: WAR non trouvé à target/$war_name.war"
    read -p "Appuyez sur Entrée pour continuer..."
    exit 1
fi

echo "Déploiement terminé."
echo "N'oubliez pas de redémarrer Tomcat pour charger la nouvelle application."
echo "L'application sera accessible à: http://localhost:8080/$war_name"
read -p "Appuyez sur Entrée pour continuer..."