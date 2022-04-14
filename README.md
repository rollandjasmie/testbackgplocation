# freelance-gplocation-backend



## Install

### Clone the repository

```shell
git clone https://github.com/SAYNACROWDSOURCING/freelance-gplocation-backend.git
cd freelance-gplocation-backend
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.7.1`


### Install dependencies

Using [Yarn](https://github.com/yarnpkg/yarn):

```shell
 yarn install
```

```shell
 bundle install
```

### Digital_ocean image storage
Using [Digital ocean](https://www.digitalocean.com/):
to edit the keys :

See 

* config/storage.yml.

### Initialize the database

```shell
rails db:create db:migrate db:seed
```


## Server

```shell
rails s
```


