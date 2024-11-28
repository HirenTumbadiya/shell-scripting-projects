#!/bin/bash


# Github API URL
API_URL="https://api.github.com"

# Github username and personal access token
USERNAME=$username
TOKEN=$token


# User and Repository information

REPO_OWNER=$1
REPO_OWNER=$2


# Function to make a GET request to the GITHUB API
function github_api_get {
	local endpoint="$1"
	local url="${API_URL}/${endpoint}"

	#Send a GET request to the GITHUB API with authentication
	curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Funtion to list users with read access to the repository
function list_users_with_read_access{
	local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

	# Fetch the list of collaborators on the repository
	collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

	# Display the list of collaborators woth read access
	if [[ -z "$collaborators" ]]; then
		echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
	else
		echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
		echo "$collaborators"
	fi
}

# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
