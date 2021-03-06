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
    # html: <img src="https://img.icons8.com/plasticine/100/000000/long-arrow-up.png"> ;;
  }

  dimension_group: issued_yymmdd {
    label: "Issued"
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

#   dimension: has_credit_card {
#     type: number
#     sql: CASE WHEN ${type_of_card} IS NULL
#     THEN 0
#     ELSE 1
#     END;;
#   }

  dimension: type_of_card {
    description: "Type of card: Junior, Gold, Classic"
    type: string
    sql: CASE WHEN ${TABLE}.type_of_card IS NULL
    THEN "No Card"
    ELSE ${TABLE}.type_of_card
    END;;
    html:
    <div class="vis">
    <div class="vis-single-value" style="font-size:12px">
    <i class="fa fa-credit-card">&nbsp;</i><font color="#5A2FC2"; font-size:100%><center><b>Card Type:</b>&nbsp; {{ rendered_value }} </font>
    <p style="float:left; font-family: Times, serif;">
    </div>
    </div>;;
   }

  measure: junior_card_qualifier {
    type: count_distinct
    sql: ${client.client_id} ;;
    filters: {
      field: type_of_card
      value: "No Card"
    }
    filters: {
      field: client.age
      value: ">=18 AND <=25"
    }
    filters: {
      field: client.received_cc_invite
      value: "True"
    }
    filters: {
      field: transactionss.transaction_month
      value: "1998-10-01 for 3 months"
    }
    filters: {
      field: clients_cc_facts.average_balance
      value: ">=45000.00"
    }
    drill_fields: [client.id]
  }

  measure: classic_card_qualifier {
    type: count_distinct
    sql: ${client.client_id} ;;
    filters: {
      field: type_of_card
      value: "No Card"
    }
    filters: {
      field: client.age
      value: ">=26 AND <=55"
    }
    filters: {
      field: client.received_cc_invite
      value: "True"
    }
    filters: {
      field: transactionss.transaction_month
      value: "1998-10-01 for 3 months"
    }
    filters: {
      field: clients_cc_facts.average_balance
      value: ">=50000.00"
    }
  }

  measure: gold_card_qualifier_prague {
    type: count_distinct
    sql: ${client.client_id} ;;
    filters: {
      field: type_of_card
      value: "No Card"
    }
    filters: {
      field: client.age
      value: ">=35 AND <=65"
    }
    filters: {
      field: client.district_id
      value: "1"
    }
    filters: {
      field: client.received_cc_invite
      value: "True"
    }
    filters: {
      field: transactionss.transaction_month
      value: "1998-10-01 for 3 months"
    }
    filters: {
      field: clients_cc_facts.average_balance
      value: ">=60000.00"
    }
  }

  measure: gold_card_qualifier {
    type: count_distinct
    sql: ${client.client_id} ;;
    filters: {
      field: type_of_card
      value: "classic"
    }
    filters: {
      field: client.age
      value: ">=26"
    }
    filters: {
      field: client.received_cc_invite
      value: "True"
    }
    filters: {
      field: transactionss.transaction_month
      value: "1998-10-01 for 3 months"
    }
    filters: {
      field: clients_cc_facts.average_balance
      value: ">=60000.00"
    }
  }

  measure: count {
    type: count
    drill_fields: [card_id, type_of_card, district.region, district.district_name]
  }
}
