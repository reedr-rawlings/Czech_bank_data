view: client {
  sql_table_name: czech_financial_data.client ;;

  dimension: client_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.client_id ;;
  }

  dimension: age {
    description: "Age of customer"
    type: number
    sql: ${TABLE}.Age ;;
  }

  dimension: age_group {
    type: tier
    tiers: [20, 30, 40, 50, 60, 70, 80]
    style: integer # the default value, could be excluded
    sql: ${age} ;;
  }

  dimension: birth_number {
    type: number
    sql: ${TABLE}.birth_number ;;
  }

  dimension: birthday {
    description: "Year of birth"
    type: string
    sql: ${TABLE}.Birthday ;;
  }

  dimension: district_id {
    description: "District address for client"
    type: number
    sql: ${TABLE}.district_id ;;
  }

  dimension: sex {
    description: "Female or Male"
    type: string
    sql: ${TABLE}.Sex ;;
  }

  measure: total_clients {
    type: count
    drill_fields: [client_id, disp.count]
  }

  measure: clients_by_card_type {
    type: count
    filters: {
      field: card.type_of_card
      value: "-No Card"
    }
    html:
    <div class="vis">
    <div class="vis-single-value" style="font-size:36px; background-image: linear-gradient(to left, #c679f7, #deb7f7); color:#ffffff">
    <font color="#5A2FC2"; font-size:200%><center><b>Clients with Credit Cards:</b>&nbsp; {{value}} </font>
    <p style="color:#f7f1e9;">{{ customers_with_cards._rendered_value  }} Hold Credit Cards </p>

    <p style="float:left; font-family: Times, serif;">
    <i class="fa fa-minus-square">&nbsp;</i>Junior Cards {{ percent_junior_cards._rendered_value }} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <i class="fa fa-money">&nbsp;</i>Classic Cards {{ percent_classic_cards._rendered_value }} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <i class="fa fa-credit-card">&nbsp;</i>Gold Cards {{ percent_gold_cards._rendered_value }}</p></center>
    </div>
    </div>      ;;
    value_format: "0.00%"
  }

  measure: gold_cards {
    type: count
    hidden: yes
    filters: {
      field: card.type_of_card
      value: "gold"
    }
    value_format: "0.00%"
  }

  measure: no_card {
    type: count
    hidden: yes
    filters: {
      field: card.type_of_card
      value: "No Card"
    }
    value_format: "0.00%"
  }

  measure: all_card {
    type: count
#     hidden: yes
    filters: {
      field: card.type_of_card
      value: "-No Card"
    }
#     value_format: "0.00%"
  }

  measure: percent_gold_cards {
    type: number
    sql: ${gold_cards}/${all_card} ;;
    value_format: "0.00%"
  }

  measure: percent_classic_cards {
    type: number
    sql: ${classic_cards}/${all_card} ;;
    value_format: "0.00%"
  }

  measure: percent_junior_cards {
    type: number
    sql: ${junior_cards}/${all_card} ;;
    value_format: "0.00%"
  }

  measure: customers_with_cards{
    type: number
    sql: ${clients_by_card_type}/${no_card} ;;
    value_format: "0.00%"
  }

  measure: classic_cards {
    type: count
    hidden: yes
    filters: {
      field: card.type_of_card
      value: "classic"
    }
  }

  measure: junior_cards {
    type: count
    hidden: yes
    filters: {
      field: card.type_of_card
      value: "junior"
    }
  }
}
