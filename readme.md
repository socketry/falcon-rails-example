# Falcon Rails Example

This repository contains an example Rails application that uses Falcon as the web server. It also demonstrates how to use the `console` gem for logging, and how to use the `traces` gem for request tracing.

## Usage

Migrate the database:

```
> bin/rails db:migrate
```

`redis-server` should be running on localhost for all the examples to work.

Then start the server using `falcon` directly:

```
> bundle exec falcon serve
```

This will bind to HTTPS / port 443.
