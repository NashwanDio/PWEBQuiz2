# GameVault - Complete Project Structure

## Directory Tree

```
PWEBQuiz2/
│
├── database/
│   └── schema.sql                         # Database schema with CREATE TABLE and sample data
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           │
│       │           ├── model/
│       │           │   └── Game.java      # Game entity model with getters/setters
│       │           │
│       │           ├── servlet/
│       │           │   └── GameServlet.java   # Main controller with 8 CRUD actions
│       │           │
│       │           └── util/
│       │               └── DBConnection.java  # JDBC database connection utility
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml                # Servlet configuration and mappings
│           │
│           ├── index.jsp                  # Main library view (dark mode design)
│           ├── form.jsp                   # Add/Edit game form
│           └── details.jsp                # Individual game details page
│
├── target/
│   └── myjspapp-1.0-SNAPSHOT.war          # Deployable WAR file (4.2 MB)
│
├── .gitignore                             # Git ignore file for build artifacts
├── pom.xml                                # Maven project configuration
└── README.md                              # Project documentation

```

## File Details & Purpose

### Backend (Java)

#### 1. **Game.java** (Model)
- **Location**: `src/main/java/com/example/model/Game.java`
- **Purpose**: Entity class representing a video game
- **Fields**:
  - `id` (int) - Primary key
  - `title` (String) - Game name
  - `platform` (String) - Gaming platform
  - `genre` (String) - Game genre
  - `status` (String) - Completion status (Backlog/Playing/Completed)
  - `rating` (int) - User rating (1-10)
  - `releaseYear` (int) - Year of release
  - `imageUrl` (String) - Cover image URL
  - `createdAt`, `updatedAt` (Timestamp) - Audit fields

#### 2. **GameServlet.java** (Controller)
- **Location**: `src/main/java/com/example/servlet/GameServlet.java`
- **Purpose**: Main controller handling all HTTP requests
- **URL Pattern**: `/games`
- **8 Distinct Actions**:
  1. `insertGame()` - INSERT new game (Action: "insert")
  2. `listGames()` - SELECT all games (Action: "list")
  3. `showGameDetails()` - SELECT specific game (Action: "details")
  4. `updateGame()` - UPDATE game info (Action: "update")
  5. `deleteGame()` - DELETE game (Action: "delete")
  6. `searchGames()` - SEARCH by title LIKE (Action: "search")
  7. `filterByStatus()` - FILTER by status (Action: "filter")
  8. `sortByRating()` - SORT by rating DESC (Action: "sort")

#### 3. **DBConnection.java** (Utility)
- **Location**: `src/main/java/com/example/util/DBConnection.java`
- **Purpose**: Database connection management
- **Features**:
  - JDBC driver initialization
  - Connection pooling (static methods)
  - Database credentials configuration
  - Connection closing utility

### Frontend (JSP)

#### 1. **index.jsp** (Main Library View)
- **Location**: `src/main/webapp/index.jsp`
- **Purpose**: Main dashboard displaying all games
- **Features**:
  - Responsive grid layout (280px min card width)
  - Dark mode cyberpunk theme
  - Global search bar in navbar
  - Filter by status dropdown
  - Sort by rating button
  - Game cards with hover effects
  - Delete confirmation modal
  - Bootstrap 5 & Font Awesome integration

#### 2. **form.jsp** (Add/Edit Form)
- **Location**: `src/main/webapp/form.jsp`
- **Purpose**: Form for creating new games or editing existing ones
- **Features**:
  - Dynamic form (creates vs updates based on `game` attribute)
  - Platform selection dropdown
  - Genre selection dropdown
  - Status selection (Backlog/Playing/Completed)
  - Rating slider (1-10 with live preview)
  - Release year input
  - Image URL input
  - Form validation

#### 3. **details.jsp** (Game Details)
- **Location**: `src/main/webapp/details.jsp`
- **Purpose**: Detailed view of a single game
- **Features**:
  - Full-screen cover image header
  - All game information displayed
  - Status badge with color coding
  - Star rating visualization
  - Action buttons (Edit, Delete, Back)
  - Delete confirmation modal

### Configuration

#### 1. **web.xml**
- **Location**: `src/main/webapp/WEB-INF/web.xml`
- **Purpose**: Servlet configuration
- **Mappings**:
  - `GameServlet` → `/games`
  - Welcome file: `games` (redirects to servlet)

