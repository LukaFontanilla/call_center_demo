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
      column: account_created_date { field: account.create_raw }
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
    group_label: "Account Balance"
    label: "Balance Balance Yesterday"
    description: "This is the total balance in all accounts yesterday"
    value_format_name: usd
    type: number
  }

  dimension: average_daily_balance {
    group_label: "Account Balance"
    label: "Balance Average Daily Balance "
    description: "Over the past two weeks"
    type: number
    value_format_name: usd
  }

  dimension: average_daily_balance_tier {
    group_label: "Account Balance"
    value_format_name: usd
    type: tier
    style: integer
    tiers: [1000,2000,5000,10000]
    sql: ${average_daily_balance} ;;
  }


  dimension: client_id {
    hidden: yes
    type: number
    value_format_name: id
  }

  dimension: account_id {
    type: number
    value_format_name: id
    link: {
      label: "Account Overview"
      url: "/dashboards/goGpXFSyjbvdcrPMNAalS8?Account%20ID={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    action: {
      label: "Follow Up with Customer"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Sorry about your experience, {{ client.first_name._value }}"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ client.first_name._value }},

        Thanks for your loyalty to the Look.  We wanted to reach out regarding your recent experience with our Customer Support Center. We are deeply sorry that you did not have a good experience, and wanted to offer you 1 month free of premier support.

        Your friends at the Look"
      }
    }
    action: {
      label: "Send Message to Account Manager"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://image.flaticon.com/icons/svg/1611/1611179.svg"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Hi there  -

        We wanted to quickly reach out and let you know that account {{ value }} called our support center"
      }
    }
    required_fields: [client.first_name]
  }

  dimension: number_of_credit_cards {
    label: "Credit Card Number of Credit Cards"
    type: number
  }

  dimension_group: account_start {
    type: time
    sql: ${TABLE}.account_created_date;;
  }

  measure: total_in_accounts_yesterday {
    type: sum
    sql: ${balance_yesterday} ;;
  }

  measure: high_value_clients {
    type: count_distinct
    description: "High value clients have a daily average balance over $10,000"
    filters: [average_daily_balance: ">10000"]
    sql: ${client_id} ;;
  }

}
