# Task Manager App

A mobile-first task manager built with **Flutter** (Android-focused) and an **Express** backend.  

The Flutter `lib` folder contains:
- **Screens**: Onboarding, Login & Registration, Home
- **Controllers**: Handle all state management for the app (no external state management tools used)

The backend (`express-server`) contains:
- **Routes**: Associated with each table in the database for querying
- **Data Access Layer (DAL)**: Intermediary between routes and database, contains functions used by the routes

The backend runs on **port 4001**.

---

## Project Structure
```
learn_flutter/
├─ express-server/
│  ├─ routes/                # Express routes for each database table
│  ├─ dal.js                  # Data Access Layer
│  └─ other backend files...
├─ lib/
│  ├─ features/
│  │  ├─ controllers/         # State management
│  │  └─ screens/              # Onboarding, Login/Registration, Home
│  └─ other Flutter files...
```

---

## Scripts

**Backend (Express)**
\`\`\`bash
# install dependencies
npm app.js

# start server
npm start
\`\`\`

**Flutter**
\`\`\`bash
# get dependencies
flutter pub get

# run app
flutter run
\`\`\`
