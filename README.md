<H2>MRT at Northern Taiwan</H2>
Mass Raid Transit is fascinating. Extracting informations from the daily/monthly transportation volume and interpreting it into graphs are so deightful.

This is a practice integrating R and PowerBI, presenting trends and statistics of MRT transportation volume in northern Taiwan.

Please enjoy it and always feel free to reach out to me !

<H3>Data source</H3>
<H4>🚊 Transportation volume</H4>

- [TRTC](https://www.metro.taipei/cp.aspx?n=FF31501BEBDD0136) (Including part of the data from the Circular line)

- [NTMC](https://oas.bas.ntpc.gov.tw/NTPCTRWD/NewPage/Publish.aspx?Mid1=382290000H#) (Including Danhai and Ankeng LRT)

<H4>🚉 Station and line information</H4>

- [TDX](https://tdx.transportdata.tw/api-service/swagger/basic/268fc230-2e04-471b-a728-a726167c1cfc#/) (Lack of transfer information of Danhai and Ankeng LRT)

<H3>ETL</H3>
<H4>⚙️ Automatic download</H4>
Use a batch file to trigger R to delete and download last month's data file of TRTC.<br />
Use APIs as data sources in PowerBI to get station and line informations.

<H4>🔧 Data processing</H4>
Use R to merge all data files of TRTC and make a little adjustments to fit in the relationship with the station dimension data.<br />
Use power query to merge and append data from different APIs.<br />
Use DAX to add measures and columns for visualization.

<H3>🎨Data visualization</H3>

Use bar chart, line chart, cards......and so on to show and use slicers to enhance interactions.
