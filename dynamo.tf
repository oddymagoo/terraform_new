resource "aws_dynamodb_table" "hc3_app_content_table_dev" {
  #name         = "hc3-app-content-table-dev"
  name         = "hazchat-3-table-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  #deletion_protection_enabled = "true"
  hash_key = "id"

  attribute {
    name = "createdAt"
    type = "S"
  }
  attribute {
    name = "id"
    type = "S"
  }

  global_secondary_index {
    hash_key        = "createdAt"
    name            = "byCreatedAt"
    projection_type = "ALL"
    read_capacity   = "0"
    write_capacity  = "0"
  }

  point_in_time_recovery {
    enabled                 = true
    recovery_period_in_days = 35
  }

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  table_class      = "STANDARD"

  read_capacity  = 0
  write_capacity = 0

  tags = {
    Environment = "dev"
    Project     = "DynamoTest"
  }
}

#aws_dynamodb_table.hc3_app_content_table_dev
resource "aws_dynamodb_table_item" "example_item" {
  table_name = aws_dynamodb_table.hc3_app_content_table_dev.name
  hash_key   = aws_dynamodb_table.hc3_app_content_table_dev.hash_key

  item = <<ITEM
  {
    "id": {"S": "11111111-2222-3333-4444-555555555555"},
    "createdAt": {"S": "2020-02-02T02:02:02.202Z"},
    "verify": {"M": {
        "createdAt": {"S": "2025-01-21T21:32:49.433Z"},
        "updatedAt": {"S": "2025-01-21T21:32:49.433Z"},
        "verify": {"S": "If the job is not safe"},
        "version": {"N": "1"}
    }},
    "version": {"N": "34"},
    "__typename": {"S": "Hazchat3"},
    "swms": {"L": [
        {"M": {
            "id": {"S": "22FAAAB6-A8A8-B2B2-BE56-012345670002"},
            "letter": {"S": "A"},
            "title": {"S": "Trenching and Excavations"},
            "url": {"S": "swms/R328_Trenching and Excavations SWMS.pdf"}
        }},
        {"M": {
            "id": {"S": "21EAA34C-1234-ABCD-BE34-0242AC121234"},
            "letter": {"S": "A"},
            "title": {"S": "Working On or Near Exposed Live Parts"},
            "url": {"S": "swms/R323_Working On or Near Exposed Live Parts SWMS.pdf"}
        }}
    ]}
  }
  ITEM
}

/*

#Below here is further scratch
##
  item = jsonencode({
    createdAt  = "2020-02-02T02:02:02.202Z",             # Partition key (String)
    id         = "11111111-1111-1111-1111-111111111111", # String
    isDeleted  = false,                                  # Boolean
    version    = 3,                                      #Number
    __typename = "hc3"                                   # String
  })
}




        createdAt = "2020-02-02T02:02:02.202Z", # Partition key (String)
        id = "11111111-1111-1111-1111-111111111111", # String
        customHazardsAndControls = [], #List

-- test stuff
    customHazardsAndControls = [{
      id        = "22222222-2222-2222-2222-222222222222", # String
      createdAt = "2020-02-02T02:02:02.202Z"
      }, {
      id        = "33333333-3333-3333-3333-333333333333", # String
      createdAt = "2020-02-02T02:02:02.202Z"
      }
    ] #List
--
        editors = [], #List
        chatType = "HZCHAT", # String
        hvLiveWork = {}, # Map
        images = [],
        isDeleted = false, # Boolean 
        job = {}, # Map
        jobPeriod = {}, # Map
        lvRequired = {}, # Map
        multiSiteDetails = [], #List
        owner = "azuread_Todd.test@goomba.com", # String
        ownerDisplayName = "Todd Test", # String
        selectHazardsAndControls = [], #List
        sharingStatus = "NOT_SHARED", # String
        smeacs = {}, # Map
        status = "COMPLETE", # String
        swms = [], #List
        team = {}, # Map
        updatedAt = "2020-02-02T02:02:02.202Z", # String
        verify = {}, # Map
        version = 3, #Number
        __typename = "hc3"# String


*/
