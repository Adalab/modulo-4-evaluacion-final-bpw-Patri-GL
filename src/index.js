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
    res.status(500).json({
      success: false,
      error: "Failed to fetch quotes from the database.",
    });
  }
});

server.post("/api/simpsonsquotes", async (req, res) => {
  let connection;
  try {
    // 1. Validate incoming data
    const { text, description, characters_id } = req.body;

    if (!text || !characters_id) {
      return res.status(400).json({
        success: false,
        error: "Missing required fields: text and characters_id",
      });
    }
    // 2. Get a connection
    const connection = await getConnection();

    // 3. Verify the character exists
    const [character] = await connection.query(
      "SELECT id FROM characters WHERE id = ?",
      [characters_id]
    );

    if (character.length === 0) {
      return res.status(404).json({
        success: false,
        error: "Character not found",
      });
    }

    // 4. Insert the new quote
    const [result] = await connection.query(
      "INSERT INTO quotes (text, description, characters_id) VALUES (?, ?, ?)",
      [text, description, characters_id]
    );
    const [newQuote] = await connection.query(
      "SELECT * FROM quotes WHERE id = ?",
      [result.insertId]
    );

    // 5. Send the data as JSON
    res.status(201).json({
      success: true,
      data: newQuote[0],
    });
    // 6. Close connection
    await connection.end();
  } catch (error) {
    console.error("Database error:", error);
    res.status(500).json({
      success: false,
      error: "Failed to fetch quotes from the database.",
    });
  }
});

server.get("/simpsonsquotes/:id", async (req, res) => {
  let connection;
  try {
    // 1. Get a connection
    const connection = await getConnection();

    // 2. Execute a query
    const [results] = await connection.query(
      `SELECT q.*, c.name AS character_name 
      FROM quotes q
      JOIN characters c ON q.characters_id = c.id
      WHERE q.id = ?`,
      [req.params.id]
    );
    // 3. What happens when the quote does not exist
    if (results.length === 0) {
      return res.status(404).json({
        success: false,
        error: "Quote not found",
      });
    }

    // 4. Send the data as JSON
    res.json({
      success: true,
      data: results[0],
    });
  } catch (error) {
    console.error("Database error:", error);
    res.status(500).json({
      success: false,
      error: "Failed to fetch quote from the database.",
    });
  }
  // 5. Close connection
  await connection.end();
});
// SERVIDOR DE FICHEROS ESTÁTICOS

// server.use(express.static(path.join(__dirname, "../FRONTEND")));

// NO ENCONTRADO

server.use((req, res) => {
  res.status(404).json({ success: false, error: "Route not found" });
});
