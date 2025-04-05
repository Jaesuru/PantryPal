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

- **Category:** Utility
- **Mobile:** It is mobile-only for Apple devices.
- **Story:**  There is no story.
- **Market:** Casual food enjoyers who are looking to explore in options.
- **Habit:** Daily, anytime!
- **Scope:** Narrow app-- serves one purpose. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

[x] User can see home option where there is a search bar for the main feature of the app-- searching for recipes.
[x] User will also be able to see a variety of random recipes on the home menu just for extra ideas.
[x] User will be able to search and see different results every time.
[x] Users will be able to click on each individual recipes and view detailed information like instructions, ingredients, and other details. 

![Kapture 2025-04-05 at 12 41 31](https://github.com/user-attachments/assets/22c3c684-fc53-4d0a-939a-aa10e28b4882)

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

![pantrypal wireframe](https://github.com/user-attachments/assets/d97240c9-c311-435b-a09f-6993f17e7cf0)

## Schema 


### Models

Recipe
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| idMeal | String | unique id for the meal   |
| strMeal | String | meal name     |
| strMealThumb      | String    | thumbnail/pic
| strInstruction | String | instructions for making |
| strIngredients | String | ingredients for recipe


### Networking

- List of network requests from home screen:
- [GET] https://www.themealdb.com/api/json/v1/1/search.php?s={meal_name}
