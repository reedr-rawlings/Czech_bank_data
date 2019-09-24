view: transactionss {
  sql_table_name: czech_financial_data.transactionss ;;

  dimension: account {
    type: string
    sql: CAST(${TABLE}.account AS STRING) ;;
  }

  dimension: account_id {
    type: string
    # hidden: yes
    sql: CAST(${TABLE}.account_id AS STRING) ;;
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
#     datatype: date
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
    sql: PARSE_DATE('%y%m%d', CAST(${TABLE}.date AS STRING)) ;;
  }

  dimension: k_symbol {
    #"POJISTNE" insurance payment "SLUZBY" payment for statement
    #"UROK" interest credited "SANKC. UROK" sanction interest if negative balance
    #"SIPO" household "DUCHOD" old-age pension "UVER" loan payment
    description: "Characterization of the transaction"
    type: string
    sql:
      CASE
        WHEN ${TABLE}.k_symbol = "POJISTNE" THEN "insurance payment"
        WHEN ${TABLE}.k_symbol = "SLUZBY" THEN "payment for statement"
        WHEN ${TABLE}.k_symbol = "UROK" THEN "interest credit"
        WHEN ${TABLE}.k_symbol = "SANKC. UROK" THEN "sanction interest if negative balance"
        WHEN ${TABLE}.k_symbol = "SIPO" THEN "household"
        WHEN ${TABLE}.k_symbol = "DUCHOD" THEN "old-age pension"
        WHEN ${TABLE}.k_symbol = "UVER" THEN "loan payment"
        WHEN ${TABLE}.k_symbol IS NULL THEN NUll
        ELSE "check strings"
        END;;
  }

#   dimension: ksymbol_base {
#     sql: ${TABLE}.k_symbol ;;
#   }

  dimension: operation {
    #Translated from Czechian -- "VYBER KARTOU" credit card withdrawal "VKLAD" credit in cash "PREVOD Z UCTU" collection from another bank "VYBER" withdrawal in cash "PREVOD NA UCET" remittance to another bank
    label: "Mode of Transaction"
    type: string
    sql:
      CASE
        WHEN ${TABLE}.operation = "VYBER KARTOU" THEN "credit card withdrawl"
        WHEN ${TABLE}.operation = "VKLAD" THEN "credit in cash"
        WHEN ${TABLE}.operation = "PREVOD Z UCTU" THEN "collection from another bank"
        WHEN ${TABLE}.operation = "VYBER" THEN "withdrawal in cash"
        WHEN ${TABLE}.operation = "PREVOD NA UCET" THEN "remittance to another bank"
        ELSE "check strings"
        END;;
  }

  dimension: trans_id {
    type: number
    sql: ${TABLE}.trans_id ;;
  }

  dimension: transaction_type {
    description: "credit or withdrawal"
    # +/- transaction: "PRIJEM" stands for credit "VYDAJ" stands for withdrawal
    type: string
    sql:
      CASE
        WHEN ${TABLE}.type = "PRIJEM" THEN "Credited"
        WHEN ${TABLE}.type = "VYDAJ" THEN "Debited"
        WHEN ${TABLE}.type = "VYBER" THEN "Withdrawal in cash"
        END;;
  }

#   dimension: base_type {
#     sql: ${TABLE}.type ;;
#   }

  measure: total_balance {
    type: sum
    sql: ${balance} ;;
  }

  measure: current_amount {
    type: sum
    sql: ${amount} ;;
  }

  measure: count {
    type: count
    drill_fields: [account.account_id]
  }
}
