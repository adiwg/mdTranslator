[![Build Status](https://travis-ci.org/adiwg/mdTranslator.svg?branch=master)](https://travis-ci.org/adiwg/mdTranslator)
[![Gem Version](https://badge.fury.io/rb/adiwg-mdtranslator.svg)](http://badge.fury.io/rb/adiwg-mdtranslator)

# mdTranslator

mdtranslator was written by the [Alaska Data Integration Working Group](http://www.adiwg.org) (ADIwg) to assist with creating ISO 19139 metadata records.  Input to the mdtranslator is JSON conforming to the [mdJson-schemas](https://github.com/adiwg/mdJson-schemas).  The mdtranslator architecture allows developers to write additional readers for other input formats and/or write additional writers for other output other than ISO 19139, e.g. HTML.

## Installation

Add this line to your application's Gemfile:

    gem 'adiwg-mdtranslator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adiwg-mdtranslator

## CLI Usage

    $ mdtranslator help translate

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mdTranslator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
