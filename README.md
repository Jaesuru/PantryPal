Original App Design Project -
===

# PantryPal

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

A super duper cool recipe app that users can use to generate and see different recipes based on an ingredient inputted. This gives users a plethora of options when they want to make something for any time of the day.

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Utility
- **Mobile:** It is mobile-only for Apple devices.
- **Story:**  There is no story.
- **Market:** Casual food enjoyers who are looking to explore in options.
- **Habit:** Daily, anytime!
- **Scope:** Narrow app-- serves one purpose. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can see home option where there is a search bar for the main feature of the app-- searching for recipes.
* User will also be able to see a variety of random recipes on the home menu just for extra ideas.
* User will be able to search and see different results every time.
* Users will be able to click on each individual recipes and view detailed information like instructions, ingredients, and other details. 

**Optional Nice-to-have Stories**

* User will be able to input multiple food into the search bar for more specific searches.
* Users will be able to use a filter option to sort out any desirable recipes.

### 2. Screen Archetypes

- [ ] [**Login Screen**]
* Required User Feature: User can log in.
- [ ] [**Home Screen**]
* User can search for recipes, and see random recipes initially too.
- [ ] [**Detailed Recipe Screen**]
* User can select recipe result and view a detailed card about the recipes. 


### 3. Navigation

**Tab Navigation** (Tab to Screen)


- [ ] [First Tab, e.g., Home Feed]
- [ ] [Second Tab, e.g., Favorited Recipes]
- [ ] [Third Tab, e.g., Profile]


**Flow Navigation** (Screen to Screen)

- [ ] [**Login Screen**]
  * Leads to [**Home Screen**]
- [ ] [**Home Screen**]
  * Leads to [**Detailed Recipe View**] 


## Wireframes

[Add picture of your hand sketched wireframes in this section]

## Schema 


### Models

[Model Name, e.g., User]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |
| ...      | ...    | ...                          


### Networking

- [List of network requests by screen]
- [Example: `[GET] /users` - to retrieve user data]
- ...
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
