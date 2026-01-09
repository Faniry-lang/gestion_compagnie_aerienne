@echo off
setlocal enabledelayedexpansion

:: Déclaration des variables
set "work_dir=D:\itu\gestion_de_projet\gestion_compagnie_aerienne"
set "web_apps=C:\Users\ME-PC\Documents\apache-tomcat-10.1.50\apache-tomcat-10.1.50\webapps"
set "war_name=gestion-compagnie-aerienne"

echo Déploiement de %war_name% vers Tomcat...

:: Aller au répertoire du projet
cd /d "%work_dir%"

:: Nettoyer les builds précédents
echo Nettoyage des builds précédents...
call mvn clean

:: Compiler et créer le WAR
echo Compilation et création du WAR...
call mvn package -DskipTests

:: Vérifier si la compilation a réussi
if %ERRORLEVEL% neq 0 (
    echo Erreur lors de la compilation Maven.
    pause
    exit /b 1
)

:: Supprimer l'ancien WAR et son dossier dans Tomcat si existants
echo Suppression des anciens fichiers dans Tomcat...
if exist "%web_apps%\%war_name%.war" (
    del /f /q "%web_apps%\%war_name%.war"
)
if exist "%web_apps%\%war_name%" (
    rd /s /q "%web_apps%\%war_name%"
)

:: Copier le nouveau WAR vers le répertoire webapps de Tomcat
echo Copie du WAR vers Tomcat...
if exist "target\%war_name%.war" (
    copy /y "target\%war_name%.war" "%web_apps%\"
    echo WAR déployé avec succès: %web_apps%\%war_name%.war
) else (
    echo Erreur: WAR non trouvé à target\%war_name%.war
    pause
    exit /b 1
)

echo Déploiement terminé.
echo N'oubliez pas de redémarrer Tomcat pour charger la nouvelle application.
echo L'application sera accessible à: http://localhost:8080/%war_name%
pause