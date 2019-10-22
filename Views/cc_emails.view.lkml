include: "/Views/client.view"
# include: "/Views/transaction.view"

view: cc_emails {
 extends: [client]

  dimension: age {
    hidden: yes
    description: "Age of customer"
    type: number
    sql: ${TABLE}.Age ;;
  }

  dimension: junior_cc_signups {
    type: number
    sql: 16 ;;
  }
  dimension: classic_cc_signups {
    type: number
    sql: 23 ;;
  }
  dimension: gold_cc_signups {
    type: number
    sql: 2 ;;
  }

  dimension: age_group {
    hidden: yes
    type: tier
    tiers: [20, 30, 40, 50, 60, 70, 80]
    style: integer # the default value, could be excluded
    sql: ${age} ;;
  }

  dimension: birth_number {
    hidden: yes
    type: number
    sql: ${TABLE}.birth_number ;;
  }

  dimension: birthday {
    hidden: yes
    description: "Year of birth"
    type: string
    sql: ${TABLE}.Birthday ;;
  }

  dimension: opened_email {
    type: string
    sql: CASE WHEN mod(${client_id}, 2) = 1 THEN "opened"
    ELSE "unopened"
    END;;
  }

  dimension: rand_link_click {
    type: number
    sql: RAND();;
  }
  dimension: clicked_signup_link {
    type: number
    sql: CASE WHEN ${opened_email} = "opened" AND RAND() < 0.1 THEN 1
    ELSE 0
    END;;
  }
  measure: click_through_rate_sum {
    hidden: yes
    type: sum
    sql: ${clicked_signup_link} ;;
  }
  measure: click_through_rate_count {
    hidden: yes
    type: count
    #sql: ${clicked_signup_link} ;;
  }
  measure: click_through_rate {
    type: number
    sql: ${click_through_rate_sum}*1.0/${click_through_rate_count}*1.0 ;;
    value_format: "0.00%"
    html:
    <div class="vis">
    <div class="vis-single-value" style="font-size:36px">
    <i class="fa fa-envelope">&nbsp;</i><font color="#5A2FC2"; font-size:200%><center><b>Click Through Rate:</b>&nbsp; {{ rendered_value }} </font>
    <p style="float:left; font-family: Times, serif;">
    </div>
    </div>;;
  }
  measure: percent_gold_cards {
    hidden: yes
    type: number
    sql: ${gold_cards}/${all_card} ;;
    value_format: "0.00%"
    drill_fields: [client_id, transactionss.average_balance, district.district_name, district.region]
  }

  measure: percent_classic_cards {
    hidden: yes
    type: number
    sql: ${classic_cards}/${all_card} ;;
    value_format: "0.00%"
    drill_fields: [district.region, client_id, clients_by_card_type, no_card]
  }

  measure: percent_junior_cards {
    hidden: yes
    type: number
    sql: ${junior_cards}/${all_card} ;;
    value_format: "0.00%"
    drill_fields: [district.region, client_id, clients_by_card_type, no_card]
  }

  measure: customers_with_cards{
    hidden: yes
    type: number
    sql: ${clients_by_card_type}/${no_card} ;;
    value_format: "0.00%"
  }
  #; background-image: linear-gradient(to left, #FFcF40, #ffffff); color:#000000"
}
