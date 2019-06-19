view: loans {
  sql_table_name: czech_financial_data.loans ;;

  dimension: loan_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.loan_id ;;
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

  dimension: contract_finished {
    type: string
    sql: ${TABLE}.Contract_Finished ;;
  }

  dimension: contract_status {
    type: string
    sql: ${TABLE}.Contract_Status ;;
  }

  dimension: date {
    type: number
    sql: ${TABLE}.date ;;
  }

  dimension: duration_year {
    type: number
    sql: ${TABLE}.duration_year ;;
  }

  dimension: monthly_payment {
    type: number
    sql: ${TABLE}.monthly_payment ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_long {
    type: string
    sql: ${TABLE}.Status_long ;;
  }

  measure: count {
    type: count
    drill_fields: [loan_id, account.account_id]
  }
}
