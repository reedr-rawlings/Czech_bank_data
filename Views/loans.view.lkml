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
    description: "Duration of loan"
    type: number
    sql: ${TABLE}.duration_year ;;
  }

  dimension: monthly_payment {
    type: number
    sql: ${TABLE}.monthly_payment ;;
  }

  dimension: status {
    description: "Status of contract; either paid or unpaid. Finished or unfinished. "
    type: string
    sql:
      CASE
        WHEN ${TABLE}.status = "A" THEN "Contract Finished: Paid"
        WHEN ${TABLE}.status = "B" THEN "Contract Finished: Unpaid"
        WHEN ${TABLE}.status = "C" THEN "Contract Active: Paid"
        WHEN ${TABLE}.status = "D" THEN "Contract Active: Unpaid"
        ELSE "No Contract"
        END;;
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
