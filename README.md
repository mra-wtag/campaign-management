# Campaign Management System

### This project is still under construction.
## TODO List
- RSpec test for models
- RSpec test for services
- RSpec test for REST API Ednpoints
- RSpec Integration Test for all API Endpoints
- Adding sorting and filtering to Campaign List API
- Some more functionalities
- Dockerization

## About It
This is a Campaign Management System API with which you can List Down all campaigns, see the details of any 
specific campaign and invest on any campaign. 
- [How to Setup](#how-to-setup)
- [API Documentation](#api-documentation)

## How to Setup
Run the following command to setup the project from scratch:
1. `bundle install`
2. `cp config/database.example.yml config/database.yml`
3. `touch log/api_tracker.log`
3. `bundle exec rake db:create`
4. `bundle exec rake db:migrate`
5. `bundle exec rake db:seed`

## API Documentation
Once the setup is done, the System is ready to serve the REST API. Please
use Postman or any REST Client to test the API.

### List of API
* `GET /api/ping`
* `GET /api/campaigns`
* `POST /api/investments`
* `GET /api/campaigns/:campaign_uuid`

### Authentication
For the time being no Authentication has been implemented. I have the plan
to implement OAuth 2 with doorkeeper later.

### Versioning
For the time being no versioning has been implemented.

### Pagination
Every API endpoint which returns multiple entities has pagination enabled.

###### Request
The API consumer is able to specify how many entities and which page should be returned.

Parameter | Description
--- | ---
`per_page` | The number of elements that will be returned on one page (max: 250, default: 50)
`page` | The page which should be returned (default: 1)

###### Response
The pagination details are exposed as HTTP headers in the response.

Parameter | Description
--- | ---
`X-Total` | The total number of entities in this collection
`X-Per-Page` | The number of elements per page
`X-Total-Pages` | Based on `X-Per-Page`, the number pages that will be returned
`X-Page` | The current page number returned
`X-Next-Page` | The next page number, if available

### Transaction Tracking
All the API Request are being tracked and logged in the below project file:
```
Root => log/api_tracker.log
```

### Ping
###### Endpoint
```json
GET /api/ping
Example: localhost:3000/api/ping
```

###### Headers
```json
N/A
```

###### URL Params
```json
N/A
```

###### Request Body
```json
N/A
```

###### Response Body
```json
{
    "pong": "2022-07-22T02:30:36.157+06:00"
}
```

###### Response Parameters
Key | Type | Description
--- | --- | ---
`pong` | String | Current Date with Time and Zone

### All Campaigns
###### Endpoint
```json
GET /api/campaigns
Example: localhost:3000/api/campaigns
```

###### Headers
```json
N/A
```

###### URL Params
```json
page=1&per_page=250
Example: localhost:3000/api/campaigns?page=1&per_page=250
```

###### Request Body
```json
N/A
```

###### Response Body
```json
[
    {
        "id": "d6d1b185-41b7-4cd4-9275-fd1a160054fc",
        "name": "Campaign 1",
        "image_url": "https://base_url/campaign_1.png",
        "percentage_raised": "2.5",
        "target_amount": "2525.0",
        "sector": "common",
        "country_code": "GB",
        "investment_multiple": "7.35"
    },
    {
        "id": "1190649d-fb63-4396-a022-26b16ddfb9a6",
        "name": "Campaign 2",
        "image_url": "https://base_url/campaign_2.png",
        "percentage_raised": "56.0",
        "target_amount": "2550.0",
        "sector": "common",
        "country_code": "GB",
        "investment_multiple": "9.45"
    }
]
```

###### Response Parameters
Key | Type | Description
--- | --- | ---
`id` | UUID | The unique id of the Campaign
`name` | String | Name of the Campaign
`image_url` | String | Image Url of the Campaign
`percentage_raised` | String | Percentage of already Invested Amount in regards of Target
`target_amount` | String | Target Amount for this Campaign
`sector` | String | Campaign Sector
`country_code` | String | Two Letter ISO Country Code. Eg. `GB`
`investment_multiple` | String | Investment Multiple accepted by the Campaign. If the Investment Multiple is 4.97 GBP, then the user can only invest 4.97 GBP, 9.94 GBP and so on.


### Create Investment
###### Endpoint
```json
POST /api/investments
Example: localhost:3000/api/investments
```

###### Headers
```json
N/A
```

###### URL Params
```json
N/A
```

###### Request Body
```json
{
    "user_email": "mail@mail.com",
    "amount": 7.35,
    "campaign_id": "d6d1b185-41b7-4cd4-9275-fd1a160054fc"
}
```

###### Request Parameters
Parameter | Required | Description
--- | --- | ---
`user_email` | ✔ | Investor Email Address
`amount` | ✔ | Invested Amount
`campaign_id` | ✔ | Id of the Campaign where Investor is Investing

###### Response Body - Error
```json
Example 01:
{
    "status": 422,
    "message": "User Email is Invalid"
}

Example 02:
{
    "status": 422,
    "message": "Amount Invalid. Amount Must be multiple of 7.35 GBP.For Example: 7.35 GBP or 14.7 GBP and so on..."
}

Example 03:
{
    "status": 422,
    "message": "Amount crossed the Target Amouont of this Campaign. Available investment amount is 2525.0 GBP"
}

Example 04:
{
    "status": 422,
    "message": "Campaign Id Invalid. Please provide a valid Campaign Id"
}

And many more
```

###### Response Parameters
Key | Type | Description
--- | --- | ---
`status` | Integer | HTTP Error Status Code
`message` | String | Error/Validation Message

###### Response Body - Successful
```json
{
    "id": "46de9433-89fd-4462-b6fd-40b3d40e6d5f",
    "investor_email": "mail@mail.com",
    "amount": "7.35",
    "campaign": {
        "id": "d6d1b185-41b7-4cd4-9275-fd1a160054fc",
        "name": "Campaign 1",
        "image_url": "https://base_url/campaign_1.png",
        "percentage_raised": "0.29",
        "target_amount": "2525.0",
        "sector": "common",
        "country_code": "GB",
        "investment_multiple": "7.35"
    }
}
```

###### Response Parameters
Key | Type | Description
--- | --- | ---
`id` | UUID | Id of the new valid Investment
`investor_email` | String | Email Address of the Investor
`amount` | String | Invested Amount
`campaign` | Object | Campaign details for this investment
`campaign.id` | UUID | The unique id of the Campaign
`campaign.name` | String | Name of the Campaign
`campaign.image_url` | String | Image Url of the Campaign
`campaign.percentage_raised` | String | Updated Percentage of already Invested Amount in regards of Target
`campaign.target_amount` | String | Target Amount for this Campaign
`campaign.sector` | String | Campaign Sector
`campaign.country_code` | String | Two Letter ISO Country Code. Eg. GB
`campaign.investment_multiple` | String | Investment Multiple accepted by the Campaign. If the Investment Multiple is 4.97 GBP, then the user can only invest 4.97 GBP, 9.94 GBP and so on.


### Campaigns by Id
###### Endpoint
```json
GET /api/campaigns/:campaign_uuid
Example: localhost:3000/api/campaigns/d6d1b185-41b7-4cd4-9275-fd1a160054fc
```

###### Headers
```json
N/A
```

###### URL Params
```json
N/A
```

###### Request Body
```json
N/A
```

###### Response Body
```json
{
    "id": "d6d1b185-41b7-4cd4-9275-fd1a160054fc",
    "name": "Campaign 1",
    "image_url": "https://base_url/campaign_1.png",
    "percentage_raised": "0.58",
    "target_amount": "2525.0",
    "sector": "common",
    "country_code": "GB",
    "investment_multiple": "7.35",
    "investments": [
        {
            "id": "46de9433-89fd-4462-b6fd-40b3d40e6d5f",
            "investor_email": "mail@mail.com",
            "amount": "7.35"
        },
        {
            "id": "bb072151-6f84-47e3-ab46-bb0e77b04f0f",
            "investor_email": "mail@mail.com",
            "amount": "7.35"
        }
    ]
}
```

###### Response Parameters
Key | Type | Description
--- | --- | ---
`id` | UUID | The unique id of the Campaign
`name` | String | Name of the Campaign
`image_url` | String | Image Url of the Campaign
`percentage_raised` | String | Updated Percentage of already Invested Amount in regards of Target
`target_amount` | String | Target Amount for this Campaign
`sector` | String | Campaign Sector
`country_code` | String | Two Letter ISO Country Code. Eg. `GB`
`investment_multiple` | String | Investment Multiple accepted by the Campaign. If the Investment Multiple is 4.97 GBP, then the user can only invest 4.97 GBP, 9.94 GBP and so on.
`investments` | Array | All investments for this campaign
`investments.id` | UUID | Id of Investment
`investments.investor_email` | String | Email Address for this investor
`investments.amount` | String | Investment Amount
