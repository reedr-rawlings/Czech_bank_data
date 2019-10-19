view: card {
  sql_table_name: czech_financial_data.card ;;

  dimension: card_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.card_id ;;
  }

  dimension: disposition_id {
    description: "Disposition id for a single account"
    hidden: yes
    type: number
    sql: ${TABLE}.disposition_id ;;
  }

  dimension: issued {
    type: string
    sql: ${TABLE}.issued ;;
  }

  dimension_group: issued_yymmdd {
    description: "Time card was issued"
    type: time
    datatype: date
    timeframes: [
      raw,
      date,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.issued_yymmdd ;;
  }

#   dimension: date_base {
#     hidden: yes
#     sql: TIMESTAMP(PARSE_DATE('%Y%m%d', CAST(${TABLE}.issued_yymmdd AS STRING))) ;;
#   }

  dimension: type_of_card {
    description: "Type of card: Junior, Gold, Classic"
    type: string
    sql: CASE WHEN ${TABLE}.type_of_card IS NULL
    THEN "No Card"
    ELSE ${TABLE}.type_of_card
    END;;
   }

  measure: count {
    type: count
    drill_fields: [card_id]
  }
}
