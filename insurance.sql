CREATE DATABASE insurance;
-- 1	Show all columns and rows in the table. 
       SELECT * FROM insurance_data;

-- 2. Display the average claim amount for patients in each region.
     SELECT region, ROUND(AVG(claim),2) AS average_amt
      FROM insurance_data
       GROUP BY region;
      
    -- 3. Select the maximum and minimum BMI values in the table.
             SELECT MAX(bmi) AS MAX_BMI_VALUE, MIN(bmi)  AS MIN_BMI_VALUE
             FROM insurance_data;
             
        -- 4. Select the PatientID, age, and BMI for patients with a BMI between 40 and 50.     
				SELECT PatientID, age, bmi
                  FROM insurance_data
                   WHERE bmi BETWEEN 40 AND 50;
                   
            -- 5. Select the number of smokers in each region.
                   SELECT region, COUNT(smoker)
                   FROM insurance_data
                   GROUP BY region;
                   
			-- 6. What is the average claim amount for patients who are both diabetic and smokers? 
                     SELECT PatientID, AVG(claim)
                      FROM insurance_data
                      WHERE diabetic = "Yes" AND smoker = "Yes"
                      GROUP BY PatientID;
                    
               -- 7. Retrieve all patients who have a BMI greater 
				  -- than the average BMI of patients who are smokers
                       SELECT PatientID, bmi, AVG(bmi) AS AVERAGE_BMI, smoker
                       FROM insurance_data
                       GROUP BY PatientID, bmi, smoker
                       HAVING bmi > (SELECT AVG(bmi) FROM insurance_data) AND smoker = "Yes";
                       
                    -- 8. Select the average claim amount for patients in each age group.   
		                      SELECT ROUND(AVG(claim),2) AS average_claim,
                              CASE 
                                  WHEN age < 18 THEN "Under 18"
                                  WHEN age BETWEEN 18 AND 30 THEN "18-30"
                                  WHEN age BETWEEN 31 AND 50 THEN "31-50"
                                  ELSE "Over 50"
                               END AS age_group
                               FROM insurance_data
                               GROUP BY age_group;
                             
		-- 9. Retrieve the total claim amount for each patient, 
		 -- along with the average claim amount across all patients.
				SELECT SUM(claim) OVER(partition by PatientID ) AS total_claim, 
                Round(AVG(claim) OVER(),2) AS avg_claim
                 FROM insurance_data;
                 
	-- 10. Retrieve the top 3 patients with the highest claim amount, along with their 
	-- respective claim amounts and the total claim amount for all patients.
             SELECT PatientID, claim, ROUND(SUM(claim) OVER(),2) AS total_claim
             FROM insurance_data
              ORDER BY claim DESC
              LIMIT 3;
              
      -- 11. Select the details of patients who have a claim amount 
-- greater than the average claim amount for their region.
            SELECT *, AVG(claim) OVER(partition by region) AS avg_claim
            FROM insurance_data
            WHERE claim > (SELECT AVG(claim) FROM insurance_data);
        
      -- 12. Retrieve the rank of each patient based on their claim amount.  
              SELECT PatientID, claim, RANK() OVER(ORDER BY claim DESC) AS rank_number
              FROM insurance_data
              ORDER BY rank_number;
        
     -- 13. Select the details of patients along with their claim amount, 
-- and their rank based on claim amount within their region.
         SELECT PatientID, claim , region, RANK() OVER(PARTITION BY region ORDER BY claim DESC) AS rank_number
         FROM insurance_data;

            
            
            
            
            
            
            
            
            
        
                 
                                
                                
                                
                                
                                
                                
                                
                                
		                      	

                       
                               
            
            
            
            
            
            
            
            
                   