# LetMeDrive Backend Challenge

## Guidelines

**For each level, write code that generates a `data/output.json` file from `data/input.json`.
An `expected_output.json` file is available to give you a reference on what result is expected.**

## Pointers

You can have a look at the higher levels, but please do the simplest thing that could work for the level you're currently solving.

The levels become more complex over time, so you will probably have to re-use some code and adapt it to the new requirements.
A good way to solve this is by using OOP, adding new layers of abstraction when they become necessary and possibly write tests so you don't break what you have already done.

Don't hesitate to write [shameless code](http://red-badger.com/blog/2014/08/20/i-spent-3-days-with-sandi-metz-heres-what-i-learned/) at first, and then refactor it in the next levels.

For higher levels we are interested in seeing code that is clean, extensible and robust, so don't overlook edge cases, use exceptions where needed, ...

Please also note that:

- All prices are stored as integers (in cents)
- Running `$ ruby main.rb` from the level folder should generate the desired output, but of course feel free to add more files if needed.
