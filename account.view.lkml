view: account {
  sql_table_name: czech_financial_data.account ;;

  dimension: account_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: date {
    type: number
    sql: ${TABLE}.date ;;
  }

  dimension: district_id {
    type: number
    sql: ${TABLE}.district_id ;;
  }

  dimension: issue_statement_frequency {
    type: string
    sql: ${TABLE}.IssueStatementFrequency ;;
  }

  measure: count {
    type: count
    drill_fields: [account_id, loans.count, orders.count, disp.count, transactions_.count]
  }
}
