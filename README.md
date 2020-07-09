# Brownfield Of Dreams: Backend Mod 3 Paired Project

_Brownfield of Dreams_ is a Ruby on Rails application used to organize and share YouTube videos and playlists in an online learning environment. Videos are grouped together as tutorials, and Admin users have the ability to create new tutorials and upload new YouTube playlists. Admins can also add tags, which visitors and users can use to filter tutorials.

Visitors must register if they want to view classroom content or bookmark a video. Once registered, users can also invite friends to connect with them on the site. Using their friend's github handle, the user can find their email and send an invitation to connect along with a link to the registration page.

## Inheriting Technical Debt

This was the first brownfield project we worked on at Turing and we learned a great deal about inheriting technical debt and cultivating developer empathy.

We improved on the existing code by fixing typos and removing unused routes and methods. We were able to easily identify unused routes with the help of a gem called [traceroute](https://github.com/amatsuda/traceroute). This gem also revealed 96 unreachable action methods (controller methods), which were primarily the four methods from the `ApplicationController` that were inherited by all the other controllers. Two of these methods we immediately recognized as likely placeholders which were not actually utilized.

In some cases we outright deleted unutilized methods, but others we commented out but kept handy because they would likely prove useful for future iterations. The `Admin::VideosController` was home to a few of these methods. We also left some of the methods in as comments because frankly we didn't feel confident deleting things that we didn't fully understand. We couldn't find where the methods were utilized and after removing them all our tests were still passing. Passing tests however in this case is not altogether reassuring since we inherited the test suite and from the start it covered less than 80% of the code.

With a more complete test suite, we might have felt more confident making changes to the base code. One obstacle we encountereed was not feeling confident that we understood the functionality of the existing code enough to make large changes. Furthermore, it was apparent that whoever wrote the code had a larger vision that they weren't able to complete. We followed the user stories as best we could, and primarily tended to code that was relevant to our work on those user stories.

There were a few additions we made which went beyond the user stories, but made logical sense and didn't take us too far off course. In particular, one user story pertained to hiding "classroom content". We had trouble testing this in production because there was no way to actually change the setting for tutorial classrooms (a boolean); therefore, a toggle button was added for admin's dashboard.

## Schema

We made very few additions to the schema. In retrospect, there are probably many changes we would make if time allowed. It is surprising that, though extensive tables exist for the tags, the tags are not directly associated with videos or tutorials.  

![Schema](/public/images/schema.png)

We added a Friendships table, which is a self-referential joins table that links together two users. The relationship as defined in the Friendships model:

```
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
```

The Friend class is never actually created, but references back to a user that already exists in the Users table.

## API Consumption

This application consumes APIs from Github, SendGrid, and YouTube. Github is used to find followers and users followed as well as repos. It is also used to find email addresses for friends that a user would like to invite to create an account. SendGrid is used to send confirmation emails to newly registered users and invitation emails to their friends. YouTube is where all the videos and their information come from. An admin can also create a new tutorial using an existing YouTube playlist.

## Continuous Integration

This was not only the first project where we consumed APIs, but also where we used `Rubocop` and `Travis CI` for debugging and continuous integration. While we didn't actually use Travis CI to deploy our code to Heroku, we did find the feedback from builds helpful in finding bugs, specifically related to API keys and other new details related to using APIs.

## Reflecting on Design Using the Four Pillars of OOP

In terms of design, we did very little to alter the existing code.

We followed the best practies that we were introduced to for consuming APIs, including creating POROs and "services" to connect to the API using the Faraday gem. These best practices happen to epitomize abstraction and encapsulation; similar functionality is bundled together and SRP is followed. Our models similarly abstracted functionality out of our controllers and views, following Rails conventions.

The inheritance in place in the `ApplicationController`, as discussed early, was likely putting the cart before the horse; half the methods contained therein were not used anywhere, let alone every single controller.

We had plans to refactor some of our code in order to utilize inheritance and remove repetition, but ultimately we ran out of time. In another iteration, since the Follower and Following models are nearly identical, we could put all the code into a single parent class.

Our Friendship functionality is an example of polymorphism; instead of creating a new class we created a self-referential relationship wherein a friend is actually a member of the the User class.

## Implementation Instructions

First you'll need these installed:
### Versions
- Rails 5.2.0
_(to find out what version you are using, run `$ rails -v` in the command line)_
- Ruby 2.5.x
_(`$ ruby -v`)_

Next, clone down this repository onto your local machine.
Run these commands in order to get required gems and database established.
- `$ bundle install`
- `$ bundle update`
- `$ rake db:create`
- `$ rake db:migrate`
- `$ rake db:seed`

Once it this is all set up and you aren't getting any errors you can run our test suite.

- `$ bundle exec rspec`

If you would rather enjoy the application in its finished form without messing with the command line, we are hosted on Heroku [here](https://brownfield-of-dreams-sb-rp.herokuapp.com/). You can register as a new user or login as an Administrator using the login and password found in the seed file (/db/seeds).
