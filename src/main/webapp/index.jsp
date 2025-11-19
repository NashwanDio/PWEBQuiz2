<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GameVault - Your Gaming Library</title>
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

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, var(--bg-dark) 0%, #1a1a2e 100%);
            color: var(--text-primary);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        /* Navbar Styling */
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
            margin: 0 0.5rem;
        }

        .nav-link:hover {
            color: var(--neon-purple) !important;
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--neon-purple), var(--neon-blue));
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(176, 38, 255, 0.4);
        }

        /* Search Bar */
        .search-container {
            position: relative;
        }

        .search-input {
            background: var(--bg-card);
            border: 2px solid rgba(176, 38, 255, 0.3);
            color: var(--text-primary);
            padding: 0.5rem 2.5rem 0.5rem 1rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            width: 300px;
        }

        .search-input:focus {
            border-color: var(--neon-purple);
            box-shadow: 0 0 15px rgba(176, 38, 255, 0.3);
            outline: none;
            background: var(--bg-secondary);
        }

        .search-btn {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            background: transparent;
            border: none;
            color: var(--neon-purple);
            padding: 0.5rem 1rem;
        }

        /* Filter & Sort Controls */
        .controls-section {
            background: var(--bg-secondary);
            padding: 1.5rem;
            border-radius: 15px;
            margin: 2rem 0;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .form-select {
            background: var(--bg-card);
            border: 2px solid rgba(176, 38, 255, 0.3);
            color: var(--text-primary);
            padding: 0.6rem 1rem;
            border-radius: 8px;
        }

        .form-select:focus {
            border-color: var(--neon-purple);
            box-shadow: 0 0 10px rgba(176, 38, 255, 0.3);
            background: var(--bg-secondary);
        }

        /* Game Cards */
        .game-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }

        .game-card {
            background: var(--bg-card);
            border-radius: 15px;
            overflow: hidden;
            position: relative;
            transition: all 0.4s ease;
            border: 2px solid transparent;
            cursor: pointer;
        }

        .game-card:hover {
            transform: translateY(-10px);
            border-color: var(--neon-purple);
            box-shadow: 0 15px 40px rgba(176, 38, 255, 0.4);
        }

        .game-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(176, 38, 255, 0.1), rgba(0, 212, 255, 0.1));
            opacity: 0;
            transition: opacity 0.4s ease;
            pointer-events: none;
        }

        .game-card:hover::before {
            opacity: 1;
        }

        .game-image {
            width: 100%;
            height: 350px;
            object-fit: cover;
            display: block;
        }

        .game-info {
            padding: 1.5rem;
        }

        .game-title {
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }

        .game-details {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .game-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
            color: var(--text-secondary);
        }

        /* Badges */
        .badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
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

        /* Rating Stars */
        .rating {
            color: #ffd700;
            font-size: 1.1rem;
        }

        .rating i {
            margin: 0 1px;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.85rem;
            transition: all 0.3s ease;
        }

        .btn-info {
            background: linear-gradient(135deg, var(--neon-blue), #00a8cc);
            border: none;
            color: white;
        }

        .btn-info:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 212, 255, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffaa00, #ff8800);
            border: none;
            color: white;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 170, 0, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff006e, #c9184a);
            border: none;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 0, 110, 0.4);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
        }

        .empty-state i {
            font-size: 5rem;
            color: var(--neon-purple);
            opacity: 0.3;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: var(--text-secondary);
            margin-bottom: 1rem;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .game-card {
            animation: fadeIn 0.5s ease forwards;
        }

        .game-card:nth-child(1) { animation-delay: 0.1s; }
        .game-card:nth-child(2) { animation-delay: 0.2s; }
        .game-card:nth-child(3) { animation-delay: 0.3s; }
        .game-card:nth-child(4) { animation-delay: 0.4s; }
        .game-card:nth-child(5) { animation-delay: 0.5s; }

        /* Delete Confirmation Modal */
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

        .close {
            color: var(--text-primary);
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="games">
                <i class="fas fa-gamepad"></i> GameVault
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="games?action=list">
                            <i class="fas fa-book"></i> Library
                        </a>
                    </li>
                </ul>
                <!-- Search Form -->
                <form class="d-flex search-container me-3" action="games" method="get">
                    <input type="hidden" name="action" value="search">
                    <input class="form-control search-input" type="search" name="query" placeholder="Search games..." 
                           value="${searchQuery}" aria-label="Search">
                    <button class="search-btn" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
                <a href="games?action=new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add Game
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid px-4">
        <!-- Filter & Sort Controls -->
        <div class="controls-section">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <label class="form-label"><i class="fas fa-filter"></i> Filter by Status:</label>
                    <select class="form-select" onchange="window.location.href='games?action=filter&status=' + this.value">
                        <option value="">All Games</option>
                        <option value="Backlog" ${filterStatus == 'Backlog' ? 'selected' : ''}>Backlog</option>
                        <option value="Playing" ${filterStatus == 'Playing' ? 'selected' : ''}>Playing</option>
                        <option value="Completed" ${filterStatus == 'Completed' ? 'selected' : ''}>Completed</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label"><i class="fas fa-sort"></i> Sort by:</label>
                    <button class="btn btn-primary w-100" onclick="window.location.href='games?action=sort'">
                        <i class="fas fa-star"></i> Sort by Rating
                    </button>
                </div>
                <div class="col-md-4">
                    <label class="form-label"><i class="fas fa-list"></i> Total Games:</label>
                    <div class="h4 text-center" style="color: var(--neon-purple);">
                        ${gameList != null ? gameList.size() : 0}
                    </div>
                </div>
            </div>
        </div>

        <!-- Game Grid -->
        <c:choose>
            <c:when test="${empty gameList}">
                <div class="empty-state">
                    <i class="fas fa-gamepad"></i>
                    <h3>No Games Found</h3>
                    <p>Start building your collection by adding your first game!</p>
                    <a href="games?action=new" class="btn btn-primary mt-3">
                        <i class="fas fa-plus"></i> Add Your First Game
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="game-grid">
                    <c:forEach var="game" items="${gameList}">
                        <div class="game-card">
                            <img src="${game.imageUrl}" alt="${game.title}" class="game-image" 
                                 onerror="this.src='https://via.placeholder.com/280x350/1e2344/b026ff?text=No+Image'">
                            <div class="game-info">
                                <h5 class="game-title">${game.title}</h5>
                                <div class="game-details">
                                    <div class="game-meta">
                                        <span><i class="fas fa-gamepad"></i> ${game.platform}</span>
                                        <span>${game.releaseYear}</span>
                                    </div>
                                    <div class="game-meta">
                                        <span><i class="fas fa-tag"></i> ${game.genre}</span>
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
                                    <div class="rating">
                                        <c:forEach begin="1" end="${game.rating}">
                                            <i class="fas fa-star"></i>
                                        </c:forEach>
                                        <c:forEach begin="${game.rating + 1}" end="10">
                                            <i class="far fa-star"></i>
                                        </c:forEach>
                                        <span class="ms-2">${game.rating}/10</span>
                                    </div>
                                </div>
                                <div class="action-buttons">
                                    <a href="games?action=details&id=${game.id}" class="btn btn-info btn-sm flex-fill">
                                        <i class="fas fa-info-circle"></i> Details
                                    </a>
                                    <a href="games?action=edit&id=${game.id}" class="btn btn-warning btn-sm flex-fill">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <button onclick="confirmDelete(${game.id}, '${game.title}')" 
                                            class="btn btn-danger btn-sm">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
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