#### 2. **pom.xml**
- **Location**: Root directory
- **Purpose**: Maven project configuration
- **Dependencies**:
  - `javax.servlet-api` 4.0.1 (provided)
  - `javax.servlet.jsp-api` 2.3.3 (provided)
  - `mysql-connector-java` 8.0.33
  - `jstl` 1.2
- **Plugins**:
  - `maven-compiler-plugin` 3.8.1 (Java 8)
  - `maven-war-plugin` 3.3.1
  - `jetty-maven-plugin` 9.4.53

### Database

#### **schema.sql**
- **Location**: `database/schema.sql`
- **Purpose**: MySQL database setup
- **Contents**:
  - CREATE DATABASE `gamevault`
  - CREATE TABLE `games` with all required fields
  - Sample INSERT statements (5 games)
  - Proper constraints (PRIMARY KEY, ENUM, CHECK)

## Design System

### Color Palette
```css
--bg-dark: #0a0e27           /* Main background */
--bg-secondary: #151932      /* Secondary background */
--bg-card: #1e2344           /* Card background */
--neon-purple: #b026ff       /* Primary accent */
--neon-blue: #00d4ff         /* Secondary accent */
--neon-pink: #ff006e         /* Danger/Error */
--text-primary: #e8eaf6      /* Main text */
--text-secondary: #9fa8da    /* Secondary text */
```

### Status Badge Colors
- **Backlog**: Red gradient (#ff006e → #ff4d6d)
- **Playing**: Orange gradient (#ffaa00 → #ffd000)
- **Completed**: Green gradient (#00ff88 → #00d4aa)

### Typography
- Font Family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif
- Headings: Bold with gradient text effects
- Body: Regular weight, high contrast

### Layout
- Grid System: Auto-fill with 280px minimum card width
- Gap: 2rem between cards
- Border Radius: 15px for cards, 10px for buttons
- Hover Effects: translateY(-10px) + glow shadow

## Build Artifacts

### WAR File
- **Name**: `myjspapp-1.0-SNAPSHOT.war`
- **Size**: 4.2 MB
- **Location**: `target/myjspapp-1.0-SNAPSHOT.war`
- **Includes**:
  - All compiled Java classes
  - All JSP files
  - All dependencies (MySQL connector, JSTL)
  - web.xml configuration

## Deployment

### Development Server (Jetty)
```bash
mvn jetty:run
# Access: http://localhost:8080/
```

### Production Server (Tomcat)
1. Copy `target/myjspapp-1.0-SNAPSHOT.war` to Tomcat `webapps/`
2. Start Tomcat
3. Access: `http://localhost:8080/myjspapp/`

## Database Setup

### Required Steps
1. Install MySQL 5.7+ or 8.0+
2. Login: `mysql -u root -p`
3. Run: `source database/schema.sql`
4. Verify: `USE gamevault; SHOW TABLES;`
5. Configure credentials in `DBConnection.java`

### Default Credentials
- **Database**: `gamevault`
- **Username**: `root`
- **Password**: `` (empty - change in DBConnection.java)
- **Host**: `localhost:3306`

## Key Features Summary

### 8 SQL Operations (Distinct)
1. **INSERT** - Add new game to collection
2. **SELECT *** - Display all games in library
3. **SELECT WHERE id = ?** - Show specific game details
4. **UPDATE** - Modify game information
5. **DELETE** - Remove game from collection
6. **SELECT ... WHERE title LIKE ?** - Search games by title
7. **SELECT ... WHERE status = ?** - Filter by completion status
8. **SELECT ... ORDER BY rating DESC** - Sort by highest rating

### UI/UX Highlights
- Dark mode cyberpunk aesthetic
- Responsive grid layout
- Hover animations and effects
- Modal confirmations for destructive actions
- Status badges with color coding
- Star rating visualization
- Search, filter, and sort capabilities
- Bootstrap 5 integration
- Font Awesome icons

## Architecture Pattern

**MVC (Model-View-Controller)**

- **Model**: `Game.java` - Data structure
- **View**: `*.jsp` files - Presentation layer
- **Controller**: `GameServlet.java` - Business logic

**Benefits**:
- Separation of concerns
- Easy to maintain and test
- Scalable architecture
- Clear data flow
