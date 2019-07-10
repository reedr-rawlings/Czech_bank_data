view: client {
  sql_table_name: czech_financial_data.client ;;

  dimension: client_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.client_id ;;
  }

  dimension: age {
    description: "Age of customer"
    type: number
    sql: ${TABLE}.Age ;;
  }

  dimension: birth_number {
    type: number
    sql: ${TABLE}.birth_number ;;
  }

  dimension: birthday {
    description: "Year of birth"
    type: string
    sql: ${TABLE}.Birthday ;;
  }

  dimension: district_id {
    description: "District address for client"
    type: number
    sql: ${TABLE}.district_id ;;
  }

  dimension: sex {
    description: "Female or Male"
    type: string
    sql: ${TABLE}.Sex ;;
  }

  measure: count {
    type: count
    drill_fields: [client_id, disp.count]
  }
}
