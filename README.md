# 📍 Local Marketplace (OLX Clone)

A simple, fast app for buying and selling items nearby. I built this because I wanted to create a marketplace that feels instant and handles location data properly, rather than just making a basic UI.

### 🚀 Key Features

* **Nearby Ads:** Automatically detects your city and shows you items listed nearby.
* **Instant Updates:** Favorites and listings update in real-time without needing to refresh.
* **Fast & Smooth:** Uses "lazy loading" and memory caching so the app stays fast, even with lots of photos.
* **Secure Login:** Support for both Google Sign-In and standard Email accounts.
* **Smart History:** Keeps track of your recently viewed ads locally so you can find them again quickly.

### 🏗️ How it’s Built (Technical Side)

I focused on writing "Clean Code" so the app is easy to update and doesn't crash:

* **Clean Architecture:** I split the app into three layers (Domain, Data, and Presentation). This keeps the business logic separate from the UI.
* **BLoC State Management:** This handles all the app logic behind the scenes, ensuring the UI only rebuilds when it absolutely has to.
* **Firebase Backend:** I used Firestore for the database, Firebase Auth for security, and Cloud Storage for user images.
* **Optimized Performance:** Images are compressed before uploading to save data and memory.



### 🛠️ Tech Stack

| Tool | What I used it for |
| :--- | :--- |
| **Flutter** | The main app framework |
| **BLoC** | Managing the app's state and logic |
| **Firebase** | Database, Photos, and User Accounts |
| **Google APIs** | Fetching and tagging locations |
| **SharedPrefs** | Storing "Recently Viewed" items locally |
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



