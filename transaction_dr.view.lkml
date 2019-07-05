view: transaction_dr {
  derived_table: {
    sql: SELECT  *
    FROM transactionss;;
  }

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
    #Translated from Czechian -- "VYBER KARTOU" credit card withdrawal "VKLAD" credit in cash "PREVOD Z UCTU" collection from another bank "VYBER" withdrawal in cash "PREVOD NA UCET" remittance to another bank
    label: "Mode of Transaction"
    type: string
    sql:
      CASE
        WHEN ${TABLE}.operation == "VYBER KARTOU" THEN "credit card withdrawl"
        WHEN ${TABLE}.operation == "VKLAD" THEN "credit in cash"
        WHEN ${TABLE}.operation == "PREVOD Z UCTU" THEN "collection from another bank"
        WHEN ${TABLE}.operation == "VYBER" THEN "withdrawal in cash"
        WHEN ${TABLE}.operation == "PREVOD NA UCET" THEN "remittance to another bank"
        ELSE "check strings"
        END;;
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
