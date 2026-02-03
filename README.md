> **A high-performance, hyper-local marketplace engineered for real-time interaction and sub-second listing retrieval.**

---

## 📖 Project Overview

**The Vision:**
To architect a robust Consumer-to-Consumer (C2C) marketplace that connects buyers and sellers based on precise geo-location. Unlike simple UI replicas, this project focuses on **backend scalability** and **data efficiency**.

**The Engineering:**
Built using **Flutter** and **Clean Architecture**, this application solves the challenge of querying location-based data at scale. It leverages **Cloud Firestore** for real-time synchronization and **BLoC** for predictable state management, ensuring a crash-free experience even under heavy user load.

---

## 🏗️ Technical Architecture (The "Why" & "How")

### 1. Clean Architecture & Scalability
* **Separation of Concerns:** The app is strictly divided into **Domain**, **Data**, and **Presentation** layers. This ensures that business logic (like ad validation) is decoupled from UI code, making the app testable and maintainable.
* **Predictable State (BLoC):** utilized the BLoC pattern to manage complex states (Authentication flows, Listing uploads, Search filters), ensuring that UI rebuilds only happen when necessary to maintain 60 FPS performance.

### 2. Geo-Spatial Querying & Optimization
* **Location-Based Fetching:** Integrated Google Location Services to implement "Geo-Queries." Ads are not just fetched randomly; they are indexed by location, ensuring users only see relevant listings in their vicinity.
* **Read Optimization:** Implemented a **"Lazy Loading"** mechanism for the news feed to minimize Firebase reads and reduce cloud infrastructure costs.

### 3. Optimistic UI Updates
* **Instant Feedback:** The "Favorites" feature uses optimistic state updates—the UI updates immediately upon user interaction while the backend syncs in the background. This creates a perceived "zero-latency" experience.

---

## ✨ Key Features

### 📍 Core Functionality (Geo-Spatial Engine)
- **Dynamic Location Context:** automatically detects the user's region and queries the Firestore database for ads tagged with matching geo-coordinates.
- **Real-Time Feed:** Replaces static filtering with dynamic, real-world fetching that adapts as the user moves or changes location settings.
- **Smart Browsing History:** Tracks user engagement to populate a "Recently Viewed" section, utilizing local storage to reduce redundant network calls.

### 🛍️ Marketplace Essentials
- **Geo-Tagged Listing Creation:** Sellers can create detailed listings with images. **Ads are automatically indexed by location**, ensuring high visibility to relevant local buyers.
- **Secure Identity Management:** Robust authentication via **Firebase Auth** (Email/Password & Google Sign-In) ensures secure user sessions and profile protection.
- **Wishlist Retention:** A persistent "Favorites" system that syncs across devices, driving user retention and session length.

### 🚀 Performance & Caching
- **In-Memory Caching:** To prevent "read-heavy" billing on Firebase, fetched ads are cached in memory. Navigating between tabs (Home <-> Profile) does not trigger new database reads.
- **Image Optimization:** Handles high-resolution user uploads efficiently to prevent memory bloat and maintain smooth scrolling.

---

## 🛠️ Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Architecture** | Clean Architecture (Domain/Data/Presentation) |
| **State Management** | BLoC (Business Logic Component) |
| **Backend (BaaS)** | Firebase (Firestore, Auth, Storage) |
| **Location Services** | Google Geocoding API |
| **Local Storage** | [ SharedPrefs |

## 📸 App Screenshots

<div align="center">
  <img src="https://github.com/user-attachments/assets/f322c9f7-eb52-4b5a-8fa8-85e5ad17d252" width="23%" />
  <img src="https://github.com/user-attachments/assets/d3cf9c98-99e7-4a04-a938-e11b2e381cc6" width="23%" />
  <img src="https://github.com/user-attachments/assets/499850a4-5868-4433-84e1-399d7278d89b" width="23%" />
  <img src="https://github.com/user-attachments/assets/fc19ca4e-3bca-45c8-9fbb-939fa5446c46" width="23%" />
</div>
<br>
<div align="center">
  <img src="https://github.com/user-attachments/assets/a350d670-5e21-4640-b674-694a5784c93a" width="23%" />
  <img src="https://github.com/user-attachments/assets/e4f33e1b-879c-447b-9f3d-8f7c71d00d48" width="23%" />
  <img src="https://github.com/user-attachments/assets/57f9f39a-9131-47eb-893d-f830f03c6aa4" width="23%" />
  <img src="https://github.com/user-attachments/assets/8d6ff619-eb2e-4e10-b49d-4b57cc4d420d" width="23%" />
</div>
<br>
<div align="center">
  <img src="https://github.com/user-attachments/assets/864fcb3d-57e6-43b0-a88a-1ab30d5518eb" width="23%" />
  <img src="https://github.com/user-attachments/assets/d15d759e-35e2-424c-a736-38a093585225" width="23%" />
  <img src="https://github.com/user-attachments/assets/1e3876b1-53a7-4726-864d-4a84a4e117a2" width="23%" />
  <img src="https://github.com/user-attachments/assets/9469581a-ac18-4903-911b-88316160fe0d" width="23%" />
</div>
<br>
<div align="center">
    <img src="https://github.com/user-attachments/assets/97c2c827-35a2-4543-94cb-4a88c2ac89ef" width="23%" />
    <img src="https://github.com/user-attachments/assets/e8ddae51-e2bd-47e4-a2c7-a71d783a8c0b" width="23%" />
    <img src="https://github.com/user-attachments/assets/5c5d0b44-65c9-416a-941f-cb459dab58b8" width="23%" />
</div>

