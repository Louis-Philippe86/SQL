CREATE DATABASE IF NOT EXISTS zoo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE zoo;

-- Créer une table "chat" avec les colonnes spécifiées
CREATE TABLE chat (
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    yeux VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (id) 
);

-- Insérer des données dans la table "chat"
INSERT INTO chat (nom, yeux, age) VALUES 
('Maine coon', 'marron', 20),
('Siamois', 'bleu', 15),
('Bengal', 'marron', 18),
('Scottish', 'marron', 10);
