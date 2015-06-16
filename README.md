# BoB: Betting on Builders! (Beta)

## Overview

Bob is a Builder tool which helps you build *as complex as you want* instances for your Rails applications. 

## Philosophy

BoB is intended to help you generate quite extensive amounts of valid data for your applications in a quick, easy, and handleable way. It's basic philosophy states that you should populate your models with **as much and complex information as possible**, thus getting the following advantages:

- **Generating more complex usage and testing cases:** Basically, the more data you have, the more chances of finding bugs and malformations you get.

- **Getting real, full loaded models:** It will be easier for you to get an example on how your application will behave when it comes to a higher use level.

For getting this results, BoB supports itself in two pilars:

#### Data Randomness

I strongly recommend using BoB with a *random data generation tool* such as [Faker](https://github.com/stympy/faker), letting you uncouple yourself from static *(and boring!)* values, and start getting more variable results. Having no control in what the real input will be in your model is the most user-like behaviour you can encounter. You will be surprised on how many bugs you can find by addind randomness to your code!

#### Fully generated data

Though it can be hard to mantain all generators updated all the time, they show their real potential while you get them the knowledge to build full instances of your models. **BoB uses real ActiveRecord instances of your models** so you can get everithing from your *custom validations* to *any internal logic and methods you might need to use*.

## Usage

BoB starts with a simple interface, so you can tell it how to build instances for your models with:

```ruby
class UserBuilder < Bob::Builder
  meta_build :user do |user|
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
  end
end
```

Then, you can generate an **unsaved** instance of your class with:
```ruby
UserBuilder.user
```

And if you want a **saved** instance of your class you can:
```ruby
UserBuilder.user save: true
```
or just:
```ruby
UserBuilder.user!
```

### Parameter passing

You can pass as many parameters as you want to your builder. As a convention **all parameters MUST have the same name at both definition and calling time**, and **the first parameter will always be the building instance.** That let us use idempotently these definitions:

```ruby
class MagicBuilder < Bob::Builder
  meta_build :magician do |magician, myTrick, andThen, options: {}|
    # Magician making some magic
  end
end
```

or

```ruby
class MagicBuilder < Bob::Builder
  meta_build :magician do |magician, myTrick = nil, options, *args|
    # Magician making some magic
  end
end
```

As you can see, **parameter order and type doesn't matter as long as you keep the building instance first**. As told before, *it comes with the cost of parameter naming*, but it turns out to be a quite fair tradeoff.

### Special parameters

BoB gets some context special parameters that you can both manually set and get inside your builders. Those are:

- **save (defaults to: false):** Indicates to BoB if it has to *save* the current instance.
- **log (defaults to: false):** Indicates to BoB wether to log or not the current action.
- **log_with (defaults to: ->(msg){puts msg}):** Indicates the logging function to be used. It's expecting a lambda.
- **qty (defaults to: 1):** Indicates how many instances BoB will create of the current model.

### Multiple instance creation

BoB lets you create multiple instances at the same time, returning an array of those created instances:

```ruby
UserBuilder.user! qty: 40
```

### Custom named Models

As you have seen, **BoB inferrs the model class name on the symbol which identifies it**, but there might be some cases when you need to specify several builders for some class, or just you might want to set a different name. Then, you can use:

```ruby
class UserBuilder < Bob::Builder
  meta_build :admin, User do |admin|
    # Admin magic...
  end
  
  meta_build :super_admin, User do |sa|
    # SuperAdmin magic..
  end
  
  meta_build :user do |user|
    # Simple, user magic
  end
end
```

### For Each

Here is when it gets interesting. BoB provides an special *for_each* block, which can be used to *do something while another instance is builded*. Here's an example:

```ruby
class UserBuilder < Bob::Builder
  for_each :user do |user|
    sendToDeliveryOffice user
  end
end
```
That might seem a little bit trivial, *but it's really useful for actions wich need to be done post instance building*. Besides, you can also **build associated instances:**

```ruby
class UserBuilder < Bob::Builder
  for_each :user, build: Comment, qty: 20, rnd_qty: true, min: 0 do |user, comment, description: ''|
    comment.user = user
    comment.description = description
  end
end
```

That really seems more useful. By the way, **BoB ensures to execute those callbacks in the order that they're defined**.

### Data randomness

By the way, BoB adds a set of random distribution tools for your system. Specifically, you can now use:

```ruby
Math.triangleRandom
```

To get a lineary decreasing probability of getting a value from 0 to 25. That is what BoB uses to generate its lower-flavored number randomness. You can, of course, indicate *min* and *max* values to triangleRandom.


## Contributing

Both issue reporting and pull requests are accepted!

## License

You guess it! MIT Open Source!
