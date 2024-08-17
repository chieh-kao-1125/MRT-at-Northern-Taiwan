<H2>MRT at Northern Taiwan</H2>
Mass Raid Transit is fascinating. Extracting informations from the daily/monthly transportation volume and interpreting it into graphs are so deightful.

This is a project integrating Batch, R and PowerBI, presenting trends and statistics of MRT transportation volume in northern Taiwan.

Please enjoy it and always feel free to reach out to me !

<H3>Data source</H3>
<H4>🚊 Transportation volume</H4>

- [TRTC](https://www.metro.taipei/cp.aspx?n=FF31501BEBDD0136) (Including part of the data from the Circular line)

- [NTMC](https://oas.bas.ntpc.gov.tw/NTPCTRWD/NewPage/Publish.aspx?Mid1=382290000H#) (Including Danhai and Ankeng LRT)

<H4>🚉 Station and line information</H4>

- [TDX](https://tdx.transportdata.tw/api-service/swagger/basic/268fc230-2e04-471b-a728-a726167c1cfc#/) (Lack of transfer information of Danhai and Ankeng LRT)

<H3>ETL</H3>
<H4>⚙️ Automatic download</H4>

Schedule a task usinig a [batch file](https://github.com/chieh-kao-1125/MRT_at_Northern_Taiwan/blob/main/Automatic%20download/autoTRTC.bat) to trigger [R](https://github.com/chieh-kao-1125/MRT_at_Northern_Taiwan/blob/main/Automatic%20download/TRTC_AutoDownloadFile.R) to delete and download last month's data file of TRTC.<br />
Use APIs as data sources in PowerBI to get station and line informations.

<H4>🔧 Data processing</H4>

Use R to merge all data files of [TRTC](https://github.com/chieh-kao-1125/MRT-at-Northern-Taiwan/blob/main/Data%20processing/TRTC_CodeInPBI.R) and [NTMC](https://github.com/chieh-kao-1125/MRT-at-Northern-Taiwan/blob/main/Data%20processing/NTMC_CodeInPBI.R) and make a little adjustments to fit in the [relationship](https://github.com/chieh-kao-1125/MRT-at-Northern-Taiwan/blob/main/Data_module.JPG) with the station dimension data.<br />
Use power query to merge and append data from different APIs.<br />
Use DAX to add measures, columns, [tables](https://github.com/chieh-kao-1125/MRT-at-Northern-Taiwan/blob/main/Data%20processing/DAX_for_tables.txt), and [parameters](https://github.com/chieh-kao-1125/MRT-at-Northern-Taiwan/blob/main/Data%20processing/DAX_for_parameters.txt) for visualization.

<H3>🎨Data visualization</H3>

Use bar chart, line chart, cards......and so on to show and use slicers to enhance interactions.
