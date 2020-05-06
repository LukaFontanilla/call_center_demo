include: "//retail_banking/models/retail_banking_explores.lkml"

view: banking_client_facts {
  view_label: "Client"
  derived_table: {
    persist_for: "24 hours"
    explore_source: balances_fact {
      column: balance_yesterday {}
      column: average_daily_balance {}
      column: client_id { field: client.client_id }
      column: account_id { field: account.account_id }
      column: number_of_credit_cards { field: card.number_of_credit_cards }
      filters: {
        field: balances_fact.balance_date
        value: "14 days"
      }
    }
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${client_id},${account_id}) ;;
  }

  dimension: balance_yesterday {
    label: "Balance Balance Yesterday"
    description: "This is the total balance in all accounts yesterday"
    value_format_name: usd
    type: number
  }

  dimension: average_daily_balance {
    label: "Balance Average Daily Balance "
    description: "Over the past two weeks"
    type: number
    value_format_name: usd
  }

  dimension: client_id {
    hidden: yes
    type: number
  }

  dimension: account_id {
    type: number
  }


  dimension: number_of_credit_cards {
    label: "Credit Card Number of Credit Cards"
    type: number
  }

  measure: total_in_accounts_yesterday {
    type: sum
    sql: ${balance_yesterday} ;;
  }

}
