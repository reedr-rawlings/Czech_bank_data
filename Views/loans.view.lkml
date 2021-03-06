view: loans {
  sql_table_name: czech_financial_data.loans ;;

  dimension: loan_id {
    type: number
    sql: ${TABLE}.loan_id ;;
  }

  dimension: account_id {
    primary_key: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.account_id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
    html:
    <div class="vis">
    <div class="vis-single-value" style="font-size:36px">
    <i class="fa fa-dollar">&nbsp;</i><font color="#5A2FC2"; font-size:200%><center><b>Total Loan:</b>&nbsp; {{ rendered_value }} </font>
    <p style="float:left; font-family: Times, serif;">
    </div>
    </div>;;
  }

#   dimension: contract_finished {
#     type: string
#     sql: ${TABLE}.Contract_Finished ;;
#   }

# What do?
#   dimension: contract_status {
#     type: string
#     sql: ${TABLE}.Contract_Status ;;
#   }

  dimension_group: loans {
    type: time
    datatype: date
    timeframes: [
      date,
      month,
      quarter,
      year
    ]
    sql: PARSE_DATE('%y%m%d', CAST(${TABLE}.date AS STRING)) ;;
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

#   dimension: status_long {
#     type: string
#     sql: ${TABLE}.Status_long ;;
#   }

  measure: count {
    type: count
    drill_fields: [loan_id, account.account_id]
  }
}
