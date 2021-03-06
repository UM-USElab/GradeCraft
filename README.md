**Out of date. Reference our development repo for current version:**
https://github.com/UM-USElab/gradecraft-development

## Gradecraft is a gamified learning management system.

### Current features:
* Badges
* Teams (course-long memberships)
* Groups (single-assignment memberships)
* Assignments
* Assignment Submissions
* Student Dashboard
* Interactive Grade Predictor
* Grading schemes
* Import students
* Unified Gradebook view
* Export students and final grades
* User analytics
* Team analytics
* Assignment stats
* Student-logged assignment scoring
* Multipliers (students decide assignment weight)

### Upcoming:
* Interactive rubrics
* Learning analytics suite

### Installation instructions for development:
1. Clone repository
1. Run `cp config/database.yml.sample config/database.yml` (replace username with your current username)
1. Run `cp .env.sample .env`
1. Run `bundle install`
1. Run `bundle exec rake db:create`
1. Run `bundle exec rake db:schema:load`
1. Optional: run `bundle exec rake db:sample`
1. Run `bundle exec rails server`
