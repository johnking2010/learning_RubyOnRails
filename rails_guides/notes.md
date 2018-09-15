# Getting started with Rails
from: https://guides.rubyonrails.org/ 

---


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
$ ruby -v
```
`ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-darwin15]`

```
$ sqlite3 --version
```
`3.8.10.2 2015-05-20 18:17:19 2ef4f3a5b1d1d0c4338f8243d40a2452cc1f7fe4`

- To install Rails, use the `gem install` command (from RubyGems):

```
$ gem install rails
```
verify: (should be ~Rails v5.1.1)

```
$ rails --version
```
`Rails 5.2.1`

--- 
### Creating BLOG app:

- scripts provided to make life easier: *'generators'* ( they make life easier...)
-new application generator -> scaffolds a fresh Rails app automatically.

```
$ rails new blog
```
- Creates a Rails app called 'Blog' in a `blog` directory, + installs gem dependencies (from *Gemfile* using `bundle install`).

- ** `rails new -h` (shows all command line options that Rails application builder accepts)

- change into the `/blog` directory:

```
$ cd blog
```

- `/blog` contents:

```
$ ls
Gemfile		app		db		public		vendor
Gemfile.lock	bin		lib		storagerails_guides/blog/
README.md	config		log		test
Rakefile	config.ru	package.json	tmp
```
---
**Important**: 

To create new app **WITHOUT** automatically initialising git: 
```
$ rails new blog --skip-git
```
(from: http://railsapps.github.io/rails-git.html)

.gitignore:
```
rails_guides/blog/.bundle
rails_guides/blog/db/*.sqlite3
rails_guides/blog/log/*.log
rails_guides/blog/tmp/
rails_guides/blog/.DS_Store
```
---

### Folder structure + roles of each:
(.md table generator: https://www.tablesgenerator.com/markdown_tables)

| File/Folder          | Purpose                                                                                                                                                                                                                                                                    |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| app/                 | Contains the controllers, models, views, helpers, mailers, channels, jobs and assets for your application. You'll focus on this folder for the remainder of this guide.                                                                                                    |
| bin/                 | Contains the rails script that starts your app and can contain other scripts you use to setup, update, deploy or run your application.                                                                                                                                     |
| config/              | Configure your application's routes, database, and more. This is covered in more detail in Configuring Rails Applications (https://guides.rubyonrails.org/configuring.html).                                                                                               |
| config.ru            | Rack configuration for Rack based servers used to start the application. For more information about Rack, see the Rack website (https://rack.github.io/).                                                                                                                  |
| db/                  | Contains your current database schema, as well as the database migrations.                                                                                                                                                                                                 |
| Gemfile Gemfile.lock | These files allow you to specify what gem dependencies are needed for your Rails application. These files are used by the Bundler gem. For more information about Bundler, see the Bundler website(https://bundler.io/).                                                   |
| lib/                 | Extended modules for your application.                                                                                                                                                                                                                                     |
| log                  | Application log files.                                                                                                                                                                                                                                                     |
| package.json         | This file allows you to specify what npm dependencies are needed for your Rails application. This file is used by Yarn. For more information about Yarn, see the Yarn website(https://yarnpkg.com/lang/en/).                                                               |
| public/              | The only folder seen by the world as-is. Contains static files and compiled assets.                                                                                                                                                                                        |
| Rakefile             | This file locates and loads tasks that can be run from the command line. The task definitions are defined throughout the components of Rails. Rather than changing `Rakefile`, you should add your own tasks by adding files to the `lib/tasks` directory of your application. |
| README.md            | This is a brief instruction manual for your application. You should edit this file to tell others what your application does, how to set it up, and so on.                                                                                                                 |
| test/                | Unit tests, fixtures, and other test apparatus. These are covered in Testing Rails Applications (https://guides.rubyonrails.org/testing.html).                                                                                                                             |
| tmp/                 | Temporary files (like cache and pid files).                                                                                                                                                                                                                                |
| vendor/              | A place for all third-party code. In a typical Rails application this includes vendored gems.                                                                                                                                                                              |
| .gitignore           | This file tells git which files (or patterns) it should ignore. See GitHub - Ignoring files for more info about ignoring files (https://help.github.com/articles/ignoring-files).                                                                                          |
| .ruby-version        | This file contains the default Ruby version.                                                                                                                                                                                                                               |


---

From within the `/blog` folder, run

```
$ bin/rails server
```
yields:

```
=> Booting Puma
=> Rails 5.2.1 application starting in development 
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.0 (ruby 2.4.2-p198), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```

- Go to http://localhost:3000/

---
---

### "Hello" Rails:

- Getting text on screen:
    - create a *controller* (purpose: receive specific requests for the Rails app)
    - create a *view* (purpose: which controller receives which requests).
    - Often, > 1 route to each controller. 
    - Different routes can be served by different *actions* (aka *models*)
    
    - Purpose of *actions*: collect information to provide it to a view.
    - Purpose of a view: display information in a *human readable* format.
    - It is the **controller**, *NOT* the view, that **collects information**.
        - The view: just **displays** that information.
    - View templates (by default) written in a lang. called *eRuby* (Embedded Ruby), processed by the request cycle in Rails before being sent to a user.

- **Creating a controller**
    - run the `controller` generator, provide a name ("Welcome"), with an action called "index":

    ```
    $ bin/rails generate controller Welcome index
    ```
    - Rails -> creates several files AND a route:

    ```
    Running via Spring preloader in process 25522
        create  app/controllers/welcome_controller.rb
        route  get 'welcome/index'
        invoke  erb
        create    app/views/welcome
        create    app/views/welcome/index.html.erb
        invoke  test_unit
        create    test/controllers/welcome_controller_test.rb
        invoke  helper
        create    app/helpers/welcome_helper.rb
        invoke    test_unit
        invoke  assets
        invoke    coffee
        create      app/assets/javascripts/welcome.coffee
        invoke    scss
        create      app/assets/stylesheets/welcome.scss
    ```

    - The `controller` and the `view` are the most important of these, found at: `appcontrollers/welcome_controller.rb` and `app/views/welcome/index.html.erb`

    - Open `app/views/welcome/index.html.erb`
    - Delete ALL existing code in the file
    - Replace with:
    ```
    <h1>Hello Rails!</h1>
    ```

---

### Setting the Application Home Page:

- Still necessary to tell Rails when we want "Hello Rails" to appear...
- Aim: on accessing the root URL of this site (http://localhost:3000), presently occupied by other stuff...
- Tell rails where the home page is located:
- Open `config/routes.rb`:

```
Rails.application.routes.draw do
  get 'welcome/index'
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

- The above is the app's *routing* file, holds entries in a special DSL (Domain Specific Language - https://en.wikipedia.org/wiki/Domain-specific_language).
- It tells Rails HOW to connect incoming requests to *controllers* + *actions*.
-EDIT by adding: `root 'welcome#index'`:

```
Rails.application.routes.draw do
    get 'welcome/index'

    root 'welcome#index'
end
```

- `root 'welcome#index'` tells Rails to **map** requests to the root of the app to the welcome controller's index *action*
- `get 'welcome/index'` tells Rails to *map* requests to http://localhost:3000/welcome/index to the welcome controller's index *action*.
These mappings were created automatically earlier on running the controller generator (`bin/rails generate controller Welcome index`).

- Launch the web server again to see these changes take effect!
- INDICATES: this new **route** is actually going to `WelcomeController`'s index *action*, rendering the *view* correctly.

[Further routing info: https://guides.rubyonrails.org/routing.html]

---
### Getting Up + Running:

So far created:
- a **controller**
- an **action**
- a **view**

Next, something more substantial:

- a new **resource** within the `blog` applicaiton.

A 'resource'  describes a collection of similar objects (articles, people or animals).
Possbile to **C**reate, **R**ead, **U**pdate and **D**estroy (**CRUD** operations) items for a resource.

- Rails provides a `resources` method, can be used to delare a standard REST resource.
- Must add the *article resource* to the `config/routes.rb`, should look like:

```
Rails.application.routes.draw do
    get 'welcome/index'

    resources :articles

    root 'welcome#index'
end
```

- run `$ bin/rails routes`
- will show defined routes for all stadard RESTful actions:

| Prefix | Verb | URI Pattern | Controller#Action |
|---------------|--------|------------------------------|-------------------|
|  |  |  |  |
| welcome_index | GET | /welcome/index(.:format) | welcome#index |
| articles | GET | /articles(.:format) | articles#index |
|  | POST | /articles(.:format) | articles#create |
| new_article | GET | /articles/new(.:format) | articles#new |
| edit_article | GET | /articles/:id/edit(.:format) | articles#edit |
| article | GET | /articles/:id(.:format) | articles#show |
|  | PATCH | /articles/:id(.:format) | articles#update |
|  | PUT | /articles/:id(.:format) | articles#update |
|  | DELETE | /articles/:id(.:format) | articles#destroy |
| root | GET | / | welcome#index |

- (meaning of prefix colums to be explained later)
- Notice that Rails has *inferred* the singular form(?from?) `article` + makes meaningful use of the decision.

- NEXT:
    - add the ability to create *new* articles in the application + view them!
    - **C**reate & **R**ead (part of CRUD), via a basic form (title/text/Save Article).

---

### Laying down the groundwork:

- Required: a place within the app to create a new article
- good place: `articles/new`
- As the route is already defined, requests can now be made within the application.
- BUT...
- navigate to http://localhost:3000/articles/new 
- Routing error will appear... 
- WHY?
    - The route needs to have a *controller* defined in order to serve the request.
    Simple solution: create a *controller* called `ArticlesController`:

    ```
    $ bin/rails generate controller Articles
    ```

- Open this newly created controller in `app/controllers/articles_controller.rb` (a fairly empty controller):

```
class ArticlesController < ApplicationController
end
```

- A controller is simply a class that is defined to **inherit** from `ApplicationController`.
- Inside *this* class is where to define methods that will becomes the *actions* for this controller (these actions will perform CRUD operations on articles within our system).

- [Ruby has `public`, `private` and `protected methods` - ONLY `public` methods can be actions for controllers. More details via http://www.ruby-doc.org/docs/ProgrammingRuby/]

- Refresh to http://localhost/3000/articles/new
- Yields a NEW error:

```
Unknown error
The action 'new' could not be found for ArticlesController
```

- Rails cannot find the `new` action inside the `ArticlesController`.
- COntrollers generated by Ruby are **empty** by default, *unless* desired actions are defined during the generation process.

#### Manually defining an action within a controller:

- define a new method within the controller:
- open `app/controllers/articles_controller.rb`
- within the class define the `new` method:

```
class ArticlesController < ApplicationController
    def new
    end
end
```

- Refresh to http://localhost/3000/articles/new
- Yields another NEW error:

```
ActionController::UnknownFormat in ArticlesController#new

ArticlesController#new is missing a template for this request format and variant. request.formats: ["text/html"] request.variant: [] NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not… nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
```

- Rails expects plain actions like this one to have **views** associated with themto display their information.
- With **no view avilable**, Rails will raise an exception

- Going through the long part of the above error message:

    1. identifies which **template** is missing, in this case it's the `articles/new` template. Rails looks first for this template, if none found, it then attempts to load a template called `application/new` (because `AriclesController` **inherits** from `ApplicationController`)

    2. Next part contains **request.formats** which specifies the format of template to be served in reponse. It is set to `text/html` as we requested the page via the browser, so Rails is looking for an HTML template. `request.variant` specifies what kind of **physical devices** would be served by the response and helps Rails determine which template to use in the response. It is **empty** because no information has been provided.
- The simplest template that would work in this case would be the one located at `app/views/articles/new/html.erb`.
- The extension of this file name is **important**: 
    - the first extension is the *format* of the template.
    - the second extension is the *handler* that will be used to render the template.

- Rails is attempting to to find a template called `articles/new` within `app/views` for the application.
- The format for this template can only be `html` and the default handler for HTML is `erb`.
- Rails uses other handlers for other formats:
    - `builder` handler is used to build XML templates
    - 'coffee' handler uses CoffeeScript to build JavaScript templates
- As the intent is to create a new HTML form, use the `ERB` language which is designed to embed Ruby inside HTML.

- Therefore the file should be called `articles/new.html.erb` and needs to be located within the `app/views` directory of the application.

- CREATE a new file at `app/views/articles/new.html.erb` with the following content:

```
<h1>New Article</h1>
```

---
- Refresh to http://localhost/3000/articles/new
 
    ### THE PAGE HAS A TITLE!

- The **route**, **controller**, **action** and **view** are now working harmoniously!
- Time to create the form for the new article...  
---