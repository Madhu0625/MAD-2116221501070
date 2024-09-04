This is a repository for AI19511 Mobile Application Development Laboratory for ML and DL Applications course.

The procedure for developing a simple Login Page is as follows.

Pre-requirements:

Download and install JDK (Java Development Kit). Set the environment variable for PATH too. [Note: This step is required if Java is the programming language to develop the application]
Download and install Android Studio.
Launch the app to set up the emulator by creating a convenient Android Virtual Device.
Also set up the app to use JDK.
Procedure:

Create a new project by selecting 'Empty Views Activity'.
Name it "LoginPage" and choose Java as the language to finish the project set up.
Navigate to 'activity_main.xml' in the /app/res/layout directory.
Create a Relative Layout.
Add a TextView tag for the heading 'Login Page'.
Add 2 EditText tags, each for Username and Password.
Add a Button tag for the login action.
Create appropriate id's for the tags and adjust the layout with appropriate attributes.
Navigate to 'MainActivity.java' in the /app/java/com.example.loginpage directory.
Create objects for the EditText and Button tags respectively.
Set up OnClickListener for handling the login action on entering the username and the password.
Include appropriate Toast messages for the actions.
Debug, build and run the application on the emulator (selected AVD).
