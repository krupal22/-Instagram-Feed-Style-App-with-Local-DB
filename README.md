# 📷 Instagram Feed Style App (Flutter + SQLite)

A simple Instagram/Twitter-style feed app built for interview using Flutter, GetX, and SQLite.  
All data is stored locally. No backend required.

##  Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/krupal22/-Instagram-Feed-Style-App-with-Local-DB/master/assets/ss/ss1.png" width="30%" style="margin: 10px;"/>

  <img src="https://raw.githubusercontent.com/krupal22/-Instagram-Feed-Style-App-with-Local-DB/master/assets/ss/ss2.png" width="30%" style="margin: 10px;"/>
  <img src="https://raw.githubusercontent.com/krupal22/-Instagram-Feed-Style-App-with-Local-DB/master/assets/ss/ss3.png" width="30%" style="margin: 10px;"/>
  <img src="https://raw.githubusercontent.com/krupal22/-Instagram-Feed-Style-App-with-Local-DB/master/assets/ss/ss4.png" width="30%" style="margin: 10px;"/>
  <img src="https://raw.githubusercontent.com/krupal22/-Instagram-Feed-Style-App-with-Local-DB/master/assets/ss/ss5.png" width="30%" style="margin: 10px;"/>
  <img src="https://raw.githubusercontent.com/krupal22/-Instagram-Feed-Style-App-with-Local-DB/master/assets/ss/ss6.png" width="30%" style="margin: 10px;"/>
  <img src="https://raw.githubusercontent.com/krupal22/-Instagram-Feed-Style-App-with-Local-DB/master/assets/ss/ss7.png" width="30%" style="margin: 10px;"/>
  <img src="https://raw.githubusercontent.com/krupal22/-Instagram-Feed-Style-App-with-Local-DB/master/assets/ss/ss8.png" width="30%" style="margin: 10px;"/>


</p>


## 🔥 Features

🔐 **Login / Logout**
- Simple username-based login (no password)
- Auth state persists until logout

- 📝 **Posting**
    - Select image from gallery or camera
    - Add optional caption
    - Automatically tagged with username and timestamp

- 📰 **Feed**
    - Displays posts with:
        - Username
        - Timestamp
        - Image (click to view fullscreen)
        - Caption
        - Like count (❤️ toggle)
        - Comment count (💬)
        - Download button

- 💬 **Comments**
    - Add and view comments on each post
    - Each comment shows username and time

- ❤️ **Likes**
    - Toggle like/unlike per post
    - User-specific likes saved in local DB
    - Prevents multiple likes from same user

- 🗂️ **Dummy Data**
    - Adds 5 sample posts on first launch using [https://picsum.photos](https://picsum.photos)


## 🧱 Tech Stack

- Flutter (null safety)
- GetX (state management + routing)
- SQLite (local DB)
- sqflite, image_picker, permission_handler, image_downloader

## 📲 How to Run

1. Clone the repo
2. Run `flutter pub get`
3. Start the app with `flutter run`
4. Use emulator/gallery to pick and post images


## 📂 Folder Structure

lib/
├── data/
│ ├── db/
│ ├── models/
├── modules/
│ ├── auth/
│ ├── feed/
│ ├── post/
│ └── comment/
├── routes/
│ └── app_pages.dart
├── utils/
│ └── download_helper.dart
└── main.dart


## 📦 APK

👉 [Download APK from Google Drive](https://drive.google.com/drive/folders/1P6KwkkqhAtrnN2RIyWmNdLa41C1c2xP8?usp=sharing)


🧑‍💻 Author
Krupal Patel
Flutter Developer from Rajkot, India
[LinkedIn](https://www.linkedin.com/in/krupal-korat-0b104a10b?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)


---

