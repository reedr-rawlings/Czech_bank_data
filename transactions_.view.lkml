view: transactions_ {
  sql_table_name: czech_financial_data.transactions_ ;;

  dimension: account {
    type: number
    sql: ${TABLE}.account ;;
  }

  dimension: account_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: balance {
    type: number
    sql: ${TABLE}.balance ;;
  }

  dimension: bank {
    type: string
    sql: ${TABLE}.bank ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: k_symbol {
    type: string
    sql: ${TABLE}.k_symbol ;;
  }

  dimension: operation {
    label: "Mode of Transaction"
    type: string
    sql: ${TABLE}.operation ;
  }

  dimension: trans_id {
    type: number
    sql: ${TABLE}.trans_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [account.account_id]
  }
}
