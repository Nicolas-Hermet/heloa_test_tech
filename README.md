# README

## Running the repository
Simply run:
```bash
bundle install
./bin/dev
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
bundle exec rails s
```
What you want to see is accessible [here](http://localhost:3000/posts)

You can also run tests:
```bash
bundle exec rspec
```

All tests should pass...

Happy reviewing!

## Some notes
### Timing
I spent around 5 to 6 hours on this test.
Mostly because I was searching for a nice template to apply. I didn't want to have an ugly white page without any CSS and spent a bit of time to integrate the template. (I had fun on this I should say).
Also, I didn't want to "just" have a search feature.
I also spent some time (almost 1 hour) trying to figure out what CMS gem could have generated such JSON. I have used raw Trix editor in the past but some of the attributes were unknown to me. I thought that if I could find the gem you used, I could just install it and ease the import of the JSON. But I couldn't, so I decided to recreate the database.

### Database choice
I chose PostgreSQL, not for any particular reason but mostly because I use it all the time. I figured out that the posts and tags given were extracted from a MongoDB. But I didn't want to shoot myself in the foot (is that even idiomatic?), so I stuck with Postgres.

### Import
That brings us to the import.
I chose to do it in the seed. Some would argue that it could have been a service or even that the "article_simplified.json" should be in a separate folder.
I'd say this is just a technical test. So in real life, we would migrate the DB with a dump or some other technique of some sort.

Here, the reviewer can simply run `rails db:seed` and have the job done.

### What is missing
A lot of things, to be honest.
I really wanted to time-box the test. So I made choices, I'd be happy to discuss, but mainly:

- Specs: I know there is a critical lack of specs. I would install FactoryBot to ease them, as well as Coveralls or SimpleCov to make sure I have good coverage. I'm also curious about your philosophy at Heloa: do you spec private methods, callbacks, and associations? Most teams don't, I was just wondering and didn’t want you to think I cannot. Specs are too much of a trauma for me not to be proud of what I can do with them.
- Partials: Here I do not exploit the full potential of partials and I know it... I wanted to focus a bit more on the design, because I know Gautier is somewhere in the loop instead of the usability of my "components". Spoiler: we can't use them as-is. They would need locals and, moreover, they crucially need to check for locals’ definitions before trying to display some material.
- TODOs: I put some todos here and then in the code. Not every team works like this. But I do. It could have been GitHub issues or Jira tickets. But I wanted to make sure you read them. The intent is more about giving conversation starters than anything else here. The job is far from being shipped if it were an actual product. Everyone knows it.

### Solution
I chose to use the pg_search gem. It struck me like an evidence. But honestly, I challenge my own decision especially in terms of performance. I didn't have the time to benchmark this properly.
But I assume, in the case of a MongoDB database, things would be really different.
Anyhow: I will be happy to discuss.
