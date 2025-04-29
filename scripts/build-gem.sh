#!/bin/bash

# This script builds the gem and runs tests.
bundle install && bundle exec rake test && gem build adiwg-mdtranslator.gemspec