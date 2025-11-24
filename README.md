## Running the Project with Docker

This project provides Dockerfiles for both the backend (TypeScript, Node.js) and frontend (JavaScript, Vite) applications, as well as a Docker Compose configuration to orchestrate the services and a PostgreSQL database.

### Requirements
- **Node.js version:** 22.13.1 (as specified in Dockerfiles)
- **PostgreSQL:** The database service is included in the compose file

### Environment Variables
- The backend and frontend support `.env` files for configuration. Uncomment the `env_file` lines in `docker-compose.yml` if you need to pass custom environment variables.
- Default PostgreSQL credentials (set in compose file):
  - `POSTGRES_USER=postgres`
  - `POSTGRES_PASSWORD=postgres`
  - `POSTGRES_DB=ssb10`

### Build and Run Instructions
1. Ensure Docker and Docker Compose are installed.
2. From the project root, run:
   ```sh
   docker compose up --build
   ```
   This will build and start the following services:
   - **ts-backend** (Node.js backend)
   - **js-frontend** (Vite frontend)
   - **postgres** (PostgreSQL database)

### Service Ports
- **Backend API:** `3000` (http://localhost:3000)
- **Frontend (Vite preview):** `5173` (http://localhost:5173)
- **PostgreSQL:** `5432` (for local development)

### Special Configuration
- Persistent PostgreSQL data is stored in the `pgdata` Docker volume.
- Healthchecks are configured for the database to ensure service readiness.
- All services are connected via the `appnet` Docker network.
- Non-root users are used in both backend and frontend containers for security.

Refer to the individual `README.md` files in `packages/backend` and `packages/frontend` for more details on service-specific setup and usage.