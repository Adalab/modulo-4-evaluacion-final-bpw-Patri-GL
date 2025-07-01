const express = require("express");
const cors = require("cors");
const path = require("path");
const mysql = require("mysql2/promise");

// const data = require("./data/items.json");
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
  res.json({
    success: true,
    cosas: [{}, {}],
  });
  const conn = await getConnection();
});

// SERVIDOR DE FICHEROS ESTÁTICOS

// server.use(express.static(path.join(__dirname, "../FRONTEND")));

// NO ENCONTRADO

server.use((req, res) => {
  res.status(404).json({ success: false, error: "Route not found" });
});
