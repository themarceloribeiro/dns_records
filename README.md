### 1. Setup

```
rake db:create; rake db:migrate; rake db:seed; rake db:test:prepare
```

### 2. Run specs

```
rspec spec
```

### 3. Launch server

```
rails s
```

### 4. requests

Make your http requests from rails console:

```
rails c
```

Then

```
data = JSON.parse(RestClient.get("http://localhost:3000/dns_records?page=1&with_hosts=ipsum.com,dolor.com&without_hosts=sit.com").body)
```
