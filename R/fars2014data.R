#' /data/
#' loaded FARS data for year 2014. 
#' `Access the data in `system.file("extdata", "accident_2014.csv.bz2", package="FARSinR")`
#'
#' @source US National Highway Traffic Safety Administration's - Fatality Analysis Reporting System.
#' 
#' @format The class of the data is data frame, with the columns:
#'
#' - STATE      <int>
#' - ST_CASE    <int>
#' - VE_TOTAL   <int>
#' - VE_FORMS   <int>
#' - PVH_INVL   <int>
#' - PEDS       <int>
#' - PERNOTMVIT <int>
#' - PERMVIT    <int>
#' - PERSONS    <int>
#' - COUNTY     <int>
#' - CITY       <int>
#' - DAY        <int>
#' - MONTH      <int>
#' - YEAR       <int>
#' - DAY_WEEK   <int>
#' - HOUR       <int>
#' - MINUTE     <int>
#' - NHS        <int>
#' - ROAD_FNC   <int>
#' - ROUTE      <int>
#' - TWAY_ID    <chr>
#' - TWAY_ID2   <chr>
#' - MILEPT     <int>
#' - LATITUDE   <dbl>
#' - LONGITUD   <dbl>
#' - SP_JUR     <int>
#' - HARM_EV    <int>
#' - MAN_COLL   <int>
#' - RELJCT1    <int>
#' - RELJCT2    <int>
#' - TYP_INT    <int>
#' - WRK_ZONE   <int>
#' - REL_ROAD   <int>
#' - LGT_COND   <int>
#' - WEATHER1   <int>
#' - WEATHER2   <int>
#' - WEATHER    <int>
#' - SCH_BUS    <int>
#' - RAIL       <chr>
#' - NOT_HOUR   <int>
#' - NOT_MIN    <int>
#' - ARR_HOUR   <int>
#' - ARR_MIN    <int>
#' - HOSP_HR    <int>
#' - HOSP_MN    <int>
#' - CF1        <int>
#' - CF2        <int>
#' - CF3        <int>
#' - FATALS     <int>
#' - DRUNK_DR   <int>
"fars2014data"
