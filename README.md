📍 Local Marketplace App (OLX Clone)A location-based C2C marketplace where users can buy and sell items within their own city. This project isn't just a UI clone—it’s built to handle real-world data efficiently using a professional-grade architecture.🚀 What this app doesSmart Location Ads: Automatically detects where you are and shows you ads from nearby sellers.Real-Time Updates: Uses Firebase to make sure new listings and "Favorites" update instantly without refreshing.Secure Login: Users can sign up quickly using Google Sign-In or their Email.Recently Viewed: Keeps track of what you've looked at (stored locally) so you can find it again easily.Smooth Scrolling: Implemented "lazy loading" so the app stays fast even if there are hundreds of listings.Ad Posting: Sellers can upload images and details, which are automatically tagged with their location.🏗️ How it’s builtI chose a professional setup to keep the code clean and the app fast:Clean Architecture: I split the app into three layers (Domain, Data, and Presentation). This makes it much easier to fix bugs or add new features later without breaking the whole app.BLoC State Management: This handles the "logic" behind the scenes—like making sure the UI updates only when it needs to (keeping the app at a smooth 60 FPS).Firebase Backend: Handles the database (Firestore), user images (Storage), and accounts (Auth) in real-time.Performance Tricks: I added image optimization and memory caching so the app doesn't waste data or battery by re-downloading the same ads twice.🛠️ Tech StackToolUsageFlutterFrontend FrameworkBLoCState ManagementFirebaseDatabase, Auth, and StorageGoogle Maps APIFetching & Tagging LocationsShared PreferencesLocal storage for "Recently Viewed"

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


