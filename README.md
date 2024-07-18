# Adventus

This application displays live-updating TFL underground train arrivals to Great Portland Street Station.

By default the page will refresh every 5 seconds. This can be adjusted in the main application layout template.

## Running

To run this make sure you have a recent Ruby 3 installed and then in the application directory run

```
bundle install

```

If that went well start the app with

```
bundle exec rails server
```

Once the server is started you can open the live timings by visiting `[http://localhost:3000](http:///localhost:3000)`

## Testing

Assuming you have ran `bundle install` beforehand you can execute all tests with

```
bundle exec rspec
```

### Happy arriving!

