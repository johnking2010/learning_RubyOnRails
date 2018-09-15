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

### The first form:

- To create a form with this template, use a *form builder*
- The primary form builder for Rails is provided by a helper method called `form_with`.
- Add the following into `app/views/articles/new.html.erb`:

```
<%= form_with scope: :article, local: true do |form| %>
    <p>
        <%= form.label :title %><br>
        <%= form.text_field :title %>
    </p>

    <p>
        <%= form.label :text %><br>
        <%= form.text_area :text %>
    </p>

    <p>
        <%= form.submit %>
    </p>
<% end %>
```

- Refresh the page: form should be visible!
- Building forms with Rails is as easy as above.
- When calling `form_with`, an identifying scope for this form must be passed. In this case, the **symbol** `:article`. 
    - This tells the `form_with` helper what this form is for.
    - Inside the block for this method, the `FormBuilder` object (represented by `form`) is used to build two **labels** and two **text fields** (one each for the title and text of an article).
    - Finally, the call to `submit` on the `form` object will create a submit button for the form.

- One problem with this form...
- If you inspect the HTML that is generated (by viewing the source of the page), you will see that the `action` attribute for the form is pointing at `articles/new`.
- This is a problem because this route goes to the very page that you're on right now, and that route should **only** be used to display the form for a **new** article.

- The form needs to use a different URL in order to go somewhere else.
- This can be done quie simply with the `:url` option of `form_with`
- Typically in Rails, the action that is used for new form submissions like this is called "create", and so the form should be pointed to that action.**
- Edit the `form_with` line inside `app/views/articles/new.html.erb` to also include `url: articles_path` , appearing as: 

```
<%= form_with scope: :article, url: articles_path, local: true do |form| %>
```

- In the above, the `articles_path` helper is passed to the `url:` option.
TO see what Rails will do with this, we look back at the output of `$ bin/rails routes`: 


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

- The `articles_path` helper tells Rails to point the form to the URI Pattern associated with the `articles` prefix; and the form will (by default) send a POST request to that route.
- This is associated with the `create` action of the current controller, the `ArticlesController`.

- With the form and its associated route defined, you will be able to fill in the form and then click the submit button to begin the process of creating a new article (TRY IT).
- On submitting the form, you should be presented with a familiar error:

```
Unknown action
The action 'create' could not be found for ArticlesController
```

- You **must** create the `create` action within the `ArticlesCOntroller` for this to work.

