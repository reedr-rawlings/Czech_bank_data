view: client {
  sql_table_name: czech_financial_data.client ;;

  dimension: client_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.client_id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.Age ;;
  }

  dimension: birth_number {
    type: number
    sql: ${TABLE}.birth_number ;;
  }

  dimension: birthday {
    type: string
    sql: ${TABLE}.Birthday ;;
  }

  dimension: district_id {
    type: number
    sql: ${TABLE}.district_id ;;
  }

  dimension: sex {
    type: string
    sql: ${TABLE}.Sex ;;
  }

  measure: count {
    type: count
    drill_fields: [client_id, disp.count]
  }
}
