view: client_cc_facts_pdt {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT *
      FROM client_cc_facts_dt
      ;;
  }
  dimension: client_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.client_id ;;
  }
  dimension: average_balance {
    label: "Account Average Balance"
    value_format: "0.00"
    type: number
    sql: ${TABLE}.average_balance ;;
  }
  dimension: no_card {
#     value_format: "0.00%"
    type: number
    sql: ${TABLE}.no_card ;;
  }
}
