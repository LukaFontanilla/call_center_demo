connection: "looker-private-demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "//retail_banking/banking_and_card_views/*.view.lkml"


explore: transcript {
  fields: [ALL_FIELDS*, -client.has_card, -client.has_loan, -client.days_since_account_creation]
  join: transcript__messages {
    sql: LEFT JOIN UNNEST(${transcript.messages}) as transcript__messages ;;
    relationship: one_to_many
  }
  join: agents {
    relationship: many_to_one
    sql_on: ${agents.id} = ${transcript.agent_id} ;;
  }
  join: client {
    relationship: many_to_one
    sql_on: ${agents.id} = ${transcript.agent_id} ;;
  }
  join: satisfaction_ratings {
    view_label: "Satisfaction Survey"
    relationship: one_to_one
    sql_on: ${transcript.conversation_id} = ${satisfaction_ratings.conversation_id};;
  }
}
