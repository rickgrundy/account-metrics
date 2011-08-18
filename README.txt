Requirements: 
- Ruby 1.9.2
- ImageMagick

Install gems:
$ sudo gem install bundler
$ bundle install

Usage: ruby generate.rb /path/to/input.csv


Input format (.csv file):
Delivery Coverage,,,
,,Green,#FF0000
Account,Heads,Covered,Not Covered
Client Red,3,0.2,0.8
Client Blue,4,0.2,0.8
...

- Colours can be names or #FFAA00 hex values.
- Values must be fractions, not percentages.
- Can have any number of columns

