# If necessary, uncomment the line below to include explore_source.
include: "/Models/czech_bank_data.model.lkml"

view: clients_cc_facts {
  derived_table: {
    explore_source: client {
      column: client_id {}
      column: average_balance { field: transactionss.average_balance }
      column: no_card {}
#       column: junior_card_qualifier { field: card.junior_card_qualifier }

#       bind_all_filters: yes
    }
  }
  dimension: client_id {
    primary_key: yes
    type: number
  }
  dimension: average_balance {
    label: "Account Average Balance"
    value_format: "0.00"
    type: number
  }
  dimension: no_card {
#     value_format: "0.00%"
  type: number
  }

}
