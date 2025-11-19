<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${game != null ? 'Edit Game' : 'Add New Game'} - GameVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-dark: #0a0e27;
            --bg-secondary: #151932;
            --bg-card: #1e2344;
            --neon-purple: #b026ff;
            --neon-blue: #00d4ff;
            --text-primary: #e8eaf6;
            --text-secondary: #9fa8da;
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

        .form-container {
            max-width: 800px;
            margin: 3rem auto;
            padding: 2rem;
            background: var(--bg-card);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(176, 38, 255, 0.2);
            border: 2px solid rgba(176, 38, 255, 0.3);
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-header h2 {
            background: linear-gradient(90deg, var(--neon-purple), var(--neon-blue));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: bold;
            font-size: 2.5rem;
        }

        .form-label {
            color: var(--text-primary);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            background: var(--bg-secondary);
            border: 2px solid rgba(176, 38, 255, 0.3);
            color: var(--text-primary);
            padding: 0.75rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            background: var(--bg-dark);
            border-color: var(--neon-purple);
            box-shadow: 0 0 15px rgba(176, 38, 255, 0.3);
            color: var(--text-primary);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
            opacity: 0.7;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--neon-purple), var(--neon-blue));
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(176, 38, 255, 0.4);
        }

        .btn-secondary {
            background: var(--bg-secondary);
            border: 2px solid rgba(176, 38, 255, 0.3);
            padding: 0.8rem 2rem;
            border-radius: 10px;
            color: var(--text-primary);
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-secondary:hover {
            background: var(--bg-dark);
            border-color: var(--neon-purple);
            color: var(--text-primary);
        }

        .input-group-text {
            background: var(--bg-secondary);
            border: 2px solid rgba(176, 38, 255, 0.3);
            border-right: none;
            color: var(--neon-purple);
        }

        .input-group .form-control {
            border-left: none;
        }

        .range-value {
            color: var(--neon-purple);
            font-size: 1.2rem;
            font-weight: bold;
        }

        option {
            background: var(--bg-card);
            color: var(--text-primary);
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

    <!-- Form Container -->
    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h2>
                    <i class="fas ${game != null ? 'fa-edit' : 'fa-plus-circle'}"></i>
                    ${game != null ? 'Edit Game' : 'Add New Game'}
                </h2>
            </div>

            <form action="games" method="post">
                <input type="hidden" name="action" value="${game != null ? 'update' : 'insert'}">
                <c:if test="${game != null}">
                    <input type="hidden" name="id" value="${game.id}">
                </c:if>

                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label for="title" class="form-label">
                            <i class="fas fa-heading"></i> Game Title *
                        </label>
                        <input type="text" class="form-control" id="title" name="title" 
                               value="${game != null ? game.title : ''}" 
                               placeholder="Enter game title" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="platform" class="form-label">
                            <i class="fas fa-gamepad"></i> Platform *
                        </label>
                        <select class="form-select" id="platform" name="platform" required>
                            <option value="">Select Platform</option>
                            <option value="PC" ${game != null && game.platform == 'PC' ? 'selected' : ''}>PC</option>
                            <option value="PS5" ${game != null && game.platform == 'PS5' ? 'selected' : ''}>PlayStation 5</option>
                            <option value="PS4" ${game != null && game.platform == 'PS4' ? 'selected' : ''}>PlayStation 4</option>
                            <option value="Xbox Series X" ${game != null && game.platform == 'Xbox Series X' ? 'selected' : ''}>Xbox Series X</option>
                            <option value="Xbox One" ${game != null && game.platform == 'Xbox One' ? 'selected' : ''}>Xbox One</option>
                            <option value="Switch" ${game != null && game.platform == 'Switch' ? 'selected' : ''}>Nintendo Switch</option>
                            <option value="Mobile" ${game != null && game.platform == 'Mobile' ? 'selected' : ''}>Mobile</option>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="genre" class="form-label">
                            <i class="fas fa-tag"></i> Genre *
                        </label>
                        <select class="form-select" id="genre" name="genre" required>
                            <option value="">Select Genre</option>
                            <option value="Action" ${game != null && game.genre == 'Action' ? 'selected' : ''}>Action</option>
                            <option value="Adventure" ${game != null && game.genre == 'Adventure' ? 'selected' : ''}>Adventure</option>
                            <option value="RPG" ${game != null && game.genre == 'RPG' ? 'selected' : ''}>RPG</option>
                            <option value="Action-Adventure" ${game != null && game.genre == 'Action-Adventure' ? 'selected' : ''}>Action-Adventure</option>
                            <option value="Shooter" ${game != null && game.genre == 'Shooter' ? 'selected' : ''}>Shooter</option>
                            <option value="Strategy" ${game != null && game.genre == 'Strategy' ? 'selected' : ''}>Strategy</option>
                            <option value="Sports" ${game != null && game.genre == 'Sports' ? 'selected' : ''}>Sports</option>
                            <option value="Racing" ${game != null && game.genre == 'Racing' ? 'selected' : ''}>Racing</option>
                            <option value="Puzzle" ${game != null && game.genre == 'Puzzle' ? 'selected' : ''}>Puzzle</option>
                            <option value="Horror" ${game != null && game.genre == 'Horror' ? 'selected' : ''}>Horror</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="status" class="form-label">
                            <i class="fas fa-list-check"></i> Status *
                        </label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="Backlog" ${game != null && game.status == 'Backlog' ? 'selected' : ''}>Backlog</option>
                            <option value="Playing" ${game != null && game.status == 'Playing' ? 'selected' : ''}>Playing</option>
                            <option value="Completed" ${game != null && game.status == 'Completed' ? 'selected' : ''}>Completed</option>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="releaseYear" class="form-label">
                            <i class="fas fa-calendar"></i> Release Year *
                        </label>
                        <input type="number" class="form-control" id="releaseYear" name="releaseYear" 
                               value="${game != null ? game.releaseYear : ''}" 
                               placeholder="e.g., 2023" min="1970" max="2030" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label for="rating" class="form-label">
                            <i class="fas fa-star"></i> Rating (1-10): <span class="range-value" id="ratingValue">${game != null ? game.rating : 5}</span>
                        </label>
                        <input type="range" class="form-range" id="rating" name="rating" 
                               value="${game != null ? game.rating : 5}" 
                               min="1" max="10" step="1" 
                               oninput="document.getElementById('ratingValue').textContent = this.value">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label for="imageUrl" class="form-label">
                            <i class="fas fa-image"></i> Cover Image URL
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-link"></i></span>
                            <input type="url" class="form-control" id="imageUrl" name="imageUrl" 
                                   value="${game != null ? game.imageUrl : ''}" 
                                   placeholder="https://example.com/game-cover.jpg">
                        </div>
                        <small class="text-secondary">Tip: You can find game covers on IGDB, Steam, or other gaming databases</small>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-6 mb-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas ${game != null ? 'fa-save' : 'fa-plus'}"></i>
                            ${game != null ? 'Update Game' : 'Add Game'}
                        </button>
                    </div>
                    <div class="col-md-6 mb-2">
                        <a href="games?action=list" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
