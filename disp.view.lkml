view: disp {
  sql_table_name: czech_financial_data.disp ;;

  dimension: disp_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.disp_id ;;
  }

  dimension: account_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: client_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.client_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [disp_id, account.account_id, client.client_id]
  }
}
