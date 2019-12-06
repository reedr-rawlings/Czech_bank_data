view: district {
  sql_table_name: czech_financial_data.district ;;

  # fields for dynamic filtering on dashboard



  # Possible Map - https://github.com/deldersveld/topojson/blob/master/countries/czech-republic/czech-republic-regions.json

  dimension: salary {
    description: "Average customer salary 34 CZK to $1"
    type: number
    sql: ${TABLE}.Average_Salary ;;
  }

  dimension: crimes_95 {
    description: "# of crimes committed in 95"
    type: number
    sql: ${TABLE}.Crimes_95 ;;
  }

  dimension: crimes_96 {
    description: "# of crimes committed in 96"
    type: number
    sql: ${TABLE}.Crimes_96 ;;
  }

  dimension: 96_crime_rate_per_100k {
    description: "The crime rate for 96 per 100,000"
    type: number
    sql: (${crimes_96}/${inhabitants});;
    value_format: "0.00\%"
  }

  dimension: 95_crime_rate_per_100k {
    description: "The crime rate for 96 per 100,000"
    type: number
    sql: SAFE_CAST(${crimes_95} AS float64)/${inhabitants};;
    value_format: "0.00\%"
  }

  dimension: district_code {
    map_layer_name: czech
    type: number
    sql: ${TABLE}.District_Code ;;
  }

  dimension: district_name {
    map_layer_name: czech
    type: string
    sql: ${TABLE}.District_Name ;;
    html: <a href="/explore/czech_bank_data/district?fields=district.region,district.district_name&f[card.issued_yymmdd_year]={{ _filters['card.issued_yymmdd_year'] }}">{{value}}</a> ;;
    link: {
      label: "Drill to LookMLSME"
      url: "https://productday.dev.looker.com/dashboards/474?URI={{ district.region._value }}&Region={{ district.region._value }}&District={{ district.district_name._value }}&Date={{ _filters['card.issued_yymmdd_year'] | url_encode }}"
    }
  }

  dimension: just_prague {
    map_layer_name: prague
    type: string
    sql: ${TABLE}.District_Name ;;
  }

  dimension: pragueallover {
    map_layer_name: tryingprague
    type: string
    sql: ${TABLE}.District_Name ;;
  }

  dimension: entrepeneurs_per_1000 {
    type: number
    sql: ${TABLE}.Entrepeneurs_Per_1000 ;;
  }

  dimension: inhabitants {
    type: number
    sql: ${TABLE}.Inhabitants ;;
  }

  dimension: municipalities_2000_to_9999 {
    type: number
    sql: ${TABLE}.Municipalities_2000_to_9999 ;;
  }

  dimension: municipalities_500_to_1999 {
    type: number
    sql: ${TABLE}.Municipalities_500_to_1999 ;;
  }

  dimension: municipalities_greater_10000 {
    type: number
    sql: ${TABLE}.Municipalities_greater_10000 ;;
  }

  dimension: municipalities_under_500 {
    type: number
    sql: ${TABLE}.Municipalities_Under_500 ;;
  }

  dimension: no_of_cities {
    type: number
    sql: ${TABLE}.no_of_cities ;;
  }

  dimension: ratio_urban_inhabitants {
    type: number
    sql: ${TABLE}.Ratio_Urban_Inhabitants ;;
  }

  dimension: region {
    map_layer_name: czech
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: unemployment_95 {
    type: number
    sql: SAFE_CAST(${TABLE}.Unemployment_95 AS FLOAT64)/100 ;;
    value_format: "0.00%"
  }

  dimension: unemployment_96 {
    type: number
    sql: ${TABLE}.Unemployment_96/100 ;;
    value_format: "0.00%"
  }

  measure: count {
    label: "Count of district"
    type: count
    drill_fields: [district_name, inhabitants, orders.k_symbol]
  }

  measure: average_crime_rate_95 {
    type: average
    sql:  ${95_crime_rate_per_100k}*1.0;;
    value_format: "0.00%"
  }

  measure: average_crime_rate_96 {
    type: average
    sql:  ${96_crime_rate_per_100k}*1.0;;
    value_format: "0.00%"
  }

  measure: average_unemployment_rate_95 {
    type: average
    sql:  ${unemployment_95}*1.0;;
    value_format: "0.00%"
  }

  measure: average_unemployment_rate_96 {
    type: average
    sql:  ${unemployment_96}*1.0;;
    value_format: "0.00%"
  }

  measure: average_salary {
    value_format_name: decimal_2
    type: average
    sql: ${salary} ;;
  }
}
