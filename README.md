# EDA-for-Zomato-Dataset
Exploratory Data Analysis for Zomato - The online food delivery application is called out with the help of various tools.

##### About Zomato:
Zomato is one of the well-known food delivery app worldwide. It has a strong base is India and next is the United States. Apart from delivery it gives us more information about a restaurant. 
The purpose is to give the end users a clear idea about the restaurants in various parts of the country and make their work easier.

#### KEY STAKEHOLDERS
Stakeholders are either individual, group or organization who are impacted by the output. There are two type of stakeholders. Internal stakeholders and external stakeholders. The key stakeholders are
- Restaurant Owners 
- Platform Owners
- Delivery Professionals
The platform owners charge a certain amount to get the restaurants/restaurant owners registered with them. So when an order is placed through the app the restaurants are notified and the delivery professionals picks it up and delivers to the customer.
  
#### VISION AND GOALS
The objective is to analyze the different restaurants registered with zomato based on the provisions they offer.
The analysis is done to get a clear idea on what are the factors that affect the rating of the restaurant. The factors can be
The location of the restaurant
The cuisine type
The service provided
The value for money etc.

####  TOOLS USED
The tools required to carry out the analysis are,
-	SQL server management studio
-	Visual Studio 2017
-	RStudio
-	Neo4j

### DATA PROCESSED
A descriptive analysis of the restaurants in the United States is carried out.
The data obtained is in a denormalized form and it is organized in the following categories.
-	Restaurants
-	City 
-	Locality
-	Payment methods
-	Ratings
The categories are then placed as separate CSV files.

### RELATIONAL SCHEMA DIAGRAM
The ER diagram is used to sketch the outline of the database in the form of tables. Each table contains unique attributes and each row contains unique data.
Each tables has its own primary key and the relation with the other tables are given by the foreign keys.
In this ER diagram all tables have a one to many relationship with the restaurant table. The relational schema diagram is been created using the SQL server by uploading the CSV files.

### STAR SCHEMA 

Star schema is the data mart architecture model. It contains the facts and the dimension tables.
The dimension tables stores the descriptive values and the fact table contains the foreign keys to all the tables and the measures.

Dimension and fact tables for the zomato data mart are listed below.

Dimension Tables                                                                   
Dim_Restaurant
Dim_Location
Dim_Payment_Method
Dim_Rating
Dim_Date

Fact Tables
Fact_Restaurant_Survey

The Fact table has a grain which gives the aggregate rating and number of votes given for a restaurant located at a particular place which accepts a certain payement method with the specific rating text during a period of time.

### VISUALIZATIONS
Data visualization is the pictorial representation of the data. It helps us to grasp difficult concepts more easier than analyzing it in the form of csv or other file formats.
For the analysis of zomato data mart 4 plots has been created in R Studio.

### REPORTS	
Reports are documents produced as a result of the data analyzed.
Reports Produced:
-	Average cost for two in a restaurant
-	Restaurants in a city based on reviews
-	Service provided in each restaurants
-	Restaurants with the highest ratings
Sample screen shots of the above reports are given below.
These report are done with SSRS (SQL Server Reporting Services) using Visual Studio 2017.

### XML and XSD Schema
XML stores the data and each element is defined using tags. XML documents are usually generated as a part of business process as they contain information that can be valuable in the context of data warehousing. XSD (XML Schema Definition) describes the structure of the data.

### GRAPH DATABASES
Graph database are the same as relational database that represents data in the form of graph. The nodes are the entities and the relations are the joining of the two nodes.
We have used Neo4j, a graph database tool to develop the graphs. We use cypher query to develop the graphs in Neo4j.

### FINAL INSIGHTS
From the analysis done we can come to a conclusion that,
-	Majority of the restaurants have online delivery.
-	Most popular cuisines are bar food, sea foods and pizza.
-	Cost is also considered as a factor for reviews.
-	The restaurants with higher ratings will be charged with lesser commission rates on every order.


