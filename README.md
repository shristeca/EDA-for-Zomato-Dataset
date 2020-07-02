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

![image](https://user-images.githubusercontent.com/52580630/86417390-c270b680-bcc4-11ea-8da8-be2ac1d11682.png)

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

![image](https://user-images.githubusercontent.com/52580630/86417411-d4525980-bcc4-11ea-927d-44750851cc95.png)

### ETL

ETL is the process of Extracting, Transforming and Loading the data from one data source into another source done using a single tool. It is mainly done on SSIS and SSMS platform.

Here we are using SSMS platform where a query is written to implement the tables.

First a table is created using CREATE TABLE command where we specify the attributes to be created within the table.
Next we are inserting values to the attributes through any source using the INSERT INTO statement. Here we are getting the values from the CSV files and adding it into the tables created using the SELECT statement.
 
Below is the SQL query written the create all the dimension and the fact tables.

#### DIM_RATING

```
CREATE TABLE Dim_Rating
(
Rating_ID varchar(30) not null primary key,
Rating_color varchar(30),
Rating_text varchar(30),
)


INSERT Dim_Rating (    
             Rating_ID,  
			 Rating_color,   
			 Rating_text)
SELECT       Rating_ID,  
			 Rating_color,   
			 Rating_text
FROM Rating_Details;
```

#### DIM_PAYMENT_METHOD
```
CREATE TABLE Dim_Payment_Method
(
Payment_ID varchar(30) not null primary key,
Accepted_Payment_Methods varchar(300),
Accepted_Currency varchar(30),
)

INSERT Dim_Payment_Method (
               Payment_ID,
			   Accepted_Payment_Methods,
			   Accepted_Currency)
SELECT Payment_ID,
			   Accepted_Payment_Methods,
			   Accepted_Currency
FROM Payment_Method_Details
```

#### DIM_LOCATION
```
CREATE TABLE Dim_Location (
                Address_ID varchar(30) not null primary key,
                Address varchar(100),
                Locality varchar(300),
                City varchar(300),
				Latitude varchar(30),
				Longitude varchar(30),)


INSERT Dim_Location (
                Address_ID,
                Address,
                Locality,
                City,
				Latitude,
				Longitude)
SELECT ad.Address_ID,
       ad.Address,
                ad.Locality,
                cd.CityName,
				ad.Latitude,
				ad.Longitude 
FROM Address_Details ad
    ,City_Details cd
WHERE ad.City_ID = cd.City_ID
```
#### DIM_RESTAURANT
```
CREATE TABLE Dim_Restaurant
(
Restaurant_ID varchar(30) not null primary key,
Restaurant_Name varchar(300),
Cuisines varchar(700),
Has_Table_booking varchar(300),
Has_Online_delivery varchar(300),
Average_Cost_for_two varchar(300),
)

INSERT Dim_Restaurant
(
Restaurant_ID,
Restaurant_Name,
Cuisines,
Has_Table_booking,
Has_Online_delivery,
Average_Cost_for_two
)
SELECT Restaurant_ID,
Restaurant_Name,
Cuisines,
Has_Table_booking,
Has_Online_delivery,
Average_Cost_for_two
FROM Restaurant_Details
```

#### FACT_RESTAURANT_SURVEY

```
CREATE TABLE Fact_Restaurant_Survey
(
Restaurant_ID varchar(30) not null REFERENCES Dim_Restaurant(Restaurant_ID),
Address_ID varchar(30) not null REFERENCES Dim_Location(Address_ID),
Payment_ID varchar(30) not null REFERENCES Dim_Payment_Method(Payment_ID),
Rating_ID varchar(30) not null REFERENCES Dim_Rating(Rating_ID),
Date_ID int not null REFERENCES Dim_Date(Date_ID),
No_of_Votes int,
Aggregate_Rating float
)

INSERT Fact_Restaurant_Survey(Restaurant_ID,
                              Address_ID,
							  Payment_ID,
							  Rating_ID,
							  Date_ID,
							  No_of_Votes,
							  Aggregate_Rating)
SELECT rd.Restaurant_ID,
       ad.Address_ID,
	   pd.Payment_ID,
	   rad.Rating_ID,
	   dt.Date_ID,
	   rd.Votes,
	   rd.Aggregate_Rating
FROM Restaurant_Details rd,
     Address_Details ad,
	 Payment_Method_Details pd,
	 Rating_Details rad,
	 Dim_Date dt
where rd.address_ID = ad.Address_ID
and rd.payment_ID = pd.Payment_ID
and rd.Rating_ID = rad.Rating_ID
and dt.Date = rd.Date_Analyzed
```

### VISUALIZATIONS
Data visualization is the pictorial representation of the data. It helps us to grasp difficult concepts more easier than analyzing it in the form of csv or other file formats.
For the analysis of zomato data mart 4 plots has been created in R Studio.

#### NO OF RESTAURANTS PROVIDING ONLINE DELIVERY SERVICE

![image](https://user-images.githubusercontent.com/52580630/86417741-e1237d00-bcc5-11ea-8e00-557b9a7e61c0.png)

The graph is plotted for the number of restaurants in a city that has online delivery services. We can say from the graph that most of the cities have restaurants that provide online delivery service. Orlando has the maximum no of restaurants that provides this service. 

#### POPULAR CUISINES IN THE UNITED STATES

![image](https://user-images.githubusercontent.com/52580630/86417746-e7b1f480-bcc5-11ea-9a34-576e4b0b4e22.png)

The bar plot depicts the most popular cuisine in the United States. It shows us the top 10 popular cuisines with the number of restaurants serving it.

#### COST VS RATINGS

![image](https://user-images.githubusercontent.com/52580630/86417750-ebde1200-bcc5-11ea-9094-d990ee0d8d86.png)

A boxplot is done to show the relation between average cost for two and overall rating for the restaurant. The ratings differs from 2-4 for the average cost between 10 and 30. We can notice that as the cost increases the restaurants have been provided with good number of ratings. So the Restaurants with higher rates provides best quality of food and service when compared with the other restaurants.

#### VOTES VS RATING

![image](https://user-images.githubusercontent.com/52580630/86417754-f00a2f80-bcc5-11ea-8985-884ce474395e.png)

A line graph is drawn for the number of votes got and the average rating. The restaurants with lesser votes also have average rating of 4. So the rating does not increases with the number of votes. 

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
A sample output of the graphs got is shown below.

##### Payments -> Restaurants <- Ratings
This graph show the relation between Restaurants, ratings and payments.

![image](https://user-images.githubusercontent.com/52580630/86418049-dcab9400-bcc6-11ea-9c72-cf5b9d2ecc18.png)

##### Restaurants -> City
This graph shows the relation between restaurant and City.

![image](https://user-images.githubusercontent.com/52580630/86418057-e208de80-bcc6-11ea-9794-0095be7b4f81.png)

Finally a table is created using the above relation to get the Restaurant name, Cuisine type, City name and its Aggregate rating based on the rating text.

![image](https://user-images.githubusercontent.com/52580630/86418074-eaf9b000-bcc6-11ea-91a1-6b857440ddc8.png)

### FINAL INSIGHTS
From the analysis done we can come to a conclusion that,
-	Majority of the restaurants have online delivery.
-	Most popular cuisines are bar food, sea foods and pizza.
-	Cost is also considered as a factor for reviews.
-	The restaurants with higher ratings will be charged with lesser commission rates on every order.


