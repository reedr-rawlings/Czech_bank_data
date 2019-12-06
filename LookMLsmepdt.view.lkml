view: lookmlsmepdt {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
        issued as issued_string
        , COUNT(*) as lifetime_orders
        , MAX(orders.created_at) as most_recent_purchase_at
      FROM card
      GROUP BY user_id
      WHERE {% condition order_region %} order.region {% endcondition %}
      ;;
  }
}
