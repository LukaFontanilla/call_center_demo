include: "dashboards/*.lookml"
connection: "looker-private-demo"
label: "Retail Banking"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/dashboards/*.dashboard"   # include a LookML dashboard called my_dashboard
include: "//retail_banking/banking_and_card_views/client.view.lkml"


explore: transcript {
  label: "(6) Call Center"
  fields: [ALL_FIELDS*, -client.has_card, -client.has_loan, -client.days_since_account_creation, -client.number_of_clients_with_loans,
      -client.number_of_clients_with_cards, -client.percent_clients_with_loans, -client.percent_clients_with_cards]
  join: transcript__messages {
    sql: LEFT JOIN UNNEST(${transcript.messages}) as transcript__messages ;;
    ## flattens the messages array using BQ's unnest function
    relationship: one_to_many
  }
  join: agents {
    type: left_outer
    relationship: many_to_one
    sql_on: ${agents.id} = ${transcript.agent_id} ;;
  }
  join: client {
    view_label: "Client"
    type: left_outer
    relationship: many_to_one
    sql_on: ${client.client_id} = ${transcript.client_id} ;;
  }
  join: satisfaction_ratings {
    view_label: "Satisfaction Survey"
    type: left_outer
    relationship: one_to_one
    sql_on: ${transcript.conversation_id} = ${satisfaction_ratings.conversation_id};;
  }
  join: conversation_facts {
    type: left_outer
    relationship: one_to_one
    sql_on: ${transcript.conversation_id} = ${conversation_facts.conversation_id};;
  }
  join: banking_client_facts {
    view_label: "Client"
    type: left_outer
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
  join: client_call_facts {
    type: left_outer
    sql_on: ${client.client_id} = ${client_call_facts.client_id} ;;
    relationship: one_to_one
  }
}
