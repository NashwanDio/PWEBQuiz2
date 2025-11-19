package com.example.model;

import java.sql.Timestamp;

public class Game {
    private int id;
    private String title;
    private String platform;
    private String genre;
    private String status;
    private int rating;
    private int releaseYear;
    private String imageUrl;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Game() {
    }

    // Constructor with all fields except timestamps
    public Game(String title, String platform, String genre, String status, int rating, int releaseYear, String imageUrl) {
        this.title = title;
        this.platform = platform;
        this.genre = genre;
        this.status = status;
        this.rating = rating;
        this.releaseYear = releaseYear;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Game{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", platform='" + platform + '\'' +
                ", genre='" + genre + '\'' +
                ", status='" + status + '\'' +
                ", rating=" + rating +
                ", releaseYear=" + releaseYear +
                ", imageUrl='" + imageUrl + '\'' +
                '}';
    }
}
