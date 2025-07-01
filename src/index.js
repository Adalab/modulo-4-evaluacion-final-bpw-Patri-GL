const express = require("express");
const cors = require("cors");
const path = require("path");
const mysql = require("mysql2/promise");
require("dotenv").config();

// Server Variable
const server = express();

// Middlewares
server.use(cors());
server.use(express.json());

// Server Port
const port = process.env.PORT || 4000;
server.listen(port, () => {
  console.log(`Servidor iniciado <http://localhost:${port}>`);
});

server.get("/", (req, res) => {
  res.send("API is running! Try /api/simpsonsquotes");
});

// Database Connection
async function getConnection() {
  const connectionData = {
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_SCHEMA,
  };
  const connection = await mysql.createConnection(connectionData);
  await connection.connect();
  return connection;
}

// API Endpoints

server.get("/api/simpsonsquotes", async (req, res) => {
  let connection;
  try {
    // 1. Get a connection
    const connection = await getConnection();

    // 2. Execute a query
    const [rows] = await connection.query(`
      SELECT 
        q.id AS quote_id, 
        q.text AS quote_text, 
        q.description AS quote_description, 
        c.id AS character_id, 
        c.name AS character_name, 
        c.surname AS character_surname, 
        c.job AS character_job, 
        e.id AS episode_id, 
        e.title AS episode_title, 
        e.season, 
        e.episode_number, 
        e.emission_date  
      FROM 
        quotes q 
      JOIN 
        characters c ON q.characters_id = c.id 
      JOIN 
        episodes_has_characters ec ON c.id = ec.characters_id 
      JOIN 
      episodes e ON ec.episodes_id = e.id
    `);
    // 3. Close connection
    await connection.end();
    // 4. Send the data as JSON
    res.json({
      success: true,
      data: rows,
    });
  } catch (error) {
    console.error("Database error:", error);
    // Ensure connection is released even if error occurs
    if (connection) connection.release();
    res.status(500).json({
      success: false,
      error: "Failed to fetch quotes from the database.",
    });
  }
});

server.post("/api/simpsonsquotes", async (req, res) => {
  let connection;
  try {
    // 1. Get a connection
    const connection = await getConnection();

    // 2. Execute a query

    // 3. Close connection
    await connection.end();
    // 4. Send the data as JSON
    res.json({
      success: true,
      data: rows,
    });
  } catch (error) {
    console.error("Database error:", error);
    // Ensure connection is released even if error occurs
    if (connection) connection.release();
    res.status(500).json({
      success: false,
      error: "Failed to fetch quotes from the database.",
    });
  }
});
// SERVIDOR DE FICHEROS ESTÁTICOS

// server.use(express.static(path.join(__dirname, "../FRONTEND")));

// NO ENCONTRADO

server.use((req, res) => {
  res.status(404).json({ success: false, error: "Route not found" });
});
