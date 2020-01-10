# _Volunteer Tracker_

#### _Web application that tracks projects and the volunteers working on them., January 10, 2020_

#### By _**Liam Kenna**_

## Description

_This site is a simple web application that tracks projects and the volunteers working on them. Users are able to:_

* _view, add, update and delete projects_
* _view and add volunteers_
* _connect volunteers to a single project_


## Setup/Installation Requirements

* _Clone to local machine_
* _In project root folder:_
  * _$ bundle install_
  * _If on Windows:_
    * _Find the files app.rb and spec/spec_helper.rb_
    * _Comment out the DB loader for Mac and remove comment from the Windows loader_
    * _Follow the directions in config.rb.template and rename as config.rb_
  * _$ createdb volunteer_tracker_
  * _$ psql volunteer_tracker < database_backup.sql_
  * _$ createdb -T volunteer_tracker volunteer_tracker_test_
  * _$ ruby app.rb_

_To explore the source code, feel free to browse on github or clone to your local machine_

## Known Bugs
_No known bugs at this time._

## Support and contact details
_Any issues or concerns, please email liam@liamkenna.com_

## Technologies Used
_HTML, CSS, Skeleton, Ruby, Sinatra, Postgres_

### License
*This software is available under the MIT License*
Copyright (c) 2020 **_Liam Kenna_**
