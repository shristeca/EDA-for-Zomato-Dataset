library(ggplot2)
library(dplyr)
install.packages("RODBC")
install.packages("tidytext")
library(tidytext)
install.packages("forcats")
install.packages("dplyr")

con<- odbcConnect("Data_US")
ss <- sqlQuery(con, "select * from Dim_Restaurant")

Restaurant_Details <- sqlQuery(con, "select Resdet.Restaurant_ID 
      ,Resdet.Restaurant_Name 
                               ,Resdet.Cuisines 
                               ,Resdet.Has_Table_booking 
                               ,Resdet.Has_Online_delivery 
                               ,Resdet.Average_Cost_for_two
                               ,AddDet.City 
                               ,AddDet.Address 
                               ,AddDet.Locality 
                               ,AddDet.Latitude 
                               ,AddDet.Longitude 
                               ,PayDet.Accepted_Payment_Methods 
                               ,PayDet.Accepted_currency 
                               ,RatDet.Rating_color 
                               ,RatDet.Rating_text
                               ,dt.date
                               ,fact.No_of_Votes 
                               ,fact.Aggregate_Rating 
                               FROM Dim_Restaurant ResDet
                               ,Dim_Location AddDet
                               ,Dim_Payment_Method PayDet
                               ,Dim_Rating RatDet
                               ,Dim_Date dt
                               ,Fact_Restaurant_Survey fact
                               WHERE ResDet.Restaurant_ID = fact.Restaurant_ID
                               and AddDet.Address_id = fact.Address_id
                               and PayDet.Payment_id = fact.Payment_id
                               and RatDet.Rating_id = fact.Rating_id
                               and dt.Date_id = fact.Date_ID")

Restaurant_Details




##Online_Delivery_based_on_City

ggplot(data=Restaurant_Details, aes(City))+
  geom_bar(aes(fill= Has_Online_delivery), position = 'dodge')+coord_flip()



Online_Delivery <-  Restaurant_Details %>%
  select(Restaurant_ID,Has_Online_delivery,City) %>%
  unique() %>%
  group_by(City,Has_Online_delivery) %>%
  summarise(n=n()) %>%
  ungroup() %>%
  rename(`Online Delivery Service`=Has_Online_delivery) %>%
  ggplot(aes(x=reorder(City,n),y=n,fill=`Online Delivery Service`))+
  geom_bar(stat='identity',position = 'dodge',width = 0.5)+
  labs(x='City',y='Number of Restaurants')+coord_flip()

Online_Delivery

#No of Restaurants based on city

  Restaurant_Details %>% 
  select(Restaurant_ID,City) %>%
  unique() %>%
  group_by(City) %>%
  summarise(n=n()) %>%
  ggplot(aes(x=reorder(City,n),y=n))+geom_bar(stat = 'identity',fill='#9370DB')+
  coord_flip()+ labs(x='City',y='Number of Restaurants',title="Number of Restaurants by City")
 
  str(Restaurant_Details)
  
 
 #Popular Cuisines
 p = Restaurant_Details %>%
   select(Restaurant_ID,Cuisines,Average_Cost_for_two) %>%
   unique() %>%
   mutate(Cuisines=as.character(Cuisines)) %>%
   unnest_tokens(ngram,Cuisines,token='ngrams',n=2) %>%
   group_by(ngram) %>%
   summarise(n=n()) %>%
   na.omit() %>%
   arrange(desc(n)) %>%
   top_n(10) %>%
   ggplot(aes(x=reorder(ngram,n),y=n))+geom_bar(stat='identity',fill='#cb202d')+
   labs(x='Cuisine',y='Number of Mentions',title='Popular Cuisines by Mentions')
 
 #Cost Vs Ratings
 boxplot(Aggregate_Rating~Average_Cost_for_two, data=Restaurant_Details,
         main='Cost Vs Rating', xlab='Ratings', ylab='Average Cost')
 
 
#The restaurants with cost 10-30 have wide range of ratings when compared 
#with the restaurants with higher price range. The costly restaurants have 
#ratings when compared with others. As price increases the good rating is given

 #Votes Vs Rating
 ggplot(data=Restaurant_Details, aes(x=Aggregate_Rating, y=No_of_Votes, group=1)) +
   geom_line()+geom_point()
 
 #Eventhough the aggregate ratings are got from the sum of ratings given by a 
#group of customer... even in that case ratings does not increase based on the 
#no of votes. It increases based on the ratings given by the reviewers. So rating 
#does not depend on the no of votes



 

   