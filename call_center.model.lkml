
include: "dashboards/*.lookml"
connection: "looker-private-demo"
label: "Retail Banking"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/banking_and_card_views/*.view.lkml"

datagroup: call_center_etl {
  sql_trigger: SELECT max(DATE(conversation_start_at)) FROM call_center.transcript_with_messages ;;
  max_cache_age: "24 hours"
}

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
  aggregate_table: simple_rollup {
    query: {
      dimensions: [conversation_duration, conversation_end_date, conversation_start_date, number_of_messages]
      measures: [average_calls_per_agent, average_conversation_duration, average_number_of_messages, count, percent_not_passed_to_live, satisfaction_ratings.average_csat, satisfaction_ratings.percent_conversations_with_survey]
      filters: [transcript.conversation_start_date: "6 months"]
      timezone: "America/Los_Angeles"
    }
    materialization: {
      datagroup_trigger: call_center_etl
    }
  }
}
