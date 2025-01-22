# flutter_app

set up instructions:
- open project in ide and run flutter run
- select emulator


dependencies:
- get: ^4.6.6
- provider: ^6.1.2
- http: ^1.3.0

get is used to show the snackbars and to manage routing
provider is used to manage state
http is used to make api calls


apis used:
- to fetch courses 
    http://10.0.2.2:3001/courses
- to submit user request
    https://api.restful-api.dev/objects
    (used because i could not create a post api using mockoon)

Provide usage:
this application includes usage of provider for state management

using provider all the courses fetched using the api are stored in stateController class in courses variable

App Flow:
user selects the fetched courses and cliks on continue which will navigate them to the form submit page where they will enter their name and email and click on submit


Search feature not implemented
