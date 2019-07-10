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

  dimension: disposition_type {
    description: "type of disposition (owner/user): only owner can issue permanent orders and ask for a loan"
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [disp_id, account.account_id, client.client_id]
  }
}
