<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${game.title} - GameVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-dark: #0a0e27;
            --bg-secondary: #151932;
            --bg-card: #1e2344;
            --neon-purple: #b026ff;
            --neon-blue: #00d4ff;
            --neon-pink: #ff006e;
            --text-primary: #e8eaf6;
            --text-secondary: #9fa8da;
            --success: #00ff88;
            --warning: #ffaa00;
        }

        body {
            background: linear-gradient(135deg, var(--bg-dark) 0%, #1a1a2e 100%);
            color: var(--text-primary);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .navbar {
            background: rgba(21, 25, 50, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 30px rgba(176, 38, 255, 0.1);
            border-bottom: 1px solid rgba(176, 38, 255, 0.2);
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: bold;
            background: linear-gradient(90deg, var(--neon-purple), var(--neon-blue));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .navbar-brand i {
            color: var(--neon-purple);
            -webkit-text-fill-color: var(--neon-purple);
        }

        .nav-link {
            color: var(--text-secondary) !important;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--neon-purple) !important;
        }

        .details-container {
            max-width: 1200px;
            margin: 3rem auto;
            padding: 2rem;
        }

        .game-details-card {
            background: var(--bg-card);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(176, 38, 255, 0.3);
            border: 2px solid rgba(176, 38, 255, 0.3);
        }

        .game-header {
            position: relative;
            height: 400px;
            overflow: hidden;
        }

        .game-cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(0.7);
        }

        .game-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 2rem;
            background: linear-gradient(to top, rgba(10, 14, 39, 0.95), transparent);
        }

        .game-title {
            font-size: 3rem;
            font-weight: bold;
            background: linear-gradient(90deg, var(--neon-purple), var(--neon-blue));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
        }

        .game-content {
            padding: 2rem;
        }

        .info-section {
            margin-bottom: 2rem;
        }

        .info-label {
            color: var(--neon-purple);
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-value {
            color: var(--text-primary);
            font-size: 1.2rem;
            padding: 1rem;
            background: var(--bg-secondary);
            border-radius: 10px;
            border: 2px solid rgba(176, 38, 255, 0.2);
        }

        .badge {
            padding: 0.6rem 1.2rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1rem;
        }

        .badge-backlog {
            background: linear-gradient(135deg, #ff006e, #ff4d6d);
        }

        .badge-playing {
            background: linear-gradient(135deg, #ffaa00, #ffd000);
        }

        .badge-completed {
            background: linear-gradient(135deg, #00ff88, #00d4aa);
        }

        .rating-display {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stars {
            color: #ffd700;
            font-size: 1.5rem;
        }

        .rating-number {
            font-size: 2rem;
            font-weight: bold;
            color: var(--neon-purple);
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--neon-purple), var(--neon-blue));
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(176, 38, 255, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffaa00, #ff8800);
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 170, 0, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff006e, #c9184a);
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 0, 110, 0.4);
        }

        .btn-secondary {
            background: var(--bg-secondary);
            border: 2px solid rgba(176, 38, 255, 0.3);
            padding: 0.8rem 2rem;
            border-radius: 10px;
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: var(--bg-dark);
            border-color: var(--neon-purple);
            color: var(--text-primary);
        }

        .modal-content {
            background: var(--bg-card);
            border: 2px solid var(--neon-purple);
            color: var(--text-primary);
        }

        .modal-header {
            border-bottom: 1px solid rgba(176, 38, 255, 0.2);
        }

        .modal-footer {
            border-top: 1px solid rgba(176, 38, 255, 0.2);
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="games">
                <i class="fas fa-gamepad"></i> GameVault
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="games?action=list">
                            <i class="fas fa-book"></i> Library
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Game Details -->
    <div class="container details-container">
        <c:if test="${game != null}">
            <div class="game-details-card">
                <!-- Game Header with Cover Image -->
                <div class="game-header">
                    <img src="${game.imageUrl}" alt="${game.title}" class="game-cover"
                         onerror="this.src='https://via.placeholder.com/1200x400/1e2344/b026ff?text=${game.title}'">
                    <div class="game-overlay">
                        <h1 class="game-title">${game.title}</h1>
                    </div>
                </div>

                <!-- Game Content -->
                <div class="game-content">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-section">
                                <div class="info-label">
                                    <i class="fas fa-gamepad"></i> Platform
                                </div>
                                <div class="info-value">${game.platform}</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="info-section">
                                <div class="info-label">
                                    <i class="fas fa-tag"></i> Genre
                                </div>
                                <div class="info-value">${game.genre}</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-section">
                                <div class="info-label">
                                    <i class="fas fa-list-check"></i> Status
                                </div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${game.status == 'Backlog'}">
                                            <span class="badge badge-backlog">${game.status}</span>
                                        </c:when>
                                        <c:when test="${game.status == 'Playing'}">
                                            <span class="badge badge-playing">${game.status}</span>
                                        </c:when>
                                        <c:when test="${game.status == 'Completed'}">
                                            <span class="badge badge-completed">${game.status}</span>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="info-section">
                                <div class="info-label">
                                    <i class="fas fa-calendar"></i> Release Year
                                </div>
                                <div class="info-value">${game.releaseYear}</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="info-section">
                                <div class="info-label">
                                    <i class="fas fa-star"></i> Rating
                                </div>
                                <div class="info-value">
                                    <div class="rating-display">
                                        <div class="stars">
                                            <c:forEach begin="1" end="${game.rating}">
                                                <i class="fas fa-star"></i>
                                            </c:forEach>
                                            <c:forEach begin="${game.rating + 1}" end="10">
                                                <i class="far fa-star"></i>
                                            </c:forEach>
                                        </div>
                                        <span class="rating-number">${game.rating}/10</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <a href="games?action=list" class="btn btn-secondary flex-fill">
                            <i class="fas fa-arrow-left"></i> Back to Library
                        </a>
                        <a href="games?action=edit&id=${game.id}" class="btn btn-warning flex-fill">
                            <i class="fas fa-edit"></i> Edit Game
                        </a>
                        <button onclick="confirmDelete(${game.id}, '${game.title}')" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Delete Game
                        </button>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${game == null}">
            <div class="alert alert-danger text-center" role="alert">
                <h3><i class="fas fa-exclamation-triangle"></i> Game Not Found</h3>
                <p>The requested game could not be found.</p>
                <a href="games?action=list" class="btn btn-primary mt-3">
                    <i class="fas fa-arrow-left"></i> Return to Library
                </a>
            </div>
        </c:if>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete <strong id="gameToDelete"></strong>?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Delete</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(gameId, gameTitle) {
            document.getElementById('gameToDelete').textContent = gameTitle;
            document.getElementById('confirmDeleteBtn').href = 'games?action=delete&id=' + gameId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