- [By default, `form_with` submits forms using Ajax, thereby skipping full page redirects. TO make this guide easier to get into we've disabled that with `local: true` for now ]

---

### Creating Articles:

TO make the "Unknown action" go away, you can define a `create` action within the `ArticlesController` class in `app/controllers/articles_controller.rb`, underneath the `new` action, as shown:

```
class ArticlesController < ApplicationController
    def new
    end

    def create
    end
end
```

- If you re-submit the form now, you may not see any change on the page. Don't worry! This is because Rails by default returns `204 No Content` response for an action IF we don't specify what the response should be.
- We just added the `create` action but didn't specify anything about how the respnse should be.
- In this case, the `create` action should save our new article to the **database**.

- When a form is submitted, the fields of the form are sent to Rails as *parameters*.
- These parameters can then be referenced inside the controller actions, typically to perform a particular task.
- To see what these parameters look like, change the `create` action to this:

```
def create
    render plain: params[:article].inspect
end
```

- The `render` method here is taking a very simple hash with a key of `:plain` and a value of `params[:article].inspect`.
- The `params` method is the object which represents the parameters (or fileds) coming in from the form.
- The `params` method returns an `ActionController::Parameters` object, which allows you to access the keys of the hash using *either* strings **or** symbols.
- In this situation, the only parameters that matter are the ones from the form.

- !!! Ensure that you have a firm grasp of the `params` method, as you'll use it fairly regularly. Let's consider an example URL: http://www.example.com/?username=dhh&email=dhh@email.com. In this URL, `params[:username]` would equal "dhh" and `params[:email]` would equal "dhh@email.com".

- If you resubmit the form one more time, you'll see somthing that looks like the following:

```
<ActionController::Parameters {"title"=>"First Article", "text"=>"actually took quite a while, all the markdown writing I'm guessing..."} permitted: false>
```

- The action is now displaying the parameters for the article that are coming from the form.
- However, this isn't really all that helpful. Yes, you can see the parameters but nothing in particular is being done with them.

---

### Creating the Article model:

- Models in Rails use a singular name, and their corresponding database tables use a plural name.
- Rails provides a generator for creating models, which most Rails developers tend to usewhen creating new models.
To create the new model, run the following command:

```
$ bin/rails generate model Article title:string text:text
```

- yields:

```
Running via Spring preloader in process 26943
      invoke  active_record
      create    db/migrate/20180915151319_create_articles.rb
      create    app/models/article.rb
      invoke    test_unit
      create      test/models/article_test.rb
      create      test/fixtures/articles.yml
```

- With that command we told Rails that we want an `Article` model, together with a **title** attribute of type string, and a **text** attribute of type text.
- Those attributes are automatically added to the `articles` table in the database and mapped to the `Article` model.

- Rails responded by creating a bunch of files.
- For now, we're only interested in:
    - `app/models/article.rb` and
    - `db/migrate/20180915151319_create_articles.rb`
- The latter is responsible for creating the database structure, which is what we'll look at next.

- [!!! Active Record is smart enough to automatically map column names to model attributes, which means you don't have to *declare* attributes inside Rails models, as that will be done automatically by Active Record]

---

### Running a Migration:

- As we've just seen, `bin/rails generate model` created a **database migration** file inside the `db/migrate` directory.
- *Migrations* are Ruby classes that are deisgned to make it simple to create and modify database tables.
Rails uses *rake* commands to run migrations, and it's possible to undo a migration after it's been applied to your database.
- Migration filenames include a timestamp to ensure that they're processed in theorder that they were created.

If you look in the `db/migrate/YYYYMMDDHHMMSS_create_articles.rb` file, you should see the following:

```
class CreateArticles < ActiveRecord::Migration[5.0]
    def change
        create_table :articles do |t|
            t.string :title
            t.text :text

            t.timestamps
        end
    end
end
```

- The above migration creates a method named `change` which will be called when you run this migration
- The action defined in this method is also **reversible**, which means Rails knows how to reverse the change made by this migration, in case you want to reverse it later.
- When you run this migration it will create an `articles` tablewith one string column and one text column.
- It also creates two timestamp fields to allow Rails to track both *article creation* and *update* times.

!!! - For more information about migrations, refer to: https://guides.rubyonrails.org/active_record_migrations.html.

At this point, you can run a `bin/rails` command to run the migration:

```
$ bin/rails db:migrate
```
Rails will execute this migration command and tell you it created the *Articles* table:

```
== 20180915151319 CreateArticles: migrating ===================================
-- create_table(:articles)
   -> 0.0009s
== 20180915151319 CreateArticles: migrated (0.0010s) ==========================
```

!!! - Because you're working in the development environment by default, this command will apply to the database defined in the `development` section of your `config/database.yml` file. If you would like execute migrations in another environment, for instance in productionm you must **explicitly** pass it when invoking the command: `bin/rails db:migrate RAILS_ENV=production`.

---
### Saving data in the controller:

- Back in `ArticlesController`, we need to change the `create` action to use the new `Article` model to **save** the data in the database.
- Open `app/controllers/articles_controller.rb` and **change** the `create` action to look like this:

```
def create
    @article = Article.new(params[:article])

    @article.save
    redirect_to @article
end
```

- What's going on?:
    - Every Rails model can be initialised with its respective attributes, which are automatically mapped to the respective database columns.
    - In the first line (above) we do just that (remember that `params[:article]` icontains the attributes we're interested in).
    - Then, `@article.save` is responsible for saving the model in the database.
    - Finally, we redirect the user to the `show` action, which we'll define later...

!!! **Q:** Why is the `A` in `Article.new` capitalised? Most other references to articles in this guide have just used lowercase...

!!! **A:** In this context, we are referring to the **class** named `Article` that is defined in `app/models/article.rb`. Class names in Ruby **MUST** begin with a capital letter.

!!! - As we'll see later, `@article.save` returns a boolean indicating whether the article was saved or not.

- If you now go to http://localhost:3000/articles/new, you'll *almost* be able to actually create an article. Try it! You should get an error like this:

```
ActiveModel::ForbiddenAttributesError in ArticlesController#create
ActiveModel::ForbiddenAttributesError

Extracted source (around line #xx):
        
    def create
        @article = Article.new(params[:article])
```

Rails has several security features that help you write **secure** applications, and you're running into one of them now. This one is called **strong parameters**(https://guides.rubyonrails.org/action_controller_overview.html#strong-parameters), which requires us to tell Rails *exactly* which parameters are allowed into our controller **actions**.

Why do you have to bother?

The ability to grab and automatically assign all controller parameters to your model in one shot makes the programmer's job easier, but this convenience also allows malicious use.

What if a request to a server was crafted to *look* like a new articleform submit but also included extra fields with values that violated your applications integrity?

They would be 'mass assigned' into your model and then into the database along with the good stuff - potentially breaking your application or **worse...**

- We have to **whitelist** our controller parameters to prevent wrongful mass assignment. 
- In this case, we want to both allow and require the `title` and `text` parameters for valid use of `create`.
- The syntax for this introduces `require` and `permit`.
- THe change will involve one line in the `create` action:

```
@article = Article.new(params.require(:article).permit(:title, :text))
```

THis is often factored out into its own method so it can be reused by multiple actions in the same controller, for example `create` and `update`.Above and beyond mass assignment issues, the method is often made `private` to make sure it *can't* be called outside its intended context. Here is the result:

```
def create
    @ article = Article.new(article_params)

    @article.save
    redirect_to @article
end

private
    def article_params
        params.require(:article).permit(:title, :text)
    end
```

!!! - for more information refer to the reference above and this blog article about Strong Parameters: http://weblog.rubyonrails.org/2012/3/21/strong-parameters/

- Try submitting the form, yields error relating to the `show` action for `ArticlesController`

```
Unknown action
The action 'show' could not be found for ArticlesController
```

### Showing Articles:

