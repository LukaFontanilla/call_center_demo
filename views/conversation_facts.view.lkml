
view: conversation_facts {
  view_label: "Conversation"
  derived_table: {
    explore_source: transcript {
      column: conversation_length { field: transcript__messages.total_call_time }
      column: number_of_topics { field: transcript__messages.number_of_topics }
      column: overall_call_sentiment_category { field: transcript__messages.average_sentiment_category }
      column: number_of_categories { field: transcript__messages.number_of_categories }
      column: conversation_id {}
      filters: {
        field: transcript__messages.total_call_time
        value: ">0"
      }
      bind_all_filters: yes
    }
  }

  dimension: number_of_topics {
    group_label: "Intent"
    type: number
  }

  dimension: number_of_categories {
    group_label: "Intent"
    type: number
  }

  dimension: conversation_id {
    primary_key: yes
    hidden: yes
    label: "Conversation Conversation ID"
  }


  dimension: overall_call_sentiment_category {
    type: string
  }

  measure: average_number_of_topics {
    group_label: "Intent"
    type: average
    sql: ${number_of_topics} ;;
    value_format_name: decimal_2
  }

  measure: average_number_of_categories {
    group_label: "Intent"
    type: average
    sql: ${number_of_categories} ;;
    value_format_name: decimal_2
  }
}
