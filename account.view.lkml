view: account {
  sql_table_name: czech_financial_data.account ;;

  dimension: account_id {
    description: "Identification of account"
    primary_key: yes
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension_group: account_creation {
    description: "Date of Created Account"
    type: time
    timeframes: [
      date,
      raw,
      week,
      month,
      fiscal_quarter,
      quarter,
      year
    ]
    sql: ${date_base} ;;
  }

  dimension: date_base {
    hidden: yes
    sql: TIMESTAMP(PARSE_DATE('%y%m%d', CAST(${TABLE}.date AS STRING))) ;;
  }

  dimension: district_id {
    description: "Location of branch"
    type: number
    sql: ${TABLE}.district_id ;;
  }

  dimension: issue_statement_frequency {
    description: "Frequency of statement issuancy; monthly, weekly, after transaction"
    type: string
    sql: ${TABLE}.IssueStatementFrequency ;;
  }

  measure: count {
    type: count
    drill_fields: [account_id, loans.count, orders.count, disp.count, transactions_.count]
  }
}
