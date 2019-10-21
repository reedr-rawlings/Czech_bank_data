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
    <a href="#drillmenu" target="_self">
    <div class="vis">
    <div class="vis-single-value" style="font-size:36px; background-image: linear-gradient(to left, #FFcF40, #ffffff); color:#000000">
    <font color="#5A2FC2"; font-size:200%><center><b>Clients with Credit Cards:</b>&nbsp; {{ linked_value }} </font>

    <p style="color:#57595d;">{{ customers_with_cards._rendered_value  }} of All Customers Hold Credit Cards </p>

    <p style="float:left; font-family: Times, serif;">
    <i class="fa fa-minus-square">&nbsp;</i>Junior Cards {{ percent_junior_cards._rendered_value }} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <i class="fa fa-money">&nbsp;</i>Classic Cards {{ percent_classic_cards._rendered_value }} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <i class="fa fa-credit-card">&nbsp;</i>Gold Cards {{ percent_gold_cards._linked_value }}</p></center>
    </div>
    </div>
    </a>;;
    value_format: "0"
    #New field with derived table that drills to this set-up
    drill_fields: [client_id, transactionss.average_balance, district.district_name, district.region]
  }

  measure: gold_cards {
    type: count
    hidden: yes
    filters: {
      field: card.type_of_card
      value: "gold"
    }
    value_format: "0.00%"
    drill_fields: [clients_by_card_type, no_card]
  }

  measure: no_card {
    type: count
#     hidden: yes
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
    drill_fields: [client_id, transactionss.average_balance, district.district_name, district.region]
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

  dimension: received_cc_invite {
    hidden: yes
    label: "3 Month CC Invite"
    description: "Results to true if a customer received an invite in the last 3 months"
    type: string
    sql: "True" ;;
  }
}
