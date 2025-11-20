-- GameVault Database Schema
-- This script creates the database and table for the GameVault application

CREATE DATABASE IF NOT EXISTS gamedb;
USE gamedb;

CREATE TABLE IF NOT EXISTS games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    platform VARCHAR(100) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    status ENUM('Backlog', 'Playing', 'Completed') NOT NULL DEFAULT 'Backlog',
    rating INT CHECK (rating >= 1 AND rating <= 10),
    release_year INT,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sample data for testing
INSERT INTO games (title, platform, genre, status, rating, release_year, image_url) VALUES
('The Legend of Zelda: Breath of the Wild', 'Switch', 'Action-Adventure', 'Completed', 10, 2017, 'https://images.igdb.com/igdb/image/upload/t_cover_big/co3p2d.jpg'),
('Elden Ring', 'PC', 'RPG', 'Playing', 9, 2022, 'https://images.igdb.com/igdb/image/upload/t_cover_big/co4jni.jpg'),
('God of War Ragnarök', 'PS5', 'Action-Adventure', 'Completed', 9, 2022, 'https://images.igdb.com/igdb/image/upload/t_cover_big/co5s5v.jpg'),
('Cyberpunk 2077', 'PC', 'RPG', 'Backlog', 8, 2020, 'https://images.igdb.com/igdb/image/upload/t_cover_big/co2mwj.jpg'),
('Red Dead Redemption 2', 'PS5', 'Action-Adventure', 'Completed', 10, 2018, 'https://images.igdb.com/igdb/image/upload/t_cover_big/co1q1f.jpg');
