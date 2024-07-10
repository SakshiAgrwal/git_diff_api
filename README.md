# README

API Documentation
Get a Commit by ID
Endpoint: GET /commits/:id

Description: Retrieves a commit by its ID.
Parameters:
id (path): The SHA of the commit.
owner (query): The owner of the repository.
repo (query): The name of the repository.
Response: JSON representation of the commit.
Get the Diff of a Commit
Endpoint: GET /commits/:id/diff

Description: Retrieves the differences for a commit compared to the previous commit.
Parameters:
id (path): The SHA of the commit.
owner (query): The owner of the repository.
repo (query): The name of the repository.
Response: JSON representation of the file differences.

Endpoints for Commit Differences Application
Get Commit by ID

Route: GET /repositories/:owner/:repository/commits/:oid
Description: Retrieves details about a specific commit identified by its SHA ID (:oid) from a GitHub repository owned by :owner.
Get Commit Diff

Route: GET /repositories/:owner/:repository/commits/:oid/diff
Description: Retrieves the difference (diff) of a specific commit (:oid) compared to its previous commit in a GitHub repository owned by :owner. Returns a list of files with their respective changes (additions, deletions, modifications).
Additional Endpoints (Optional, based on future needs)
These endpoints might be considered for future enhancements or additional functionality:

List Commits

Route: GET /repositories/:owner/:repository/commits
Description: Retrieves a list of commits for a GitHub repository owned by :owner. This endpoint could support pagination and filtering by date range or author.
Compare Commits

Route: GET /repositories/:owner/:repository/compare/:base/:head
Description: Compares two commits (:base and :head) in a GitHub repository owned by :owner. Returns the difference between the two commits, including file changes.
Search Commits

Route: GET /repositories/:owner/:repository/commits/search
Description: Searches for commits in a GitHub repository owned by :owner based on specified criteria such as commit message, author, or date range.
Branches and Tags

Route: GET /repositories/:owner/:repository/branches and GET /repositories/:owner/:repository/tags
Description: Retrieves a list of branches and tags respectively for a GitHub repository owned by :owner. This could support operations related to branch/tag comparisons or specific commit queries.