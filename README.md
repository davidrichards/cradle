Cradle
======

This is the beginning of it all, an application that can manage people, events, projects, 
organization and publications.  It is meant to have a limited domain, but many uses.  
Basically, I want to have a central data repository where I can demonstrate 
all things data:

* Big Data or Small Data
* Predictive Analytics
* Data Visualization
* Collection Methods
* Statistics
* NoSQL, Relational or Semantic Data Bases
* Data Reification

The idea, then, is to separate concerns with this little gem.  Have the basic entities
store information.  Create an interface where I can implement a database.  That lets
me plug a database in to a project.  Also create an interface so that I can plug in
a user experience (a web app, a command line interface, a Hypermedia API, whatever).

The performance on this shouldn't suck, but that's not why I'm writing this.  I'm 
writing this so I can demonstrate a concept without having to write a bunch of 
code to store the data, or connect my data storage to my classifiers, or whatever.
Also, theoretically, I should be able to take my demonstration scripts and run them
in different environments to prepare those environments for demonstration as well.

So, in a nutshell, this is a tool primarily to make demonstration easier.  It may
add flexibility in your own data features as well.

Copyright
---------

Copyright (c) 2012 Rainy Day Mind Trust, LLC.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

