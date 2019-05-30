#FLATIRON CARES

Flatiron Cares is a CLI application that lets the users search and sign up for various volunteer opportunities in NYC.

##Installation

Upon cloning this git repository, it is imperative that you run “rake db:migrate” & “rake db:seed” in order to populate the database from the NYC Open Data API. In order to start the application, run “ruby bin/run.rb” in your terminal.

```console
rake db:migrate
rake db:seed

ruby bin/run.rb
```

##Functions


User will be prompted to login to the application with their e-mail address.
If the e-mail address is not found in the system, the system will prompt the user to either create an account or exit the program.

Once logged in, the user will be directed to the Main Menu, with 7 different options.

```console
1. Search for volunteer opportunity by category
2. Search for voluteer opportunity by zipcode
3. Search for volunteer opportunity by organization
4. Feeling extra generous!
5. Top 5 Volunteer Opportunities with most needs
6. Cancel my volunteer slot
7. Display my signups
8. Exit
```

The user can:
 1. Search by the volunteer category (i.e. “Education”)
 2. Search by zipcode (within NYC)
 3. Search by organization name
 4. Choose to sign up for a randomly selected volunteer opportunity
 5. Choose to sign up for the top 5 volunteer opportunities with most needs
 6. Cancel his/her volunteer slot from a previous signup
 7. Displays all Volunteer opportunities the user has signed up for
 8. Exit the program

The program will restrict the user to sign up to the volunteer opportunity if:
 * The volunteer opportunity is at full capacity
 * If the user has already signed up for the opportunity

Happy Volunteering!

![Alt Text](https://media.giphy.com/media/Y8tW6EgVscvGo/giphy.gif)

##Authors

* Raphael Saphra - @rsaphra
* Emi Katsuta - @ekatsuta

##Acknowledgements

* Thank you Rishi, Charlie & Matt for your support!
* Created for Flatiron School Mod 1 Project
