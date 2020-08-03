view: client_call_facts {
  view_label: "Client Call Center Stats"
  derived_table: {
    explore_source: transcript {
      column: client_id { field: client.client_id }
      column: count {}
      column: number_of_messages { field: transcript__messages.number_of_messages }
      column: average_sentiment { field: transcript__messages.average_sentiment }
      column: percent_of_messages_with_live_agent { field: transcript__messages.percent_of_messages_with_live_agent }
      column: total_call_time { field: transcript__messages.total_call_time }
      column: average_conversation_duration {}
      column: average_csat { field: satisfaction_ratings.average_csat }
      column: number_surveys_completed { field: satisfaction_ratings.count }
      column: first_conversation_time {}
    }
  }

  dimension: client_id {
    value_format: "0"
    type: number
  }


  dimension: count {
    label: "Number of Conversations"
    type: number
  }

  dimension: number_of_messages {
    label: "Number of Messages"
    type: number
  }

  dimension: average_sentiment {
    label: "Average Sentiment"
    value_format: "#,##0.0%"
    type: number
  }

  dimension: percent_of_messages_with_live_agent {
    label: "Percent of Messages with Live Agent"
    value_format: "#,##0.0%"
    type: number
  }

  dimension: total_call_time {
    label: "Total Call Time"
    description: "The amount of time on calls in hours"
    type: number
  }

  dimension: average_conversation_duration {
    label: "Average Conversation Duration"
    value_format: "#,##0.0"
    type: number
  }

  dimension: average_csat {
    label: "Average CSAT"
    description: "The average customer satisfaction score, on a scale of 1-5 with 1 being Very Unsatisfied"
    value_format: "#,##0.0"
    type: number
  }

  dimension: number_surveys_completed {
    label: "Number of Completed Surveys"
    type: number
  }

  dimension_group: first_conversation {
    label: "Conversation First Conversation Date"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.first_conversation_time ;;
  }
}
