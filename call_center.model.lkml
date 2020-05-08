connection: "looker-private-demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "//retail_banking/banking_and_card_views/*.view.lkml"


explore: transcript {
  fields: [ALL_FIELDS*, -client.has_card, -client.has_loan, -client.days_since_account_creation, -client.number_of_clients_with_loans,
      -client.number_of_clients_with_cards, -client.percent_clients_with_loans, -client.percent_clients_with_cards]
  join: transcript__messages {
    sql: LEFT JOIN UNNEST(${transcript.messages}) as transcript__messages ;;
    relationship: one_to_many
  }
  join: agents {
    relationship: many_to_one
    sql_on: ${agents.id} = ${transcript.agent_id} ;;
  }
  join: client {
    view_label: "Client"
    relationship: many_to_one
    sql_on: ${client.client_id} = ${transcript.client_id} ;;
  }
  join: satisfaction_ratings {
    view_label: "Satisfaction Survey"
    relationship: one_to_one
    sql_on: ${transcript.conversation_id} = ${satisfaction_ratings.conversation_id};;
  }
  join: conversation_facts {
    relationship: one_to_one
    sql_on: ${transcript.conversation_id} = ${conversation_facts.conversation_id};;
  }
  join: banking_client_facts {
    view_label: "Client"
    relationship: one_to_many
    sql_on: ${banking_client_facts.client_id}=${client.client_id} ;;
  }
  join: ngrams {
    fields: []
    type: left_outer
    relationship: one_to_one
    sql_on: ${transcript__messages.message_id} = ${ngrams.message_id} ;;
  }
  join: ngrams__question_gram {
    sql: , UNNEST(${ngrams.question_gram}) as ngrams__question_gram ;;
    relationship: one_to_many
  }
}
