package com.example.servlet;

import com.example.model.Game;
import com.example.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GameServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listGames(request, response);
                    break;
                case "details":
                    showGameDetails(request, response);
                    break;
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteGame(request, response);
                    break;
                case "search":
                    searchGames(request, response);
                    break;
                case "filter":
                    filterByStatus(request, response);
                    break;
                case "sort":
                    sortByRating(request, response);
                    break;
                default:
                    listGames(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insert":
                    insertGame(request, response);
                    break;
                case "update":
                    updateGame(request, response);
                    break;
                default:
                    listGames(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Action 1: Add to Collection (INSERT)
    private void insertGame(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        String title = request.getParameter("title");
        String platform = request.getParameter("platform");
        String genre = request.getParameter("genre");
        String status = request.getParameter("status");
        int rating = Integer.parseInt(request.getParameter("rating"));
        int releaseYear = Integer.parseInt(request.getParameter("releaseYear"));
        String imageUrl = request.getParameter("imageUrl");

        String sql = "INSERT INTO games (title, platform, genre, status, rating, release_year, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, title);
            stmt.setString(2, platform);
            stmt.setString(3, genre);
            stmt.setString(4, status);
            stmt.setInt(5, rating);
            stmt.setInt(6, releaseYear);
            stmt.setString(7, imageUrl);
            
            stmt.executeUpdate();
        }

        response.sendRedirect("games?action=list");
    }

    // Action 2: The Library - Display all games (SELECT *)
    private void listGames(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Game> gameList = new ArrayList<>();
        String sql = "SELECT * FROM games";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Game game = extractGameFromResultSet(rs);
                gameList.add(game);
            }
        }

        request.setAttribute("gameList", gameList);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    // Action 3: Game Details - Show specific game (SELECT WHERE id = ?)
    private void showGameDetails(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Game game = null;
        String sql = "SELECT * FROM games WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                game = extractGameFromResultSet(rs);
            }
        }

        request.setAttribute("game", game);
        request.getRequestDispatcher("/details.jsp").forward(request, response);
    }

    // Action 4: Edit Details - Update game (UPDATE)
    private void updateGame(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String platform = request.getParameter("platform");
        String genre = request.getParameter("genre");
        String status = request.getParameter("status");
        int rating = Integer.parseInt(request.getParameter("rating"));
        int releaseYear = Integer.parseInt(request.getParameter("releaseYear"));
        String imageUrl = request.getParameter("imageUrl");

        String sql = "UPDATE games SET title = ?, platform = ?, genre = ?, status = ?, rating = ?, release_year = ?, image_url = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, title);
            stmt.setString(2, platform);
            stmt.setString(3, genre);
            stmt.setString(4, status);
            stmt.setInt(5, rating);
            stmt.setInt(6, releaseYear);
            stmt.setString(7, imageUrl);
            stmt.setInt(8, id);
            
            stmt.executeUpdate();
        }

        response.sendRedirect("games?action=list");
    }

    // Action 5: Remove Game (DELETE)
    private void deleteGame(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String sql = "DELETE FROM games WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }

        response.sendRedirect("games?action=list");
    }

    // Action 6: Global Search (SELECT ... WHERE title LIKE ?)
    private void searchGames(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String searchQuery = request.getParameter("query");
        List<Game> gameList = new ArrayList<>();
        String sql = "SELECT * FROM games WHERE title LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + searchQuery + "%");
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Game game = extractGameFromResultSet(rs);
                gameList.add(game);
            }
        }

        request.setAttribute("gameList", gameList);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    // Action 7: Filter by Status (SELECT ... WHERE status = ?)
    private void filterByStatus(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        String status = request.getParameter("status");
        List<Game> gameList = new ArrayList<>();
        String sql = "SELECT * FROM games WHERE status = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Game game = extractGameFromResultSet(rs);
                gameList.add(game);
            }
        }

        request.setAttribute("gameList", gameList);
        request.setAttribute("filterStatus", status);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    // Action 8: Sort by Rating (SELECT ... ORDER BY rating DESC)
    private void sortByRating(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Game> gameList = new ArrayList<>();
        String sql = "SELECT * FROM games ORDER BY rating DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Game game = extractGameFromResultSet(rs);
                gameList.add(game);
            }
        }

        request.setAttribute("gameList", gameList);
        request.setAttribute("sortedByRating", true);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    // Show form for creating new game
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/form.jsp").forward(request, response);
    }

    // Show form for editing existing game
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Game game = null;
        String sql = "SELECT * FROM games WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                game = extractGameFromResultSet(rs);
            }
        }

        request.setAttribute("game", game);
        request.getRequestDispatcher("/form.jsp").forward(request, response);
    }

    // Helper method to extract Game object from ResultSet
    private Game extractGameFromResultSet(ResultSet rs) throws SQLException {
        Game game = new Game();
        game.setId(rs.getInt("id"));
        game.setTitle(rs.getString("title"));
        game.setPlatform(rs.getString("platform"));
        game.setGenre(rs.getString("genre"));
        game.setStatus(rs.getString("status"));
        game.setRating(rs.getInt("rating"));
        game.setReleaseYear(rs.getInt("release_year"));
        game.setImageUrl(rs.getString("image_url"));
        game.setCreatedAt(rs.getTimestamp("created_at"));
        game.setUpdatedAt(rs.getTimestamp("updated_at"));
        return game;
    }
}
