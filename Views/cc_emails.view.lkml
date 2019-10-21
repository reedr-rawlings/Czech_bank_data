include: "/Views/client.view"
view: cc_emails {
 extends: [client]

  dimension: client_id {
    primary_key: yes
    type: number
    sql: ${client.client_id} ;;
  }

  dimension: opened_email {
    type: number
    sql: CASE WHEN mod(${client_id}, 3) = 2 THEN "opened"
    ELSE "unopened"
    END;;
  }
  dimension: rand_link_click {
    type: number
    sql: RAND(2);;
  }
  dimension: clicked_signup_link {
    type: number
    sql: CASE WHEN ${opened_email} = "opened" AND RAND(2)  ;;
  }

}

# view: cc_emails {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
