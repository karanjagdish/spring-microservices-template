-- Create schema
CREATE SCHEMA IF NOT EXISTS service2;

-- Create user table in service2 schema
CREATE TABLE service2.user (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
