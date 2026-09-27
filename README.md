# Factory Monitoring Pro
Complete owner-demo SaaS starter for factory monitoring.

## Run
1. Install Node.js 20+ and PostgreSQL.
2. Create database `factory_monitoring`.
3. Run `database/schema.sql`.
4. Copy `.env.example` to `.env` and edit DATABASE_URL/JWT_SECRET.
5. Run `npm install`.
6. Run `npm run dev`.
7. Open http://localhost:5173

Demo login: owner@demo.com / demo123

## Architecture
React/Vite -> Express API -> PostgreSQL
Simulator -> Machine API -> Dashboard

The simulator is demo data. Real PLC/CNC connectivity requires a site-specific gateway/connector.
