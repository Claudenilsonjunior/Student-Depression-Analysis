-- Atualiza os valores da coluna CGPA
UPDATE [Student Depression Dataset]
SET CGPA = 
    CASE 
        -- Se o valor de CGPA for maior ou igual a 100 (indicando que tem 3 dígitos)
        WHEN CGPA >= 100 THEN CGPA / 100  -- Divide por 100 para restaurar o ponto decimal corretamente (ex: 897 se torna 8.97)
        
        -- Caso contrário, assume-se que o valor de CGPA tem apenas 2 dígitos
        ELSE CGPA / 10                    -- Divide por 10 para ajustar o ponto decimal (ex: 59 se torna 5.9)
    END;

-- Atualiza os valores da coluna Age
UPDATE [Student Depression Dataset]
SET Age = Age / 10;  -- Divide os valores da coluna Age por 10 para corrigir a escala (ex: 330 se torna 33)

-- Altera o tipo de dado da coluna Age para inteiro (INT)
ALTER TABLE [Student Depression Dataset]
ALTER COLUMN Age INT;  -- Isso garante que a coluna Age seja tratada como um número inteiro sem casas decimais


-- Verifying Null Values
SELECT
    SUM(CASE WHEN [Gender] IS NULL THEN 1 ELSE 0 END) AS Gender_Null,
    SUM(CASE WHEN [Age] IS NULL THEN 1 ELSE 0 END) AS Age_Null,
    SUM(CASE WHEN [City] IS NULL THEN 1 ELSE 0 END) AS City_Null,
    SUM(CASE WHEN [Profession] IS NULL THEN 1 ELSE 0 END) AS Profession_Null,
    SUM(CASE WHEN [Academic_Pressure] IS NULL THEN 1 ELSE 0 END) AS Academic_Pressure_Null,
    SUM(CASE WHEN [Work_Pressure] IS NULL THEN 1 ELSE 0 END) AS Work_Pressure_Null,
    SUM(CASE WHEN [CGPA] IS NULL THEN 1 ELSE 0 END) AS CGPA_Null,
    SUM(CASE WHEN [Study_Satisfaction] IS NULL THEN 1 ELSE 0 END) AS Study_Satisfaction_Null,
    SUM(CASE WHEN [Job_Satisfaction] IS NULL THEN 1 ELSE 0 END) AS Job_Satisfaction_Null,
    SUM(CASE WHEN [Sleep_Duration] IS NULL THEN 1 ELSE 0 END) AS Sleep_Duration_Null,
    SUM(CASE WHEN [Dietary_Habits] IS NULL THEN 1 ELSE 0 END) AS Dietary_Habits_Null,
    SUM(CASE WHEN [Degree] IS NULL THEN 1 ELSE 0 END) AS Degree_Null,
    SUM(CASE WHEN [Have_you_ever_had_suicidal_thoughts] IS NULL THEN 1 ELSE 0 END) AS Suicidal_Thoughts_Null,
    SUM(CASE WHEN [Work_Study_Hours] IS NULL THEN 1 ELSE 0 END) AS Work_Study_Hours_Null,
    SUM(CASE WHEN [Financial_Stress] IS NULL THEN 1 ELSE 0 END) AS Financial_Stress_Null,
    SUM(CASE WHEN [Family_History_of_Mental_Illness] IS NULL THEN 1 ELSE 0 END) AS Family_History_Null,
    SUM(CASE WHEN [Depression] IS NULL THEN 1 ELSE 0 END) AS Depression_Null
FROM [Student Depression Dataset];

SELECT DISTINCT Sleep_Duration
FROM [Student Depression Dataset];

ALTER TABLE [Student Depression Dataset]
ADD Sleep_Duration_Hours FLOAT;

UPDATE [Student Depression Dataset]
SET Sleep_Duration_Hours = 
    CASE
        WHEN [Sleep_Duration] = 'Less than 5 hours' THEN 4.5
        WHEN [Sleep_Duration] = '5-6 hours' THEN 5.5
        WHEN [Sleep_Duration] = '7-8 hours' THEN 7.5
        WHEN [Sleep_Duration] = 'More than 8 hours' THEN 8.5
        ELSE NULL
    END;


-- What is the average age of students with and without depression?

SELECT 
    Depression,
    AVG(Age) AS Media_Idade
FROM 
    [Student Depression Dataset]
GROUP BY 
    Depression;

-- Is there a significant difference in CGPA between students with depression and without?
SELECT 
    Depression,
    ROUND(AVG(CGPA),2) AS Media_CGPA
FROM 
    [Student Depression Dataset]
GROUP BY 
    Depression;
	
-- Qual a distribuição de gênero em relação à depressão?

SELECT 
    Gender,
    Depression,
    COUNT(*) AS Quantidade
FROM 
    [Student Depression Dataset]
GROUP BY 
    Gender, Depression
ORDER BY 
    Gender, Depression;


-- Do students with depression have less sleep on average?

SELECT 
    Depression,
    ROUND(AVG(Sleep_Duration_Hours),2) AS Media_Sono
FROM 
    [Student Depression Dataset]
GROUP BY 
    Depression;


-- Is there any correlation between eating habits and depression?

SELECT 
    Dietary_Habits,
    Depression,
    COUNT(*) AS Quantidade
FROM 
    [Student Depression Dataset]
GROUP BY 
    Dietary_Habits, Depression
ORDER BY 
    Dietary_Habits, Depression;


-- Are students who feel more academic pressure more likely to develop depression?

SELECT 
    Depression,
    ROUND(AVG(Academic_Pressure),2) AS Media_Pressao_Academica
FROM 
    [Student Depression Dataset]
GROUP BY 
    Depression;


-- What is the average level of satisfaction with the study between the two groups?

SELECT 
    Depression,
    ROUND(AVG(Study_Satisfaction),2) AS Media_Satisfacao_Estudantil
FROM 
    [Student Depression Dataset]
GROUP BY 
    Depression;


-- Professions related to a higher incidence of depression?

SELECT 
    Profession,
    ROUND(AVG(CAST(Depression AS FLOAT)),2) AS Percentual_Depressao
FROM 
    [Student Depression Dataset]
GROUP BY 
    Profession
ORDER BY 
    Percentual_Depressao DESC;

-- What impact does a family history of mental illness have on depression?

SELECT 
    Family_History_of_Mental_Illness,
    ROUND(AVG(CAST(Depression AS FLOAT)),2) AS Percentual_Depressao
FROM 
    [Student Depression Dataset]
GROUP BY 
    Family_History_of_Mental_Illness;
