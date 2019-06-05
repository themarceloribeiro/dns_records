A list of hostnames the results should include (optional parameter)
A list of hostnames the results should exclude (optional parameter)

The result must contain all DNS records that have all the hostnames it should include,
but none of the hostnames it should exclude.

The response body must have:

The ID of the matching DNS record
The IP address of the matching DNS record

An array of hostnames associated with the matching DNS records, except for those hostnames excluded by the query, where each hostname record contains:

The hostname

The number of DNS records associated with the hostname

Examples
Assuming the following DNS records and hostnames are stored in the database:

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
