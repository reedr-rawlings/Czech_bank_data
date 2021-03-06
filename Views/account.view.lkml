view: account {
  sql_table_name: czech_financial_data.account ;;

  dimension: account_id {
    description: "Identification of account"
    primary_key: yes
    type: string
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
      month_num,
      fiscal_quarter,
      quarter,
      year
    ]
    sql: ${date_base} ;;
  }

  dimension: date_parameter {
    label_from_parameter: date_granularity
    sql:
            CASE
             WHEN {% parameter date_granularity %} = 'Day' THEN ${account_creation_date}
             WHEN {% parameter date_granularity %} = 'Month' THEN ${account_creation_month}
             WHEN {% parameter date_granularity %} = 'Quarter' THEN ${account_creation_quarter}
             WHEN {% parameter date_granularity %} = 'Year' THEN ${account_creation_year}
             ELSE NULL
            END ;;
  }

  parameter: date_granularity {
    type: string
    allowed_value: { value: "Day" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
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
    label: "Count of Account IDs"
    type: count
    drill_fields: [account_id, loans.count, orders.count, disp.count, transactions_.count]
    link: {
      label: "Drill to Region"
      url: "https://productday.dev.looker.com/dashboards/463?Region={% if district.region._in_query %}{{district.region._value}}{% else %}{% endif %}"
    }
  }
}
