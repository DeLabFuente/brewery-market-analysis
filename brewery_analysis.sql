-- Verificación inicial del dataset
-- Verificación inicial del dataset
SELECT * FROM brewery_data LIMIT 10;

-- Ventas totales por estilo de cerveza
SELECT 
    Beer_Style,
    COUNT(*) AS Total_Lotes,
    ROUND(SUM(Total_Sales), 2) AS Ventas_Totales,
    ROUND(AVG(Total_Sales), 2) AS Venta_Media_Lote,
    ROUND(SUM(Volume_Produced), 2) AS Volumen_Total
FROM brewery_data
GROUP BY Beer_Style
ORDER BY Ventas_Totales DESC;

-- Eficiencia de producción por localización
SELECT 
    Location,
    COUNT(*) AS Total_Lotes,
    ROUND(AVG(Brewhouse_Efficiency), 2) AS Eficiencia_Media,
    ROUND(AVG(Quality_Score), 2) AS Calidad_Media,
    ROUND(SUM(Total_Sales), 2) AS Ventas_Totales
FROM brewery_data
GROUP BY Location
ORDER BY Eficiencia_Media DESC;

-- Calidad media por estilo de cerveza
SELECT 
    Beer_Style,
    ROUND(AVG(Quality_Score), 2) AS Calidad_Media,
    ROUND(AVG(pH_Level), 2) AS pH_Medio,
    ROUND(AVG(Alcohol_Content), 2) AS Alcohol_Medio,
    ROUND(AVG(Bitterness), 2) AS Amargor_Medio,
    COUNT(*) AS Total_Lotes
FROM brewery_data
GROUP BY Beer_Style
ORDER BY Calidad_Media DESC;

-- Análisis de pérdidas en producción
SELECT 
    Beer_Style,
    ROUND(AVG(Loss_During_Brewing), 2) AS Perdida_Elaboracion,
    ROUND(AVG(Loss_During_Fermentation), 2) AS Perdida_Fermentacion,
    ROUND(AVG(Loss_During_Bottling_Kegging), 2) AS Perdida_Embotellado,
    ROUND(AVG(Loss_During_Brewing) + 
          AVG(Loss_During_Fermentation) + 
          AVG(Loss_During_Bottling_Kegging), 2) AS Perdida_Total
FROM brewery_data
GROUP BY Beer_Style
ORDER BY Perdida_Total DESC;

-- Evolución de ventas por año
SELECT 
    STRFTIME('%Y', Brew_Date) AS Año,
    COUNT(*) AS Total_Lotes,
    ROUND(SUM(Total_Sales), 2) AS Ventas_Totales,
    ROUND(AVG(Quality_Score), 2) AS Calidad_Media,
    ROUND(AVG(Brewhouse_Efficiency), 2) AS Eficiencia_Media
FROM brewery_data
GROUP BY Año
ORDER BY Año ASC;

-- Evolución mensual de ventas 2020
SELECT 
    STRFTIME('%m', Brew_Date) AS Mes,
    COUNT(*) AS Total_Lotes,
    ROUND(SUM(Total_Sales), 2) AS Ventas_Totales,
    ROUND(AVG(Quality_Score), 2) AS Calidad_Media
FROM brewery_data
GROUP BY Mes
ORDER BY Mes ASC;

-- Top 10 lotes más rentables
SELECT 
    Batch_ID,
    Beer_Style,
    Location,
    Volume_Produced,
    Total_Sales,
    Quality_Score,
    Brewhouse_Efficiency,
    ROUND(Total_Sales / Volume_Produced, 2) AS Rentabilidad_Por_Litro
FROM brewery_data
ORDER BY Rentabilidad_Por_Litro DESC
LIMIT 10;