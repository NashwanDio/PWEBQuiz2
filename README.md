# My JSP App

## Overview
This is a simple Jakarta Server Pages (JSP) application that demonstrates how to create a web application using JSP and servlets. The application responds with "Hello World" when the servlet is accessed.

## Project Structure
```
myjspapp
├── src
│   └── main
│       ├── java
│       │   └── com
│       │       └── example
│       │           └── HelloServlet.java
│       └── webapp
│           ├── WEB-INF
│           │   └── web.xml
│           └── index.jsp
├── pom.xml
└── README.md
```

## Setup Instructions
1. **Clone the repository** or download the project files.
2. **Navigate to the project directory**:
   ```bash
   cd myjspapp
   ```
3. **Build the project** using Maven:
   ```bash
   mvn clean install
   ```
4. **Deploy the application** to a Jakarta EE compatible server (e.g., Apache Tomcat).
5. **Access the application** by navigating to `http://localhost:8080/myjspapp/index.jsp` in your web browser.

## Usage
- To see the "Hello World" message, click on the link provided in `index.jsp` which directs to the servlet mapped at `/greet`. 

## Dependencies
This project uses Maven for dependency management. Ensure you have Maven installed to build the project successfully.# PWEBQuiz2
