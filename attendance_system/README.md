# attendance_system

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

This Application is a Location based Attendance Management System and is developed for android/iOS devices in order to digitize and ease the daily attendance process of employees of the businesses.

The key objective is to remove manual attendance processing and replace it with more easy and seamless solution. Some key features of the solution are:

✔️ User-friendly attendance management online application to optimize attendance capture.

✔️ It enables employee to login, mark his attendance and also to check their attendance history.

✔️ Easy to use graphical user interface (GUI).


The following is the flow and the functionalities offered:

✔️ The home page will show today's date, time & day, a button to clock-in/clock-out(if already clocked-in), distance of employee from the office/branch, clocked-in time, clocked-out time, and working hours for the day.

✔️ If the employee is in office range (currently set to 100 meters) he can click 'clock-in' button and his clocked-in time will be recorded. If employee isn't in office range, and he is trying to clock-in, an alert message will be displayed.

✔️ Employee can clock-out at anytime of the day by clicking clock-out button. The last clocked-out time will be recorded for the day. Working hours are calculated based on the clocked-in and clocked-out time.

✔️ The 'Attendance History' tab contains a calendar, and attendance data of the employee in a table format.

✔️ Employee will be able to see his attendance history on the 'Attendance History' tab. A list of attendance history is displayed for the month selected in calendar.

✔️ He might be able to select any date in order to check his attendance on that date. He can change the month in calendar in order to check his attendance data of selected month.

✔️ The calendar has one button in order to switch the display format. It can be 1 week format - displaying one week at a time, or it can have 2 weeks format - displaying 2 weeks at a time.


The following features of Flutter/dart are used:

✔️ Along with the flutter provided widgets, custom designed widgets are also used to provide better UI and reusable code in order to avoid redundancy in coding
 
✔️ API integrations are done with Geolocator API to get location coordinates and distance between two locations (current location and office location), and with Geocoder API in order to get current address.

✔️  The code is divided into modules, services, utilities, screens, controllers, and components in order to get better code readability, understandability, optimization.
