select Resdet.Restaurant_ID [@Restaurant_ID]
      ,Resdet.Restaurant_Name [Dim_Restaurant/Restaurant_Name]
      ,Resdet.Cuisines [Dim_Restaurant/Cuisines]
      ,Resdet.Has_Table_booking [Dim_Restaurant/Has_Table_booking]
      ,Resdet.Has_Online_delivery [Dim_Restaurant/Has_Online_delivery]
      ,Resdet.Average_Cost_for_two [Dim_Restaurant/Average_Cost_for_two]
	  ,AddDet.City [Dim_Location/CityName]
	  ,AddDet.Address [Dim_Location/Address]
	  ,AddDet.Locality [Dim_Location/Locality]
	  ,AddDet.Latitude [Dim_Location/Latitude]
	  ,AddDet.Longitude [Dim_Location/Longitude]
	  ,PayDet.Accepted_Payment_Methods [Dim_Payment_Method/Accepted_Payment_Methods]
	  ,PayDet.Accepted_currency [Dim_Payment_Method/Accepted_currency]
	  ,RatDet.Rating_color [Dim_Rating/Rating_color]
	  ,RatDet.Rating_text [Dim_Rating/Rating_text]
	  ,dt.date [Dim_Date/Date]
	  ,fact.No_of_Votes [Fact/No_of_Votes]
	  ,fact.Aggregate_Rating [Fact/Aggregate_Rating]
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
	 and dt.Date_id = fact.Date_ID
   FOR XML auto, ELEMENTS, XMLSCHEMA('XsdSchema')