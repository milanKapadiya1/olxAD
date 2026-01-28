OLX App Clone (Flutter + Firebase)
This is a functional OLX-style mobile application built using Flutter with Firebase as the backend. The app replicates key marketplace features, allowing users to buy, sell, and manage ads with a focus on performance and user experience.

🔥 Features
Google Location Integration (New) The app now utilizes Google Location services to fetch and display ads relevant to the user's current area. This replaces static filtering with dynamic, real-world location based fetching.

Smart Favorites List (New) Users can "Like" ads to save them to their favorites. This feature is optimized for performance—taping "Like" updates the UI instantly without triggering a full page rebuild, ensuring a smooth scrolling experience.

Recently Viewed Items (New) Just like professional marketplace apps, this project tracks browsing history. It automatically saves and displays the items a user has recently visited for quick access.

Firebase Authentication Secure user registration and login using email/password. Google Sign-In is integrated for a seamless onboarding experience.

Create and Save Ads Users can create detailed ads which are stored in Cloud Firestore linked to their unique User ID.

In-Memory Caching To reduce network costs and improve speed, fetched ads are cached in memory. Switching tabs or navigating back does not re-fetch data unnecessarily.

🧩 State Management
The project is evolving to use more robust state handling techniques. The "Favorites" feature currently demonstrates efficient local state management to prevent unnecessary widget rebuilds. Future updates will fully migrate to BLoC or Provider for global app state.

☁️ Backend
Firebase Authentication (Identity Management)

Firebase Firestore (NoSQL Database for ads and user data)

📸 App Screenshots
<div align="center"> <img src="https://github.com/user-attachments/assets/f322c9f7-eb52-4b5a-8fa8-85e5ad17d252" width="23%" /> <img src="https://github.com/user-attachments/assets/d3cf9c98-99e7-4a04-a938-e11b2e381cc6" width="23%" /> <img src="https://github.com/user-attachments/assets/499850a4-5868-4433-84e1-399d7278d89b" width="23%" /> <img src="https://github.com/user-attachments/assets/fc19ca4e-3bca-45c8-9fbb-939fa5446c46" width="23%" /> </div>


<div align="center"> <img src="https://github.com/user-attachments/assets/a350d670-5e21-4640-b674-694a5784c93a" width="23%" /> <img src="https://github.com/user-attachments/assets/e4f33e1b-879c-447b-9f3d-8f7c71d00d48" width="23%" /> <img src="https://github.com/user-attachments/assets/57f9f39a-9131-47eb-893d-f830f03c6aa4" width="23%" /> <img src="https://github.com/user-attachments/assets/8d6ff619-eb2e-4e10-b49d-4b57cc4d420d" width="23%" /> </div>


<div align="center"> <img src="https://github.com/user-attachments/assets/864fcb3d-57e6-43b0-a88a-1ab30d5518eb" width="23%" /> <img src="https://github.com/user-attachments/assets/d15d759e-35e2-424c-a736-38a093585225" width="23%" /> <img src="https://github.com/user-attachments/assets/1e3876b1-53a7-4726-864d-4a84a4e117a2" width="23%" /> <img src="https://github.com/user-attachments/assets/9469581a-ac18-4903-911b-88316160fe0d" width="23%" /> </div>


<div align="center"> <img src="https://github.com/user-attachments/assets/97c2c827-35a2-4543-94cb-4a88c2ac89ef" width="23%" /> </div>

This project is in active development, focusing on clean architecture, scalable Firebase integration, and advanced Flutter UI patterns.
