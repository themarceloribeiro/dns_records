Rules and Requirements

- You must include a Readme with instructions on how to run, test, and use the application
- Your assignment is to build an API with two endpoints.

The first endpoint will be used to create DNS records and their associated hostnames. A DNS record may have many hostnames, and a hostname may have many DNS records.

The second endpoint will be used to retrieve those records. You are free to design the API’s structure. The naming of the endpoints and their parameters are not specified, you are free to choose them.
API Endpoint #1
Endpoint #1 creates a DNS record and its associated hostnames. This endpoint should accept an IPv4 IP address and a list of hostnames. The response should return the ID of the DNS record created.
API Endpoint #2
Endpoint #2 returns DNS records and their hostnames. This endpoint should accept:
A list of hostnames the results should include (optional parameter)
A list of hostnames the results should exclude (optional parameter)
A page number (required)

The result must contain all DNS records that have all the hostnames it should include, but none of the hostnames it should exclude.

The response body must have:
The total number of matching DNS records
An array of matching DNS records, where each record contains:
The ID of the matching DNS record
The IP address of the matching DNS record
An array of hostnames associated with the matching DNS records, except for those hostnames excluded by the query, where each hostname record contains:
The hostname
The number of DNS records associated with the hostname
Examples
Assuming the following DNS records and hostnames are stored in the database:
DNS Record 1
IP: 1.1.1.1
Hostnames: lorem.com, ipsum.com, dolor.com, amet.com
DNS Record 2
IP: 2.2.2.2
Hostnames: ipsum.com
DNS Record 3
IP: 3.3.3.3
Hostnames: ipsum.com, dolor.com, amet.com
DNS Record 4
IP: 4.4.4.4
Hostnames: ipsum.com, dolor.com, sit.com, amet.com
DNS Record 5
IP: 5.5.5.5
Hostnames: dolor.com, sit.com

When API endpoint #2 receives the following query:
List of hostnames to be included: ipsum.com, dolor.com
List of hostnames to be excluded: sit.com
Page: 1

Then the response should have:
The total number of matching DNS records: 2
An array of matching DNS records
ID: 1, IP: 1.1.1.1
ID: 3, IP: 3.3.3.3
An array of hostnames associated with the DNS records (lorem.com, ipsum.com, dolor.com, amet.com), excluding any hostnames specified in the query (hostnames to be included: ipsum.com, dolor.com; hostnames to be excluded: sit.com)
Hostname: lorem.com, Number of matching DNS records: 1
Hostname: amet.com, Number of matching DNS records: 2
