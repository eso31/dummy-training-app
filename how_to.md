#Nearsoft Training App

##About Training App

Training App is an application developed in Ruby on Rails with React, wich means we are going to use built-in commands to create nice stuff


###HOW-TO create a local copy of the old java app database
1. copy a sql backup (`training_old.sql`) to `./backups/`
2. run `scripts/copy-old-db.sh`  to create a `training_prod_old` database in your postgres container 
and restore the backup contents. WARNING!! this will drop an existing `training_prod_old` database



###HOW-TO Create a model command

The rails generate model command will create a model, migrations and the tests for an specific entity

```
docker-compose exec training-app rails generate model <model-name> <field1:type> <field2:type> ...
```

Example with User model

```
docker-compose exec training-app rails generate model user email:string password:string type:integer
```


This will generate the files


```      
invoke  active_record
create    db/migrate/20170926003232_create_users.rb
create    app/models/user.rb
invoke    rspec
create      spec/models/user_spec.rb
```

The migration file shows the table with the fields you specificed in the rails generate command. You can modify anything you need inside the migration, like adding more fields to the table, adding indexes, conditions, etc.

You can run the migration with the command

```
docker-compose exec training-app rake db:migrate
```

The model file shows the associations with other entities you specified when you created the model with a references field type.

The spec file are the default tests rspec generates when you create a model with the rails generate command, to run the tests you can use the command

```
docker-compose exec training-app rspec spec
```


###HOW-TO  Create a controller command

The rails generate controller command is used to generate a controller with the methods you specified. This with his own routes and spec files

You can generate controllers in two different ways

#####rails generate controller command

```
docker-compose exec training-app rails generate controller <controller_name> <method1> <method2> ... --skip-template-engine
```

This command will generate the controller for you entitiy with the methods specified, the routes on the routes.rb file, and a controller specs file

Example with users entity:

```
docker-compose exec training-app rails g controller user index show --skip-template-engine
```
Will generate the files

```
create  app/controllers/user_controller.rb
route  get 'user/show'
route  get 'user/index'
invoke  rspec
create    spec/controllers/user_controller_spec.rb

```

This command will generate a controller only with the methods you defined, and this methods will be empty (like specs). So you will need to generate all the code necessary to make the methods behave like you want to




####HOW-TO  rails generate scaffold command

The generate scaffold command for rails apis will not only generate the controller, it will generate all the methods with the expected behavior for a RESTFUL controller, along with the specs

```
docker-compose exec training-app rails g scaffold user --api

```

Will generate the files

```
invoke  active_record
create    db/migrate/20170926062525_create_users.rb
create    app/models/user.rb
invoke    rspec
create      spec/models/user_spec.rb
invoke  resource_route
route    resources :users
invoke  scaffold_controller
create    app/controllers/user_controller.rb
invoke    rspec
create      spec/controllers/users_controller_spec.rb
create      spec/routing/users_routing_spec.rb
invoke      rspec
create        spec/requests/users_spec.rb
```


### HOW-TO restore data from the old java app database

```
   scripts/copy-old-db.sh
```

### HOW-TO index all models with elastic search

```
bundle exec rake environment elasticsearch:import:all FORCE=y
```