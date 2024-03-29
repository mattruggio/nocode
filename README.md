# Nocode

#### Execute Ruby code through YAML

[![Gem Version](https://badge.fury.io/rb/nocode.svg)](https://badge.fury.io/rb/nocode) [![Ruby Gem CI](https://github.com/mattruggio/nocode/actions/workflows/rubygem.yml/badge.svg)](https://github.com/mattruggio/nocode/actions/workflows/rubygem.yml) [![Maintainability](https://api.codeclimate.com/v1/badges/66479dae44129c87dc88/maintainability)](https://codeclimate.com/github/mattruggio/nocode/maintainability) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Nocode is a library that provides a YAML interface draped over arbitrary Ruby code.  The YAML contains a series of steps with each step mapping to a specific Ruby class.  The Ruby classes just have one responsibility: to implement #perform.

## Installation

To install through Rubygems:

````
gem install nocode
````

You can also add this to your Gemfile using:

````
bundle add nocode
````

## Examples

Create a file called `nocode-csv-to-json.yaml`:

### CSV-to-JSON File Converter

````yaml
parameters:
  input_filename: input.csv
  output_filename: output.json

steps:
  - type: io/read
    name: READ FILE
    options:
      path:
        - files
        - << parameters.input_filename >>
  - type: deserialize/csv
  - type: serialize/json
  - type: io/write
    options:
      path:
        - files
        - << parameters.output_filename >>
````

Create csv file at: `files/input.csv`

Execute in Ruby:

````ruby
path = Pathname.new('nocode-csv-to-json.yaml')

Nocode.execute(path)
````

Or use bundler:

````zsh
bundle exec nocode nocode-csv-to-json.yaml
````

A file should have been created at: `files/output.json`.

Notes:

* Path can be an array or a string.  If its an array then the environment's path separator will be used.
* The `name` job key is optional.  If present then it will print out on the log.
* Parameter values can be interpolated with keys and values using `<< parameters.key >>` syntax



## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check nocode.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:mattruggio/nocode.git)
4. Navigate to the root folder (cd nocode)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````zsh
bin/rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````zsh
bin/guard
````

Also, do not forget to run Rubocop:

````zsh
bin/rubocop
````

And auditing the dependencies:

````zsh
bin/bundler-audit check --update
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into main
2. Update `version.rb` using [semantic versioning](https://semver.org/)
3. Install dependencies: `bundle`
4. Update `CHANGELOG.md` with release notes
5. Commit & push main to remote and ensure CI builds main successfully
6. Run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Code of Conduct

Everyone interacting in this codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mattruggio/nocode/blob/main/CODE_OF_CONDUCT.md).

## License

This project is MIT Licensed.
