view: card {
  sql_table_name: czech_financial_data.card ;;

  dimension: card_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.card_id ;;
  }

  dimension: disposition_id {
    type: number
    sql: ${TABLE}.disposition_id ;;
  }

  dimension: issued {
    type: string
    sql: ${TABLE}.issued ;;
  }

  dimension_group: issued_yymmdd {
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
    sql: ${TABLE}.issued_yymmdd ;;
  }

  dimension: type_of_card {
    type: string
    sql: ${TABLE}.type_of_card ;;
  }

  measure: count {
    type: count
    drill_fields: [card_id]
  }
}
