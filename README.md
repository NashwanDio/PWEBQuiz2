# GameVault - Video Game Collection Manager

A complete CRUD web application built with Java Servlets, JSP, and MySQL for tracking your video game collection, completion status, and ratings.

## Features

GameVault implements **8 Distinct SQL Database Operations** mapped to specific UI actions:

1. **Add to Collection** - Insert new games to your library (INSERT)
2. **The Library** - View all games in a responsive grid layout (SELECT *)
3. **Game Details** - View detailed information for a specific game (SELECT WHERE id = ?)
4. **Edit Details** - Update game progress, rating, and other details (UPDATE)
5. **Remove Game** - Delete games from your collection with confirmation (DELETE)
6. **Global Search** - Search games by title from the navbar (SELECT ... WHERE title LIKE ?)
7. **Filter by Status** - View games by status: Backlog, Playing, or Completed (SELECT ... WHERE status = ?)
8. **Sort by Rating** - Display games ordered by highest rating first (SELECT ... ORDER BY rating DESC)

## Tech Stack

- **Backend**: Java Servlets, JSP (Java Server Pages), JDBC
- **Database**: MySQL
- **Frontend**: HTML5, CSS3, Bootstrap 5, Font Awesome
- **Architecture**: MVC (Model-View-Controller)
- **Server**: Apache Tomcat / Jetty

## Project Structure

```
PWEBQuiz2/
├── database/
│   └── schema.sql                    # Database schema and sample data
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           ├── model/
│       │           │   └── Game.java              # Game entity model
│       │           ├── servlet/
│       │           │   └── GameServlet.java       # Main controller with 8 actions
│       │           └── util/
│       │               └── DBConnection.java      # Database connection utility
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml                        # Servlet configuration
│           ├── index.jsp                          # Main library view
│           ├── form.jsp                           # Add/Edit game form
│           └── details.jsp                        # Game details page
├── pom.xml                                        # Maven configuration
└── README.md                                      # This file
```

## Database Schema

The `games` table includes the following fields:

- `id` (INT, AUTO_INCREMENT, PRIMARY KEY)
- `title` (VARCHAR(255), NOT NULL)
- `platform` (VARCHAR(100), NOT NULL) - e.g., PC, PS5, Switch
- `genre` (VARCHAR(100), NOT NULL)
- `status` (ENUM: 'Backlog', 'Playing', 'Completed')
- `rating` (INT, 1-10)
- `release_year` (INT)
- `image_url` (VARCHAR(500))
- `created_at` (TIMESTAMP)
- `updated_at` (TIMESTAMP)

## Setup Instructions

### Prerequisites

- Java Development Kit (JDK) 8 or higher
- Apache Maven 3.6+
- MySQL Server 5.7+ or 8.0+
- Apache Tomcat 9+ or Jetty (for deployment)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/NashwanDio/PWEBQuiz2.git
   cd PWEBQuiz2
   ```

2. **Set up the database**
   ```bash
   # Login to MySQL
   mysql -u root -p
   
   # Run the schema script
   source database/schema.sql
   ```

3. **Configure database connection**
   
   Edit `src/main/java/com/example/util/DBConnection.java` and update the database credentials:
   ```java
   private static final String DB_URL = "jdbc:mysql://localhost:3306/gamevault?useSSL=false&serverTimezone=UTC";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "your_password";
   ```

4. **Build the project**
   ```bash
   mvn clean install
   ```

5. **Deploy the application**
   
   **Option A: Using Jetty (Development)**
   ```bash
   mvn jetty:run
   ```
   Then access the application at `http://localhost:8080/`

   **Option B: Using Tomcat**
   - Copy the generated WAR file from `target/myjspapp-1.0-SNAPSHOT.war` to your Tomcat `webapps/` directory
   - Start Tomcat
   - Access the application at `http://localhost:8080/myjspapp/`

## Usage

### Adding a New Game
1. Click the **"Add Game"** button in the navigation bar
2. Fill in the game details (title, platform, genre, status, rating, release year, and cover image URL)
3. Click **"Add Game"** to save

### Viewing Your Library
- The main page displays all your games in a beautiful grid layout
- Each card shows the game cover, title, platform, genre, status badge, and rating

### Searching for Games
- Use the search bar in the navigation bar to find games by title
- Results are displayed in real-time

### Filtering by Status
- Use the dropdown to filter games by status:
  - **Backlog** (games you plan to play)
  - **Playing** (currently playing)
  - **Completed** (finished games)

### Sorting by Rating
- Click the **"Sort by Rating"** button to view games ordered by highest rating first

### Viewing Game Details
- Click the **"Details"** button on any game card to see full information

### Editing a Game
- Click the **"Edit"** button on a game card or from the details page
- Update the fields you want to change
- Click **"Update Game"** to save changes

### Deleting a Game
- Click the **"Delete"** button on a game card or from the details page
- Confirm the deletion in the modal dialog

## Design Features

The application features a stunning **dark mode cyberpunk aesthetic**:

- **Color Scheme**: Dark grays with neon purple and blue accents
- **Layout**: Responsive grid system with beautiful game cards
- **Interactivity**: Hover effects with glow and elevation
- **Components**: 
  - Status badges (green for Completed, orange for Playing, red for Backlog)
  - Star ratings (1-10 scale)
  - Modal confirmations for destructive actions
- **Typography**: Clean, modern fonts with gradient effects
- **Icons**: Font Awesome for consistent iconography

## Dependencies

- `javax.servlet-api` 4.0.1 (provided)
- `javax.servlet.jsp-api` 2.3.3 (provided)
- `mysql-connector-java` 8.0.33
- `jstl` 1.2
- Bootstrap 5.3.0 (CDN)
- Font Awesome 6.4.0 (CDN)

## Contributing

Feel free to fork this repository and submit pull requests for any improvements!

## License

This project is open source and available under the MIT License.

## Author

NashwanDio

---

**Note**: This application demonstrates a complete MVC architecture with proper separation of concerns:
- **Model**: `Game.java` - Data representation
- **View**: JSP files - Presentation layer
- **Controller**: `GameServlet.java` - Business logic and request handling
