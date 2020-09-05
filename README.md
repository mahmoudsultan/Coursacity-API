# Coursacity API

RESTful Ruby on Rails API for Courses CRUD operations with Search feature and Course thumbnail preprocessing.

## Installing Dependencies

### Ruby 2.7.1
View instructions on how to install Ruby 2.7.1 and Ruby on Rails 6 on your OS.

For Ubuntu this may be helpful https://gorails.com/setup/ubuntu/20.04

### ImageMagick

Rails depends on ImageMagick for courses photo variant processing.

### Gems
```
bundle install
```

## Development
```
bundle install
rails db:create db:migrate db:seed
rails s -p 3000
```

### Testing
```
bundle exec rspec
```

### Linting
```
bundle exec rubocop
```

## Error Handling
- 422 Unprocessible Entity
```
    {
        "errors":{
            "slug":["has already been taken"]
        }
    }
```
- 404 Resource Not Found
```
    {
        "errors":{
            "resource":["Resource is not found."]
        }
    }
```

## API Endpoints
*For full list of endpoints you can also run `bundle exec rails routes`*

### Courses
### GET /courses
- Returns a list of courses the newest first (ordered by `created_at` field)
- Request Arguments:
    - page: Page number 1-indexed
    - per: Number of courses per page
- Returns object with two keys `courses` that contains a list of courses in this page, and `meta` which contains metadata about total courses and pages count.

Example Request:
```
curl 'http://localhost:3000/courses?page=1&per=3'
```

Example Response:
```
{
   "courses":[
      {
         "description":"Veniam dolorum rerum. Corrupti omnis nisi. Debitis sint placeat.",
         "id":10,
         "photo":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--d2a3f46406c3717c6c62dfbc9078aa23c1893b1f/ProvideX.jpg",
         "slug":"ProvideX-123",
         "title":"Learn ProvideX"
      },
      {
         "description":"Sed consequatur nisi. Iure nostrum id. Ducimus velit omnis.",
         "id":9,
         "photo":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--68d2e400c88f3cd9505da334e3dc0529dca8f6dc/SystemVerilog.jpg",
         "slug":"SystemVerilog-123",
         "title":"Learn SystemVerilog"
      },
      {
         "description":"Molestiae qui reiciendis. Eligendi mollitia dolores. Ratione corporis recusandae.",
         "id":8,
         "photo":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--b808d9eb136909cc1f6557477cc0c2e882f607e3/VSXu.jpg",
         "slug":"VSXu-123",
         "title":"Learn VSXu"
      }
   ],
   "meta":{
      "count":3,
      "total_count":10,
      "total_pages":4
   }
}
```

### GET `/coures/popular`
- Returns a list of popular courses to be displayed on home page (currently returns the 3 most recent courses).
- Example Request:
```
curl http://localhost:3000/courses/popular
```
- Example Response:
```
{
   "courses":[
      {
         "description":"Veniam dolorum rerum. Corrupti omnis nisi. Debitis sint placeat.",
         "id":10,
         "photo":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--d2a3f46406c3717c6c62dfbc9078aa23c1893b1f/ProvideX.jpg",
         "slug":"ProvideX-123",
         "title":"Learn ProvideX"
      },
      {
         "description":"Sed consequatur nisi. Iure nostrum id. Ducimus velit omnis.",
         "id":9,
         "photo":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--68d2e400c88f3cd9505da334e3dc0529dca8f6dc/SystemVerilog.jpg",
         "slug":"SystemVerilog-123",
         "title":"Learn SystemVerilog"
      },
      {
         "description":"Molestiae qui reiciendis. Eligendi mollitia dolores. Ratione corporis recusandae.",
         "id":8,
         "photo":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--b808d9eb136909cc1f6557477cc0c2e882f607e3/VSXu.jpg",
         "slug":"VSXu-123",
         "title":"Learn VSXu"
      }
   ],
   "meta":{
      "count":3
   }
}

```
### GET `/courses/search`
- Searches Courses title and returns a paginated list of matches
- Request Arguments:
    - q: Search Query
    - page: Page to fetch (1-indexed)
    - per: Number of matched courses per page
- Example Request:
```
curl 'http://localhost:3000/courses/search?q=mdl&page=1&per=3'
```
- Example Response:
```
{
   "courses":[
      {
         "description":"Voluptatem quae ab. Placeat ut at. Necessitatibus et aliquam.",
         "id":1,
         "photo":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--73ec6df75481e69eaade9e20ef34273f7873e9fe/MDL.jpg",
         "slug":"MDL-123",
         "title":"Learn MDL"
      }
   ],
   "meta":{
      "count":1,
      "total_count":1,
      "total_pages":1
   }
}
```

### GET `/courses/:id`
- Returns specific course fetched by id.
- Example Request
```
curl http://localhost:3000/courses/8
```
- Example Response:
```
{
   "course":{
      "description":"Molestiae qui reiciendis. Eligendi mollitia dolores. Ratione corporis recusandae.",
      "id":8,
      "photo":"/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--b808d9eb136909cc1f6557477cc0c2e882f607e3/VSXu.jpg",
      "slug":"VSXu-123",
      "title":"Learn VSXu"
   }
}
```

### POST `/courses/`
- Creates a new course, accepts title, description, slug, and photo sent as multipart form data or json.
- Validates that title, description and slug are present, and that slug is uniq.
- **To Create a new course with an image use a multipart form data request with photo.**
- Example Request:
```
curl -X POST http://localhost:3000/courses -H "Content-Type: application/json" -d '{ "title": "New Course", "description": "New Course Description", "slug": "new-slug-123" }'
```
- Example Response:
```
{
    "course":{
        "description":"New Course Description",
        "id":11,
        "photo":"",
        "slug":"new-slug-123",
        "title":"New Course"
    }
}
```
- Errors:
    - 422 Unprocessible Entity:
    ```
    {
        "errors":{
            "slug":["has already been taken"]
        }
    }
    ```


### PUT/PATCH `/courses/:id`
- Updates an existing course.
- Example Request
```
curl -X PATCH http://localhost:3000/courses/11 -H "Content-Type: application/json" -d '{ "title": "Updated Title" }'
```
- Example Request:
```
{
    "course":{
        "description":"New Course Description",
        "id":11,
        "photo":"",
        "slug":"new-slug-123",
        "title":"Updated Title"
    }
}
```
- Errors:
    - 422 Unprocessible Entity
    - 404 Resource Not Found

### DELETE `/courses/:id`
- Example Request:
```
curl -X DELETE http://localhost:3000/courses/11
```
- Example Response: 204 No Content
- Errors:
    - 404 Not Found

## TODOs
-[ ] Allow passing photo as Base64 encoded image in application/json requests.
-[ ] Create and return multiple course image variants instead of only two (thumbnail and originl).
