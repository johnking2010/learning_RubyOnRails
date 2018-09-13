# Getting started with Rails

from: https://guides.rubyonrails.org/ 

- How to install Rails, create new Rails app + connect the app to a database 
- General layout of a Rails application
- Basic principles of MVC + RESTful design
- How to quickly generate the starting pieces of a Rails app
---

**Rails:** an *opinionated* web application framework running on Ruby.

Two guiding principles:
1. **DRY:** Don't repeat yourself 

    "Every piece of knowledge must have a single unambiguous,authoritative representation within a system".
    
    Code is more maintainable, more extensible, less buggy...

2. Rails favours **convention over configuration** (similar to EmberJS in this respect)

---
Learning **Ruby**:
- https://www.ruby-lang.org/en/documentation/
- https://github.com/vhf/free-programming-books/blob/master/free-programming-books.md#ruby

--- 
### Installing Rails:

Check for prequisites - Ruby (v2.2.2+), SQLite3

```
ruby -v
```
`ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-darwin15]`

```
sqlite3 --version
```
`3.8.10.2 2015-05-20 18:17:19 2ef4f3a5b1d1d0c4338f8243d40a2452cc1f7fe4`

- To install Rails, use the `gem install` command (from RubyGems):

```
gem install rails
```
verify: (should be ~Rails v5.1.1)

```
rails --version
```
`Rails 5.2.1`

--- 
### Creating BLOG app:

- scripts provided to make life easier: *'generators'* ( they make life easier...)
-new application generator -> scaffolds a fresh Rails app automatically.

```
rails new blog
```
- Creates a Rails app called 'Blog' in a `blog` directory, + installs gem dependencies (from *Gemfile* using `bundle install`).

- ** `rails new -h` (shows all command line options that Rails application builder accetps)

- change into the `/blog` directory:

```
cd blog
```

- `/blog` contents:

```
$ ls
Gemfile		app		db		public		vendor
Gemfile.lock	bin		lib		storage
README.md	config		log		test
Rakefile	config.ru	package.json	tmp
```
---
**Important**: `rails new -h`
- lists all flag options for new Rails app

To create new app **WITHOUT** automatically initialising git: 
```
rails new blog --skip-git
```
---