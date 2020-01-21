view: orders_dt {
   derived_table: {
    #datagroup_trigger: new_trigger
    sql: SELECT
    account.district_id  AS account_district_id,
    {% condition account_too %} orders.amount {% endcondition %} AS orders_amount,
    orders.account_id  AS orders_account_id,
    COUNT(DISTINCT orders.bank_to ) AS orders_total_banks
    FROM czech_financial_data.orders  AS orders
    LEFT JOIN czech_financial_data.account  AS account ON orders.account_id = account.account_id

    GROUP BY 1,2,3
    ORDER BY 4 DESC
    LIMIT 500;;
    }

    dimension: account_too {
      type: number
      sql: ${TABLE}.orders_amount ;;
    }

    dimension: account_dist_id {
      primary_key: yes
      sql: ${TABLE}.account_district_id ;;
    }

     dimension: total_banks {
       sql: ${TABLE}.orders_total_banks ;;
     }

    measure: average_banks {
      type: average
      sql: ${total_banks} ;;
    }

  }
