view: district {
  sql_table_name: czech_financial_data.district ;;

  dimension: average_salary {
    description: "Average customer salary 34 CZK to $1"
    type: number
    sql: ${TABLE}.Average_Salary ;;
  }

  dimension: crimes_95 {
    description: "# of crimes committed in 95"
    type: string
    sql: ${TABLE}.Crimes_95 ;;
  }

  dimension: crimes_96 {
    description: "# of crimes committed in 96"
    type: number
    sql: ${TABLE}.Crimes_96 ;;
  }

  dimension: district_code {
    type: number
    sql: ${TABLE}.District_Code ;;
  }

  dimension: district_name {
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
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: unemployment_95 {
    type: string
    sql: ${TABLE}.Unemployment_95 ;;
  }

  dimension: unemployment_96 {
    type: number
    sql: ${TABLE}.Unemployment_96 ;;
  }

  measure: count {
    type: count
    drill_fields: [district_name]
  }
}
