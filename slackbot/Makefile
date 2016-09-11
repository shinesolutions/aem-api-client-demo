all: deps clean package

deps:
	gem install bundler
	bundle install

clean:
	rm -rf pkg

package:
	bundle exec rake eb:package

deploy:
	bundle exec rake eb:deploy

start:
	bundle exec rackup -o 0.0.0.0 -p 9292 config.ru

.PHONY: all deps clean package deploy start