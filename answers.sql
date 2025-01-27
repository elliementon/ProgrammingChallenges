-- Write a query to get the sum of impressions by day.
SELECT marketing_performance.date, SUM(marketing_performance.impressions) as total_impressions
FROM marketing_performance
GROUP BY date;

-- Write a query to get the top three revenue-generating 
-- states in order of best to worst. How much revenue did the 
-- third best state generate? $37,577 in revenue generated by third best state
SELECT website_revenue.state, SUM(website_revenue.revenue) as total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;

-- Write a query that shows total cost, impressions, clicks, 
-- and revenue of each campaign. Make sure to include the campaign 
-- name in the output.
SELECT SUM(marketing_performance.cost) as total_cost, 
 	SUM(marketing_performance.impressions) AS total_impressions, 
    SUM(marketing_performance.clicks) AS total_clicks, 
    SUM(website_revenue.revenue) AS total_revenue, campaign_info.name
 FROM marketing_performance
 INNER JOIN campaign_info
 ON marketing_performance.campaign_id = campaign_info.id
 INNER JOIN website_revenue
 ON website_revenue.campaign_id = campaign_info.id
 GROUP BY campaign_info.name;
 
-- Write a query to get the number of conversions of Campaign 5 
-- by state. Which state generated the most conversions for 
-- this campaign? Georgia generated most conversion for Campaign5
SELECT SUM(marketing_performance.conversions) as total_conversions, 
	campaign_info.name, website_revenue.state
FROM marketing_performance
INNER JOIN campaign_info
ON marketing_performance.campaign_id = campaign_info.id AND
	campaign_info.name = 'Campaign5'
INNER JOIN website_revenue
ON website_revenue.campaign_id = campaign_info.id
GROUP BY state;

-- In your opinion, which campaign was the most efficient, and why?
-- Campaign4 because it has the highest ROI.
SELECT SUM(marketing_performance.cost) as total_cost, 
	campaign_info.name, SUM(website_revenue.revenue) AS total_revenue,
    (SUM(website_revenue.revenue) - SUM(marketing_performance.cost))/SUM(marketing_performance.cost) 
    AS return_on_investment
FROM marketing_performance
INNER JOIN campaign_info
ON marketing_performance.campaign_id = campaign_info.id
INNER JOIN website_revenue
ON website_revenue.campaign_id = campaign_info.id
GROUP BY campaign_info.name;

-- Write a query that showcases the best day of the week 
-- (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
-- which day of week has highest avg. ROI?
SELECT SUM(marketing_performance.cost) as total_cost, 
	SUM(website_revenue.revenue) AS total_revenue, DATENAME(dw, marketing_performance.date) AS day
    (SUM(website_revenue.revenue) - SUM(marketing_performance.cost))/SUM(marketing_performance.cost) 
    AS return_on_investment
FROM marketing_performance
INNER JOIN website_revenue
ON website_revenue.date = marketing_performance.date
GROUP BY date;