### **README for ChattrG**

---

# **ChattrG**

**ChattrG** is an iOS chat application developed using **UIKit** and **Supabase** for backend services with **PostgreSQL** as the database. This app allows users to register, log in, create and delete chatrooms, and send messages within those chatrooms. 

## **Features**

* **User Registration & Login**: Users can sign up and log in using their email and password. The user information is stored securely in a PostgreSQL database.  
* **Chatrooms Management**: Users can create and delete chatrooms.  
* **Messaging**: Users can send messages in a chatroom, and messages are fetched from the database.  
* **UI Development**: The user interface is built entirely with UIKit.  
* **Supabase Integration**: The app uses Supabase as a backend service for managing users, chatrooms, and messages.

## **Prerequisites**

Before running this app, ensure you have the following installed:

* **Xcode**: Version 14 or higher  
* **iOS SDK**: Version 16 or higher  
* **Swift Package Managager:** Latest version   

## **Database Schema**

The application uses four main tables in PostgreSQL:

1. **users**  
   * `id`: Primary Key, unique identifier for each user.  
   * `email`: The email address of the user.  
   * `password`: The password for the user.  
2. **chatrooms**  
   * `id`: Primary Key, unique identifier for each chatroom.  
   * `name`: The name of the chatroom.  
3. **user\_chatrooms**  
   * `id`: Primary Key, unique identifier.  
   * `user_id`: Foreign Key, references the `id` in the `users` table.  
   * `chatroom_id`: Foreign Key, references the `id` in the `chatrooms` table.  
4. **chats**  
   * `id`: Primary Key, unique identifier for each chat.  
   * `user_id`: Foreign Key, references the `id` in the `users` table.  
   * `chatroom_id`: Foreign Key, references the `id` in the `chatrooms` table.  
   * `message`: The message content.  
   * `timestamp`: The time when the message was sent.  
   * `reacted`: Boolean indicating if the message has any reactions.

## **Setup and Installation**

To get started with the ChattrG app, follow these steps:

### **Prerequisites**

1. **Xcode:** Ensure you have [Xcode](https://developer.apple.com/xcode/) installed on your macOS system.  

### **Clone the Repository**

Clone the repository to your local machine:

bash

Copy code

`git clone https://github.com/utsabfdahal/ChattrGFinal.git`

`cd ChattrGFinal`

### 

### 

### 

### 

### **Install Dependencies**

The project uses Swift Package Manager to manage dependencies. Open the `ChattrG.xcodeproj` file in Xcode, then follow these steps:

1. Select `File` \> `Add Packages Dependencies`.  
2. Add the following packages:  
   * **Supabase**: `https://github.com/supabase/supabase-swift`  
3. Xcode will handle the installation of these dependencies.

## **Project Structure**

* **Controllers**:  
  * **RegisterPageViewController.swift**: Handles user registratio.  
  * **LoginPageViewController.swift**: Manages user login.  
  * **AddChatRoom.swift**: Allows users to create and delete chatrooms and add user into the chatrooms  
  * **ChatViewController.swift**: Displays chatrooms for the logged-in user.  
  * **UserChatViewController.swift**: Manages chat messages within a chatroom..  
* **Models**:  
  * **ChatUser**: Represents a user in the chat app.  
  * **Chatroom**: Represents a chatroom.  
  * **Message**: Represents a message sent in a chatroom.  
* **Views:**  
  * Main: It has all the UI components of app in .xml format

## **How It Works**

### **1\. User Registration & Login**

The user registration and login process is handled via RESTful API calls to Supabase. The `RegisterPageViewController` and `LoginPageViewController` manage the user interface for these processes.

* **Registration**: The app sends a POST request with the user's email and password to create a new user.  
* **Login**: The app sends a GET request to verify the user's credentials.

### **2\. Chatroom Management**

Users can create and delete chatrooms using the `AddChatRoom` view controller. This controller makes use of Supabase's stored procedures to manage the creation and deletion of chatrooms.

### **3\. Messaging**

Messages are sent and retrieved via Supabase's REST API. The `UserChatViewController` handles displaying messages in a chatroom, while the `ChatViewController` manages the list of available chatrooms for the user.




## **Encountered Issues**

* I had issues with integration. Backend was ready as my postgres knowledge was satisfactory and my front-end knowledge was good too. But when integrating, I faced issues while extracting data, sending it. Documentation of Supabase came really handy doing so.  
* I had significant challenges with data extraction, especially when trying to work directly with tables in-app. For instance, in the 'chats' table, I was dealing with user\_id and chatroom\_id. Extracting this data and then having to fetch the corresponding username or chatroom name in-app was a complex and frustrating process. It wasn’t until later, during a DBMS class, that I realized I could simplify everything by creating functions or procedures, joining tables, and running proper select queries. This revelation made the extraction process much smoother and more efficient. My DBMS knowledge turned out to be incredibly helpful in overcoming these challenges.

* I faced challenges in parsing JSON responses and ensuring that the data was correctly integrated with `UITableView`. This caused difficulties in fetching and displaying messages along with their senders accurately within the chat interface.

## **Future Enhancements**

* Realtime Functionality: Implement realtime updates for chat messages and chatroom activities, allowing users to see new messages and updates instantly without refreshing.  
* Enhanced UI/UX: Improve the overall user interface to create a more visually appealing and user-friendly experience.  
* Media Sharing: Enable users to send images, voice notes, and GIFs within chatrooms, making conversations more dynamic and engaging.  
* Active Status: Display active status indicators to show when users are online or typing, enhancing the interactive experience.  
* UI Improvements: Further refine the UI to make it more intuitive and responsive, ensuring smooth navigation and usage.

