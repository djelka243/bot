
CREATE TABLE vendeurs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  telegram_chat_id VARCHAR(50) NOT NULL UNIQUE,
  nom_boutique VARCHAR(255) NOT NULL,
  description TEXT,
  telephone VARCHAR(20),
  adresse VARCHAR(255),
  cideasypay VARCHAR(255), 
  tokeneasypay VARCHAR(255),
  statut ENUM('en_attente','approuvé','rejeté') DEFAULT 'en_attente',
  date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories_vendeur (
  id INT AUTO_INCREMENT PRIMARY KEY,
  vendeur_id INT NOT NULL,
  nom VARCHAR(255) NOT NULL,
  FOREIGN KEY (vendeur_id) REFERENCES vendeurs(id) ON DELETE CASCADE
);

CREATE TABLE produits_vendeur (
  id INT AUTO_INCREMENT PRIMARY KEY,
  vendeur_id INT NOT NULL,
  categorie_id INT,
  nom VARCHAR(255) NOT NULL,
  description TEXT,
  prix DECIMAL(10,2) NOT NULL,
  taille VARCHAR(50),
  date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (vendeur_id) REFERENCES vendeurs(id) ON DELETE CASCADE,
  FOREIGN KEY (categorie_id) REFERENCES categories_vendeur(id) ON DELETE SET NULL
);

CREATE TABLE produit_image (
  id INT AUTO_INCREMENT PRIMARY KEY,
  produit_id INT NOT NULL,
  url_image VARCHAR(255) NOT NULL,
  date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (produit_id) REFERENCES produits_vendeur(id) ON DELETE CASCADE
);

CREATE TABLE commandes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  chat_id VARCHAR(50) NOT NULL,
  nom VARCHAR(255) NOT NULL,
  prenom VARCHAR(255) NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  produits TEXT NOT NULL,
  statut ENUM('en_attente','en_cours','livrée','annulée') DEFAULT 'en_attente',
  numero_commande VARCHAR(100) NOT NULL UNIQUE,
  adresse VARCHAR(255) NOT NULL,
  telephone VARCHAR(20) NOT NULL,
  date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (produit_id) REFERENCES produits_vendeur(id) ON DELETE CASCADE
  FOREIGN KEY (vendeur_id) REFERENCES vendeurs(id) ON DELETE CASCADE
);
