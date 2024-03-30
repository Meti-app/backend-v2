FROM --platform=linux/amd64 node:20 as builder

# Définir le répertoire de travail dans l'image
WORKDIR /app

# Copier les fichiers du projet
COPY package.json ./

RUN yarn install --frozen-lockfile

# Copier le reste des fichiers de l'application
COPY . .

RUN yarn build
# Construire l'application

# Étape 2 : Utiliser une image légère pour exécuter l'application
FROM node:20-slim

# Définir le répertoire de travail dans l'image finale
WORKDIR /app
# Copier les fichiers construits à partir de l'étape précédente
COPY --from=builder /app .
RUN ls


# Exposer le port d'écoute de l'application (si nécessaire)
# EXPOSE 3000

# Commande pour démarrer l'application
#CMD ["sleep", "3600"]
CMD ["node", "dist/main.js"]
