view: orders {
  sql_table_name: czech_financial_data.orders ;;

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: account_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_to {
    type: number
    sql: ${TABLE}.account_to ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: bank_to {
    type: string
    sql: ${TABLE}.bank_to ;;
  }

  dimension: k_symbol {
    type: string
    sql: ${TABLE}.k_symbol ;;
  }

  measure: count {
    type: count
    drill_fields: [order_id, account.account_id]
  }
}
