# 📝 NoToDo App – Flutter & SQLite

A fast, offline-first **No-To-Do mobile application** built using **Flutter** and **SQLite**.  
This app helps users track and manage the things they should *not* do, improving focus, habits, and productivity.

---

## 🚀 Features

- ➕ Add new No-To-Do items  
- ✏️ Update items using **Long Press**  
- 🗑️ Delete items instantly  
- 📋 View all saved items  
- 💾 Local storage using SQLite  
- ⚡ Real-time UI updates  
- 📱 Works fully offline  
- 🌙 Clean dark-themed interface  

---

## 🧠 Tech Stack

- **Flutter** (UI Framework)  
- **Dart** (Programming Language)  
- **SQLite** (Local Database)  
- **sqflite** (SQLite Plugin)  
- **path_provider** (Local storage path)  

---

## 📂 Project Structure

lib/
│
├── main.dart  
│
├── model/  
│   └── nodo_item.dart        # Data model and item UI  
│
├── ui/  
│   ├── home.dart  
│   └── notodo_screen.dart   # Main screen (List, Add, Update, Delete)  
│
├── util/  
│   ├── database_client.dart # SQLite database logic  
│   └── date_formatter.dart  

---

## 🗄️ Database Design

Database: `nodo_db.db`  
Table: `nodoTbl`

| Column | Type |
|--------|------|
| id | INTEGER (Primary Key) |
| itemName | TEXT |
| dateCreated | TEXT |

---

## 🔁 How the App Works

The app uses **SQLite + in-memory list + Flutter UI** to keep everything in sync.

### ➕ Adding an item
1. User enters text  
2. Data is saved into SQLite  
3. Data is added to memory list  
4. `setState()` rebuilds the UI  

### ✏️ Updating an item (Long Press)
1. User long-presses an item  
2. Edit dialog opens  
3. Updated text is saved to SQLite  
4. Memory list is updated  
5. UI refreshes automatically  

### 🗑️ Deleting an item
1. Item removed from SQLite  
2. Item removed from memory list  
3. `setState()` updates the screen instantly  

This creates a **Reactive Database-Driven UI**.

---

## 🖥️ Installation

1. Clone the repository
  https://github.com/abdulazizpatwary/notodo-app.git
2. Go to the project folder
3. Install dependencies
4. Run the app

---

## 📸 Screenshots
(Add screenshots here)

---

## 🧑‍💻 Developer

**Abdul Aziz Patwary (Aziz)**  
Flutter & Android Developer  

---
