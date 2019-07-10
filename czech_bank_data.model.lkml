connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: czech_financial_data_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "48 hour"
}

persist_with: czech_financial_data_default_datagroup


explore: account {
  join: orders {
    type: left_outer
    sql_on: ${account.account_id} = ${orders.account_id} ;;
    relationship: many_to_one
  }

  join: transactionss {
    type: left_outer
    sql_on: ${account.account_id} = ${transactionss.account_id} ;;
    relationship: many_to_one
  }

  join: loans {
    type: left_outer
    sql_on: ${account.account_id} = ${loans.account_id} ;;
    relationship: many_to_one
  }
}

explore: card {
  join: disp {
    type: left_outer
    sql_on: ${card.disposition_id} = ${disp.disp_id} ;;
    relationship: many_to_one
  }
}

explore: client {
  join: disp {
    type: left_outer
    sql_on: ${client.client_id} = ${disp.client_id} ;;
    relationship: many_to_one
  }
  join: district {
    type: left_outer
    sql_on: ${client.district_id} = ${district.district_code} ;;
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

explore: district {}

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
}

explore: transactionss {
  join: account {
    type: left_outer
    sql_on: ${transactionss.account_id} = ${account.account_id} ;;
    relationship: many_to_one
  }
}
