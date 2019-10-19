connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "/Views/*.view"

datagroup: new_trigger {
  max_cache_age: "24 hours"
  sql_trigger: SELECT max(*) FROM czech_financial_data.card ;;
}

datagroup: czech_financial_data_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "48 hour"
}

explore: client {
  extends: [account]
  label: "Credit Card Holders"
  join: disp {
    type: left_outer
    sql_on: ${disp.client_id} = ${client.client_id} ;;
    relationship: one_to_many
  }

  join: account {
    type: left_outer
    sql_on: ${disp.account_id} = ${account.account_id} ;;
  relationship: one_to_many
  }
}



explore: account {
  # persist_with: czech_financial_data_default_datagroup
  join: orders {
    type: left_outer
    sql_on: ${account.account_id} = ${orders.account_id} ;;
    relationship: many_to_one
  }

  join: district {
    type: left_outer
    sql_on: ${account.district_id} = ${district.district_code} ;;
    relationship: many_to_one
  }

  join: transactionss {
    type: left_outer
    sql_on: ${account.account_id} = ${transactionss.account_id} ;;
    relationship: one_to_many
  }

  join: loans {
    type: left_outer
    sql_on: ${account.account_id} = ${loans.account_id} ;;
    relationship: many_to_many
    }

  join: disp {
    type: left_outer
    sql_on: ${account.account_id} = ${disp.account_id} ;;
    relationship: one_to_one
  }

  join: card {
    type: left_outer
    sql_on: ${disp.disp_id} = ${card.disposition_id} ;;
    relationship: one_to_one
  }
}

explore: card {
  join: disp {
    type: left_outer
    sql_on: ${card.disposition_id} = ${disp.disp_id} ;;
    relationship: many_to_one
  }
}


explore: disp {
  join: account {
    type: left_outer
    sql_on: ${disp.account_id} = ${account.account_id} ;;
    relationship: many_to_one
  }

  join: card {
    type: left_outer
    sql_on: ${disp.disp_id} = ${card.card_id} ;;
    relationship: many_to_one
  }

  join: client {
    type: left_outer
    sql_on: ${disp.client_id} = ${client.client_id} ;;
    relationship: many_to_one
  }
}

explore: district {
  join: client {
    type: left_outer
    sql_on: ${district.district_code} = ${client.district_id};;
    relationship: many_to_one
  }

  join: account {
    type: left_outer
    sql_on: ${account.district_id} = ${district.district_code} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${account.account_id} = ${orders.account_id} ;;
    relationship: many_to_one
  }

  join: disp {
    type: left_outer
    sql_on: ${disp.account_id} = ${account.account_id} ;;
    relationship: many_to_one
  }

  join: card {
    type: left_outer
    sql_on: ${card.disposition_id} = ${disp.disp_id} ;;
    relationship: many_to_one
  }
}

explore: loans {
  join: account {
    type: left_outer
    sql_on: ${loans.account_id} = ${account.account_id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: account {
    type: left_outer
    sql_on: ${orders.account_id} = ${account.account_id} ;;
    relationship: many_to_one
  }
  join: orders_dt {
    type: left_outer
    sql_on: ${account.account_id} = ${orders_dt.account_dist_id} ;;
    relationship: one_to_one
  }
}

explore: orders_dt {}

explore: transactionss {
  join: account {
    type: left_outer
    sql_on: ${transactionss.account_id} = ${account.account_id} ;;
    relationship: many_to_one
  }
}



map_layer: czech {
  format: topojson
  file: "/maps/gadm36_CZE_2.json"
}

map_layer: prague {
  format: topojson
  file: "/maps/praguemap.topojson"
}

map_layer: tryingprague {
  format: topojson
  file: "/maps/gadm36_CZE_2copy.json"
}
